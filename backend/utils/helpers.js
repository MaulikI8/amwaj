const slugify = require('slugify');

// Generate URL-friendly slug
const createSlug = (text) => {
    return slugify(text, { lower: true, strict: true, trim: true });
};

// Generate unique order number
const generateOrderNumber = () => {
    const timestamp = Date.now().toString(36).toUpperCase();
    const random = Math.random().toString(36).substring(2, 6).toUpperCase();
    return `ORD-${timestamp}-${random}`;
};

// Paginate helper
const paginate = (query) => {
    let page = parseInt(query.page) || 1;
    let limit = parseInt(query.limit) || 10;
    if (page < 1) page = 1;
    if (limit < 1) limit = 10;
    if (limit > 100) limit = 100;
    const offset = (page - 1) * limit;
    return { page, limit, offset };
};

// Build pagination metadata
const paginationMeta = (total, page, limit) => {
    const totalPages = Math.ceil(total / limit);
    return {
        total,
        page,
        limit,
        totalPages,
        hasNextPage: page < totalPages,
        hasPrevPage: page > 1
    };
};

// Success response
const successResponse = (res, data, message = 'Success', statusCode = 200) => {
    return res.status(statusCode).json({
        success: true,
        message,
        ...data
    });
};

// Parse price string like "QAR230.00" to number
const parsePrice = (priceStr) => {
    if (typeof priceStr === 'number') return priceStr;
    const cleaned = priceStr.replace(/[^0-9.]/g, '');
    return parseFloat(cleaned) || 0;
};

module.exports = {
    createSlug,
    generateOrderNumber,
    paginate,
    paginationMeta,
    successResponse,
    parsePrice
};
