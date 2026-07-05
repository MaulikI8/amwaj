const { Product, Category, Image, Inventory } = require('../models');
const { createSlug } = require('../utils/helpers');

/**
 * Parse CSV text into array of objects.
 * Handles quoted fields with commas and newlines inside.
 */
function parseCSV(text) {
    const lines = [];
    let current = '';
    let inQuotes = false;

    for (let i = 0; i < text.length; i++) {
        const ch = text[i];
        if (ch === '"') {
            if (inQuotes && text[i + 1] === '"') {
                current += '"';
                i++; // skip escaped quote
            } else {
                inQuotes = !inQuotes;
            }
        } else if (ch === '\n' && !inQuotes) {
            if (current.trim()) lines.push(current);
            current = '';
        } else if (ch === '\r' && !inQuotes) {
            // skip carriage return
        } else {
            current += ch;
        }
    }
    if (current.trim()) lines.push(current);

    if (lines.length < 2) return [];

    // Parse header
    const headers = splitCSVLine(lines[0]).map(h => h.trim().toLowerCase().replace(/\s+/g, '_'));

    // Parse rows
    const rows = [];
    for (let i = 1; i < lines.length; i++) {
        const values = splitCSVLine(lines[i]);
        const row = {};
        headers.forEach((h, idx) => {
            row[h] = values[idx] !== undefined ? values[idx].trim() : '';
        });
        rows.push(row);
    }
    return rows;
}

function splitCSVLine(line) {
    const result = [];
    let current = '';
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
        const ch = line[i];
        if (ch === '"') {
            if (inQuotes && line[i + 1] === '"') {
                current += '"';
                i++;
            } else {
                inQuotes = !inQuotes;
            }
        } else if (ch === ',' && !inQuotes) {
            result.push(current);
            current = '';
        } else {
            current += ch;
        }
    }
    result.push(current);
    return result;
}

/**
 * POST /api/v1/admin/import-csv
 * Accepts multipart form with a CSV file named 'csv'
 * CSV columns: name, description, price, discount_price, sku, category, quantity, image_url, featured, best_selling
 */
const importCSV = async (req, res, next) => {
    try {
        if (!req.file) {
            return res.status(400).json({ success: false, message: 'No CSV file uploaded.' });
        }

        const csvText = req.file.buffer.toString('utf-8');
        const rows = parseCSV(csvText);

        if (rows.length === 0) {
            return res.status(400).json({ success: false, message: 'CSV file is empty or has no data rows.' });
        }

        // Validate required columns
        const requiredCols = ['name', 'price'];
        const sampleRow = rows[0];
        const missingCols = requiredCols.filter(c => !(c in sampleRow));
        if (missingCols.length > 0) {
            return res.status(400).json({
                success: false,
                message: `Missing required CSV columns: ${missingCols.join(', ')}. Required: name, price.`
            });
        }

        const results = { created: 0, updated: 0, errors: [] };

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const rowNum = i + 2; // +2 because row 1 is header, data starts at 2

            try {
                const name = row.name;
                if (!name) {
                    results.errors.push(`Row ${rowNum}: Missing product name, skipped.`);
                    continue;
                }

                const price = parseFloat(row.price);
                if (isNaN(price)) {
                    results.errors.push(`Row ${rowNum}: Invalid price "${row.price}", skipped.`);
                    continue;
                }

                // Handle category lookup/creation
                let categoryId = null;
                if (row.category && row.category.trim()) {
                    const catName = row.category.trim();
                    const catSlug = createSlug(catName);
                    const [category] = await Category.findOrCreate({
                        where: { slug: catSlug },
                        defaults: { name: catName, slug: catSlug, is_active: true, position: 0 }
                    });
                    categoryId = category.id;
                }

                // Generate slug (append SKU or index for uniqueness)
                let slug = createSlug(name);
                const skuVal = row.sku ? row.sku.trim() : null;
                if (skuVal) {
                    slug = slug + '-' + createSlug(skuVal);
                }

                // Check if product exists by slug or SKU
                let product = null;
                if (skuVal) {
                    product = await Product.findOne({ where: { sku: skuVal } });
                }
                if (!product) {
                    product = await Product.findOne({ where: { slug: slug } });
                }

                const discountPrice = row.discount_price ? parseFloat(row.discount_price) : null;
                const featured = row.featured ? ['true', '1', 'yes'].includes(row.featured.toLowerCase()) : false;
                const bestSelling = row.best_selling ? ['true', '1', 'yes'].includes(row.best_selling.toLowerCase()) : false;
                const topRated = row.top_rated ? ['true', '1', 'yes'].includes(row.top_rated.toLowerCase()) : false;

                if (product) {
                    // Update existing
                    await product.update({
                        name,
                        description: row.description || product.description,
                        price,
                        discount_price: discountPrice,
                        sku: skuVal || product.sku,
                        category_id: categoryId || product.category_id,
                        featured,
                        best_selling: bestSelling,
                        top_rated: topRated,
                        meta_title: row.meta_title || name,
                        meta_description: row.meta_description || row.description || '',
                        is_active: true
                    });
                    results.updated++;
                } else {
                    // Create new
                    product = await Product.create({
                        name,
                        slug,
                        description: row.description || '',
                        price,
                        discount_price: discountPrice,
                        sku: skuVal,
                        category_id: categoryId,
                        featured,
                        best_selling: bestSelling,
                        top_rated: topRated,
                        meta_title: row.meta_title || name,
                        meta_description: row.meta_description || row.description || '',
                        is_active: true
                    });
                    results.created++;
                }

                // Handle inventory
                const quantity = row.quantity ? parseInt(row.quantity) : 0;
                const [inv, invCreated] = await Inventory.findOrCreate({
                    where: { product_id: product.id },
                    defaults: { product_id: product.id, quantity, low_stock_threshold: 5 }
                });
                if (!invCreated) {
                    await inv.update({ quantity });
                }

                // Handle image URL
                if (row.image_url && row.image_url.trim()) {
                    const existingImg = await Image.findOne({
                        where: { product_id: product.id, is_primary: true }
                    });
                    if (existingImg) {
                        await existingImg.update({ url: row.image_url.trim(), alt_text: name });
                    } else {
                        await Image.create({
                            product_id: product.id,
                            url: row.image_url.trim(),
                            alt_text: name,
                            is_primary: true,
                            position: 0
                        });
                    }
                }

            } catch (rowErr) {
                results.errors.push(`Row ${rowNum}: ${rowErr.message}`);
            }
        }

        res.json({
            success: true,
            message: `Import completed. ${results.created} created, ${results.updated} updated.`,
            data: results
        });
    } catch (err) {
        next(err);
    }
};

/**
 * GET /api/v1/admin/csv-template
 * Returns a downloadable CSV template
 */
const downloadTemplate = (req, res) => {
    const headers = 'name,description,price,discount_price,sku,category,quantity,image_url,featured,best_selling,top_rated,meta_title,meta_description';
    const sampleRow = 'Sample Product,"A great product description",29.99,24.99,SKU-001,Electronics,50,https://example.com/image.jpg,false,false,false,Sample Product,A great product';
    const csv = headers + '\n' + sampleRow + '\n';

    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', 'attachment; filename=amwaj-product-import-template.csv');
    res.send(csv);
};

module.exports = { importCSV, downloadTemplate };
