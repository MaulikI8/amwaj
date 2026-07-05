-- PostgreSQL import for Amwaj products
-- Run this against the website database. It upserts categories/products/inventory and replaces product image rows.
BEGIN;

-- 3DS Max Plan 47-1001
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3DS Max Plan 47-1001',
    '3ds-max-plan-47-1001',
    'BEDROOM : 5 Rooms',
    480.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1001',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3DS Max Plan 47-1001',
    'BEDROOM : 5 Rooms SQUARE FEET : 1625 REFRENCE: : 47-1001',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3DS Max Plan 47-1001', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2828d9cff1c.webp', '3DS Max Plan 47-1001', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1002
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1002',
    '3ds-max-plan-47-1002',
    'BEDROOM : 7 Rooms',
    1578.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1002',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1002',
    'BEDROOM : 7 Rooms SQUARE FEET : 3550 REFRENCE: : 47-1002',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1002', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2828382521a.webp', '3Ds Max Plan 47-1002', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1003
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1003',
    '3ds-max-plan-47-1003',
    '47-1003',
    1166.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1003',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1003',
    '47-1003 SQUARE FEET : 2730 REFRENCE: : 47-1003',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1003', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2827bc1b4a0.webp', '3Ds Max Plan 47-1003', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1004
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1004',
    '3ds-max-plan-47-1004',
    'BEDROOM : 4 Rooms',
    343.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1004',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1004',
    'BEDROOM : 4 Rooms SQUARE FEET : 1050 REFRENCE: : 47-1004',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1004', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a282717039c1.webp', '3Ds Max Plan 47-1004', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1005
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1005',
    '3ds-max-plan-47-1005',
    'BEDROOM : 4 Rooms SQUARE FEET : 1170 REFRENCE: : 47-1005',
    411.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1005',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1005',
    'BEDROOM : 4 Rooms SQUARE FEET : 1170 REFRENCE: : 47-1005',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1005', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2826a25e7f2.webp', '3Ds Max Plan 47-1005', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1006
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1006',
    '3ds-max-plan-47-1006',
    'BEDROOM : 8 Rooms',
    1921.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1006',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1006',
    'BEDROOM : 8 Rooms SQUARE FEET : 4480 REFRENCE: : 47-1006',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1006', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28260e10a2f.webp', '3Ds Max Plan 47-1006', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1007
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1007',
    '3ds-max-plan-47-1007',
    'BEDROOM : 5 Rooms',
    617.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1007',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1007',
    'BEDROOM : 5 Rooms SQUARE FEET : 1635 REFRENCE: : 47-1007',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1007', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27e48f18dbb.webp', '3Ds Max Plan 47-1007', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1008
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1008',
    '3ds-max-plan-47-1008',
    'BEDROOM : 6 Rooms',
    1276.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1008',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1008',
    'BEDROOM : 6 Rooms SQUARE FEET : 2950 REFRENCE: : 47-1008',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1008', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2825351bfe7.webp', '3Ds Max Plan 47-1008', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1009
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1009',
    '3ds-max-plan-47-1009',
    'BEDROOM : 7 Rooms',
    1701.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1009',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1009',
    'BEDROOM : 7 Rooms SQUARE FEET : 3760 REFRENCE: : 47-1009',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1009', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2824b11c76c.webp', '3Ds Max Plan 47-1009', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1010
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1010',
    '3ds-max-plan-47-1010',
    'BEDROOM : 5 Rooms',
    617.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1010',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1010',
    'BEDROOM : 5 Rooms SQUARE FEET : 1450 REFRENCE: : 47-1010',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1010', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2824170b276.webp', '3Ds Max Plan 47-1010', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1011
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1011',
    '3ds-max-plan-47-1011',
    'BEDROOM : 3 Rooms',
    274.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1011',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1011',
    'BEDROOM : 3 Rooms SQUARE FEET : 840 REFRENCE: : 47-1011',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1011', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a282321cb7b8.webp', '3Ds Max Plan 47-1011', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1012
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1012',
    '3ds-max-plan-47-1012',
    'BEDROOM : 5 Rooms',
    892.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1012',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1012',
    'BEDROOM : 5 Rooms SQUARE FEET : 2180 REFRENCE: : 47-1012',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1012', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28229b989f3.webp', '3Ds Max Plan 47-1012', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1013
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1013',
    '3ds-max-plan-47-1013',
    'BEDROOM : 6 Rooms',
    1344.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1013',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1013',
    'BEDROOM : 6 Rooms SQUARE FEET : 3060 REFRENCE: : 47-1013',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1013', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28220fd8918.webp', '3Ds Max Plan 47-1013', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1014
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1014',
    '3ds-max-plan-47-1014',
    'BEDROOM : 5 Rooms',
    686.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1014',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1014',
    'BEDROOM : 5 Rooms SQUARE FEET : 1770 REFRENCE: : 47-1014',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1014', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28217ec1c29.webp', '3Ds Max Plan 47-1014', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1015
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1015',
    '3ds-max-plan-47-1015',
    'BEDROOM : 6 Rooms',
    1070.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1015',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1015',
    'BEDROOM : 6 Rooms SQUARE FEET : 2525 REFRENCE: : 47-1015',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1015', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28211309104.webp', '3Ds Max Plan 47-1015', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1016
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1016',
    '3ds-max-plan-47-1016',
    'BEDROOM : 6 Rooms',
    1399.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1016',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1016',
    'BEDROOM : 6 Rooms SQUARE FEET : 3220 REFRENCE: : 47-1016',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1016', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28202162aec.webp', '3Ds Max Plan 47-1016', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1017
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1017',
    '3ds-max-plan-47-1017',
    'BEDROOM : 7 Rooms',
    1783.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1017',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1017',
    'BEDROOM : 7 Rooms SQUARE FEET : 3960 REFRENCE: : 47-1017',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1017', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a281fb01b21a.webp', '3Ds Max Plan 47-1017', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1018
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1018',
    '3ds-max-plan-47-1018',
    'BEDROOM : 5 Rooms',
    775.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1018',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1018',
    'BEDROOM : 5 Rooms SQUARE FEET : 1950 REFRENCE: : 47-1018',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1018', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a281b21a9676.webp', '3Ds Max Plan 47-1018', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1019
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1019',
    '3ds-max-plan-47-1019',
    'BEDROOM : 7 Rooms',
    1893.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1019',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1019',
    'BEDROOM : 7 Rooms SQUARE FEET : 4195 REFRENCE: : 47-1019',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1019', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a281a486f7ef.webp', '3Ds Max Plan 47-1019', FALSE, 1, NOW(), NOW());

-- 3Ds Max Plan 47-1020
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '3Ds Max Plan 47-1020',
    '3ds-max-plan-47-1020',
    'BEDROOM : 4 Rooms',
    439.00,
    NULL,
    'AMW-3DS-MAX-PLAN-47-1020',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '3Ds Max Plan 47-1020',
    'BEDROOM : 4 Rooms SQUARE FEET : 1275 REFRENCE: : 47-1020',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '3Ds Max Plan 47-1020', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2819c8dfa2e.webp', '3Ds Max Plan 47-1020', FALSE, 1, NOW(), NOW());

-- Black galaxy step and riser
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Black galaxy step and riser',
    'black-galaxy-step-and-riser',
    'Black galaxy step and riser',
    77.00,
    NULL,
    'AMW-BLACK-GALAXY-STEP-AND-RISER',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Black galaxy step and riser',
    'Black galaxy step and riser',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Black galaxy step and riser', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28405be133f.webp', 'Black galaxy step and riser', FALSE, 1, NOW(), NOW());

-- Calacatta Oro/Gold
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Calacatta Oro/Gold',
    'calacatta-orogold',
    'Calacatta Oro/Gold Price 178 per sqm',
    178.00,
    NULL,
    'AMW-CALACATTA-OROGOLD',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Calacatta Oro/Gold',
    'Calacatta Oro/Gold Price 178 per sqm',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Calacatta Oro/Gold', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283c87d8f2f.webp', 'Calacatta Oro/Gold', FALSE, 1, NOW(), NOW());

-- Callacata viola italy
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Callacata viola italy',
    'callacata-viola-italy',
    'Callacata viola italy 186 per sqm',
    186.00,
    NULL,
    'AMW-CALLACATA-VIOLA-ITALY',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Callacata viola italy',
    'Callacata viola italy 186 per sqm',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Callacata viola italy', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283e46386f7.webp', 'Callacata viola italy', FALSE, 1, NOW(), NOW());

-- Danyno royal italy
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Danyno royal italy',
    'danyno-royal-italy',
    'Danyno royal italy 88 per sqm',
    88.00,
    NULL,
    'AMW-DANYNO-ROYAL-ITALY',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Danyno royal italy',
    'Danyno royal italy 88 per sqm',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Danyno royal italy', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283f059049f.webp', 'Danyno royal italy', FALSE, 1, NOW(), NOW());

-- Decorative wall marble
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Decorative wall marble',
    'decorative-wall-marble',
    'Decorative wall marble callacata arebescato',
    2387.00,
    NULL,
    'AMW-DECORATIVE-WALL-MARBLE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Decorative wall marble',
    'Decorative wall marble callacata arebescato',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Decorative wall marble', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2840cc64e33.webp', 'Decorative wall marble', FALSE, 1, NOW(), NOW());

-- Indian green marble
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Indian green marble',
    'indian-green-marble',
    'Indian green marble price 350 per sqm2',
    126.00,
    NULL,
    'AMW-INDIAN-GREEN-MARBLE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Indian green marble',
    'Indian green marble price 350 per sqm2 wall and floor',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Indian green marble', TRUE, 0, NOW(), NOW());

-- Marble Fountain
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Marble Fountain',
    'marble-fountain',
    'Marble Fountain',
    2058.00,
    NULL,
    'AMW-MARBLE-FOUNTAIN',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Marble Fountain',
    'Marble Fountain',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Marble Fountain', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2841b95b416.webp', 'Marble Fountain', FALSE, 1, NOW(), NOW());

-- Panda white book match
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Panda white book match',
    'panda-white-book-match',
    'Panda white book match size 5,6 *3,8',
    2566.00,
    NULL,
    'AMW-PANDA-WHITE-BOOK-MATCH',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Panda white book match',
    'Panda white book match size 5,6 *3,8',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Panda white book match', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283f96ef80a.webp', 'Panda white book match', FALSE, 1, NOW(), NOW());

-- Polarise marble
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Polarise marble',
    'polarise-marble',
    'Polarise marble',
    107.00,
    NULL,
    'AMW-POLARISE-MARBLE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Polarise marble',
    'Polarise marble Price 107 per sqm',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Polarise marble', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283d0f71679.webp', 'Polarise marble', FALSE, 1, NOW(), NOW());

-- Wall Book Marble
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Wall Book Marble',
    'wall-book-marble',
    'match size 6m*4.5m green mento marble',
    2154.00,
    NULL,
    'AMW-WALL-BOOK-MARBLE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Wall Book Marble',
    'match size 6m*4.5m green mento marble',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Wall Book Marble', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a284346b7646.webp', 'Wall Book Marble', FALSE, 1, NOW(), NOW());

-- Wall marble
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Wall marble',
    'wall-marble',
    'Wall marble volacas from greec book match and washing braiding callacata viola italy',
    1783.00,
    NULL,
    'AMW-WALL-MARBLE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Wall marble',
    'Wall marble volacas from greec book match and washing braiding callacata viola italy',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Wall marble', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2842d21967e.webp', 'Wall marble', FALSE, 1, NOW(), NOW());

-- Wall tv paint
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Wall tv paint',
    'wall-tv-paint',
    'Wall tv paint SS gypsem molder decoration',
    3416.00,
    NULL,
    'AMW-WALL-TV-PAINT',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Wall tv paint',
    'Wall tv paint SS gypsem molder decoration',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Wall tv paint', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28413d7599d.webp', 'Wall tv paint', FALSE, 1, NOW(), NOW());

-- Washing basin
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Washing basin',
    'washing-basin',
    'Washing basin with wall size 250 *320',
    5128.00,
    NULL,
    'AMW-WASHING-BASIN',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Washing basin',
    'Washing basin with wall size 250 *320',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Washing basin', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a28426236723.webp', 'Washing basin', FALSE, 1, NOW(), NOW());

-- مغسلة مقاس 280
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Uncategorized', 'uncategorized', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'مغسلة مقاس 280',
    'mghsl-mkas-280',
    'Carrara italy marble',
    1866.00,
    NULL,
    'AMW-MGHSL-MKAS-280',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'مغسلة مقاس 280',
    'Carrara italy marble',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 1, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'مغسلة مقاس 280', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a283c0749e0c.webp', 'مغسلة مقاس 280', FALSE, 1, NOW(), NOW());

-- Fellowes HFC Free Air Duster 350ml
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Fellowes HFC Free Air Duster 350ml',
    'fellowes-hfc-free-air-duster-350ml',
    'Ideal for use on printers, keyboards and other electrical equipment Use in an Upright position only HFC Free and Ozone Friendly',
    10.00,
    NULL,
    'AMW-FELLOWES-HFC-FREE-AIR-DUSTER-350ML',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Fellowes HFC Free Air Duster 350ml',
    'Ideal for use on printers, keyboards and other electrical equipment Use in an Upright position only HFC Free and Ozone Friendly The force of air removes all stubborn dirt, dust debris from keyboards, printer interiors and electrical equipment',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 25, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Fellowes HFC Free Air Duster 350ml', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be5ec0e495.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Fellowes HFC Free Air Duster 350ml', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Fellowes HFC Free Air Duster 350ml', FALSE, 9, NOW(), NOW());

-- Fellowes Screen Cleaning Wipes – 100wipes
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Fellowes Screen Cleaning Wipes – 100wipes',
    'fellowes-screen-cleaning-wipes-100wipes',
    'Suitable for tablet, monitor, laptop screens, and glass surfaces of photocopiers and scanners. Comes with 100 pre-moistened biodegradable crepe wipes in a resealable tub. Advanced formula ensures a perfect, streak-free clean. Anti-static, non-streak formula for optimal screen care. Biodegradable wipes for an eco-friendly cleaning solution.',
    5.00,
    NULL,
    'AMW-FELLOWES-SCREEN-CLEANING-WIPES-100WIPES',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Fellowes Screen Cleaning Wipes – 100wipes',
    'Suitable for tablet, monitor, laptop screens, and glass surfaces of photocopiers and scanners. Comes with 100 pre-moistened biodegradable crepe wipes in a resealable tub. Advanced formula ensures a perfect, streak-free clean. Anti-static, non-streak formula for optimal screen care. Biodegradable wipes for an eco-friendly cleaning solution. Wipe size: 5-7/8″ x 5-1/8″.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Fellowes Screen Cleaning Wipes – 100wipes', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be6579045e.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Fellowes Screen Cleaning Wipes – 100wipes', FALSE, 9, NOW(), NOW());

-- Gel Wrist Rest and Mouse Pad – Graphite/Platinum
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Gel Wrist Rest and Mouse Pad – Graphite/Platinum',
    'gel-wrist-rest-and-mouse-pad-graphiteplatinum',
    '## Key Features',
    18.00,
    NULL,
    'AMW-GEL-WRIST-REST-AND-MOUSE-PAD-GRAPHITEPLATINUM',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Gel Wrist Rest and Mouse Pad – Graphite/Platinum',
    '## Key Features – **Exceptional support** helps redistribute pressure points for comfort. – **Soft, durable Lycra® covering** resists daily wear and tear. – **Non-skid base** keeps the wrist rest securely in place. – Promotes a **comfortable and neutral wrist position** for better ergonomics.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 10, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be6e9c6c71.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Gel Wrist Rest and Mouse Pad – Graphite/Platinum', FALSE, 9, NOW(), NOW());

-- Hukoomi Smart Card Reader (E-Government )
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Hukoomi Smart Card Reader (E-Government )',
    'hukoomi-smart-card-reader-e-government',
    'Key Features:',
    23.00,
    NULL,
    'AMW-HUKOOMI-SMART-CARD-READER-E-GOVERNMENT',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Hukoomi Smart Card Reader (E-Government )',
    'Key Features: Secure Authentication : Allows users to verify their identity securely for online transactions and services. E-Government Integration : Provides access to a wide range of services, including visa applications, residency permits, bill payments, and official document requests. Smart Chip Reading : Reads data embedded in the QID card chip to enable quick access to personal and government records. Plug-and-Play Functionality : Works with computers and government kiosks via USB or other standard connections. Time-Saving : Reduces the need for physical visits to government offices by enabling digital interactions. User-Friendly : Simple to use, requiring minimal technical expertise.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Hukoomi Smart Card Reader (E-Government )', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Hukoomi Smart Card Reader (E-Government )', FALSE, 8, NOW(), NOW());

-- Imation CD-R – 700MB, 52X (Pack of 50)
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Imation CD-R – 700MB, 52X (Pack of 50)',
    'imation-cd-r-700mb-52x-pack-of-50',
    'No risk of CD-Rs being erased or overwritten',
    14.00,
    NULL,
    'AMW-IMATION-CD-R-700MB-52X-PACK-OF-50',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Imation CD-R – 700MB, 52X (Pack of 50)',
    'No risk of CD-Rs being erased or overwritten Create a CD in under 4 minutes at 52x speed Play back in an audio CD player, CD-RW drive or CD-ROM drive Pack of 50',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Imation CD-R – 700MB, 52X (Pack of 50)', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Imation CD-R – 700MB, 52X (Pack of 50)', FALSE, 8, NOW(), NOW());

-- Logitech Combo Pack MK120 Keyboard & Mouse Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech Combo Pack MK120 Keyboard & Mouse Black',
    'logitech-combo-pack-mk120-keyboard-mouse-black',
    'Enjoy comfortable typing with low-profile, whisper-quiet keys and a standard layout that includes full-size F-keys and a number pad. The slim, sleek keyboard is built to last, featuring a spill-resistant design, sturdy tilt legs, and durable keys. Navigate with ease using the precise, high-definition optical mouse for smooth control.',
    20.00,
    NULL,
    'AMW-LOGITECH-COMBO-PACK-MK120-KEYBOARD-MOUSE-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech Combo Pack MK120 Keyboard & Mouse Black',
    'Enjoy comfortable typing with low-profile, whisper-quiet keys and a standard layout that includes full-size F-keys and a number pad. The slim, sleek keyboard is built to last, featuring a spill-resistant design, sturdy tilt legs, and durable keys. Navigate with ease using the precise, high-definition optical mouse for smooth control.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 55, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech Combo Pack MK120 Keyboard & Mouse Black', FALSE, 8, NOW(), NOW());

-- Logitech K120 Wired Keyboard – English, Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech K120 Wired Keyboard – English, Black',
    'logitech-k120-wired-keyboard-english-black',
    'Key Features',
    15.00,
    NULL,
    'AMW-LOGITECH-K120-WIRED-KEYBOARD-ENGLISH-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech K120 Wired Keyboard – English, Black',
    'Key Features Comfortable & Quiet Typing: Adjustable folding legs for an 8-degree tilt to enhance ergonomic comfort. Plug & Play USB Connection: Simple setup, just plug into a USB port and start using immediately. Easy-to-Read Keys: Bold, bright white characters for improved visibility and durability, ideal for users with less-than-perfect vis ion.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 25, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech K120 Wired Keyboard – English, Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech K120 Wired Keyboard – English, Black', FALSE, 8, NOW(), NOW());

-- Logitech M170 Wireless Mouse, Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech M170 Wireless Mouse, Black',
    'logitech-m170-wireless-mouse-black',
    '2.4Ghz Wireless Mouse giving apt mouse movements from 10-meters. Operate the computer hassle-free. Product: Logitech M170 Wireless Mouse Requires: Windows or Mac with Chrome OS and USB Battery: 1 x AA battery Battery Life: 12 Months Color: Black',
    13.00,
    NULL,
    'AMW-LOGITECH-M170-WIRELESS-MOUSE-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech M170 Wireless Mouse, Black',
    '2.4Ghz Wireless Mouse giving apt mouse movements from 10-meters. Operate the computer hassle-free. Product: Logitech M170 Wireless Mouse Requires: Windows or Mac with Chrome OS and USB Battery: 1 x AA battery Battery Life: 12 Months Color: Black',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech M170 Wireless Mouse, Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech M170 Wireless Mouse, Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech M170 Wireless Mouse, Black', FALSE, 8, NOW(), NOW());

-- Logitech M185 Wireless Mouse, Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech M185 Wireless Mouse, Black',
    'logitech-m185-wireless-mouse-black',
    '2.4Ghz Wireless Mouse giving apt mouse movement from close range. Operate the computer for longer hours, hassle-free.',
    17.00,
    NULL,
    'AMW-LOGITECH-M185-WIRELESS-MOUSE-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech M185 Wireless Mouse, Black',
    '2.4Ghz Wireless Mouse giving apt mouse movement from close range. Operate the computer for longer hours, hassle-free. Product: Logitech M185 Mouse Operation: 1000dpi Wireless sensor Requires: Windows or Mac with Chrome OS and USB Battery: 1 x AA battery Battery Life: 12 Months Color: Black',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 14, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech M185 Wireless Mouse, Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech M185 Wireless Mouse, Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech M185 Wireless Mouse, Black', FALSE, 8, NOW(), NOW());

-- Logitech M90 Wired Mouse
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech M90 Wired Mouse',
    'logitech-m90-wired-mouse',
    'Quick and easy setup: Just plug into a USB port and start using immediately. Precise optical tracking: Smooth operation, with or without a mouse pad. No software installation needed: Simple plug-and-play functionality. Ambidextrous design: Comfortable for both left and right-hand users.',
    8.00,
    NULL,
    'AMW-LOGITECH-M90-WIRED-MOUSE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech M90 Wired Mouse',
    'Quick and easy setup: Just plug into a USB port and start using immediately. Precise optical tracking: Smooth operation, with or without a mouse pad. No software installation needed: Simple plug-and-play functionality. Ambidextrous design: Comfortable for both left and right-hand users. High-definition optical tracking (1000 dpi): Offers responsive and accurate cursor control.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 14, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech M90 Wired Mouse', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech M90 Wired Mouse', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech M90 Wired Mouse', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech M90 Wired Mouse', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech M90 Wired Mouse', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech M90 Wired Mouse', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech M90 Wired Mouse', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech M90 Wired Mouse', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech M90 Wired Mouse', FALSE, 8, NOW(), NOW());

-- Logitech MK220 Wireless Keyboard & Mouse – English, Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Accessories', 'computer-accessories', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Logitech MK220 Wireless Keyboard & Mouse – English, Black',
    'logitech-mk220-wireless-keyboard-mouse-english-black',
    '',
    26.00,
    NULL,
    'AMW-LOGITECH-MK220-WIRELESS-KEYBOARD-MOUSE-ENGLISH-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Logitech MK220 Wireless Keyboard & Mouse – English, Black',
    '',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be7c76194a.jpg', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be82e5cb90.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be8ca733b3.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa3c1b9280.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa455eeb6b.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa4f979167.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa55c644e3.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa5a017fda.webp', 'Logitech MK220 Wireless Keyboard & Mouse – English, Black', FALSE, 8, NOW(), NOW());

-- ATLAS PRICE LABELER 810E 8 DIGIT
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'ATLAS PRICE LABELER 810E 8 DIGIT',
    'atlas-price-labeler-810e-8-digit',
    '8-Digit Capacity : Allows for pricing up to 8 digits, accommodating a wide range of price points.',
    27.00,
    NULL,
    'AMW-ATLAS-PRICE-LABELER-810E-8-DIGIT',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'ATLAS PRICE LABELER 810E 8 DIGIT',
    '8-Digit Capacity : Allows for pricing up to 8 digits, accommodating a wide range of price points. Smooth and Accurate Operation : Ensures consistent label printing with minimal effort. One-Touch Open System : Facilitates easy loading and replacement of label rolls, enhancing efficiency. Durable Construction : Made from high-grade materials for long-lasting durability, suitable for frequent use Includes Label Rolls : Comes with 2 rolls of labels to get you started immediately. Compact and Lightweight Design : Easy to handle, reducing user fatigue during extended use. Versatile Use : Suitable for various settings, including offices, schools, and retail stores',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 25, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'ATLAS PRICE LABELER 810E 8 DIGIT', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bd6b1334da.webp', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'ATLAS PRICE LABELER 810E 8 DIGIT', FALSE, 9, NOW(), NOW());

-- BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.',
    'buy-online-networking-cat6-cable-305-mtrs',
    'Key Features:',
    99.00,
    NULL,
    'AMW-BUY-ONLINE-NETWORKING-CAT6-CABLE-305-MTRS',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.',
    'Key Features: Category: CAT6 (Category 6) Supports Gigabit Ethernet (10/100/1000 Mbps) and 10-Gigabit speeds over short distances. Length: 305 Meters (1000 Feet) Ideal for large-scale networking installations, structured cabling, or data centers. Performance: Bandwidth up to 250 MHz Improved signal integrity and reduced crosstalk compared to CAT5e Construction: Unshielded Twisted Pair (UTP) or Shielded Twisted Pair (STP) options 23 AWG solid copper or CCA (Copper Clad Aluminum) conductors Durable outer PVC or LSZH (Low Smoke Zero Halogen) jacket',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bd9e6727ae.png', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'BUY ONLINE NETWORKING CAT6 CABLE 305 MTRS.', FALSE, 9, NOW(), NOW());

-- Buy Online Canon CL 446 Tri-Color Original Ink Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge',
    'buy-online-canon-cl-446-tri-color-original-ink-cartridge',
    '🧾 Key Specifications Feature Details Page Yield ~180 pages at 5% coverage (A4 size) — approx. single‑letter‑sized text Ink Capacity Around 8–9 ml total for color inks Colors Included Cyan, Magenta, Yellow Compatibility Works with a range of Canon PIXMA printers, including models like: – iP2840, MG2440, MG2540/2540S/2545, MG2940, MG3040, MX494, TR4540, TS204, TS304, TS3140, TS334',
    16.00,
    NULL,
    'AMW-BUY-ONLINE-CANON-CL-446-TRI-COLOR-ORIGINAL-INK-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge',
    '🧾 Key Specifications Feature Details Page Yield ~180 pages at 5% coverage (A4 size) — approx. single‑letter‑sized text Ink Capacity Around 8–9 ml total for color inks Colors Included Cyan, Magenta, Yellow Compatibility Works with a range of Canon PIXMA printers, including models like: – iP2840, MG2440, MG2540/2540S/2545, MG2940, MG3040, MX494, TR4540, TS204, TS304, TS3140, TS334',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bd8463d419.png', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'Buy Online Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 9, NOW(), NOW());

-- Canon PG 445 Black Original Ink Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Canon PG 445 Black Original Ink Cartridge',
    'canon-pg-445-black-original-ink-cartridge',
    '📌 Key Features',
    16.00,
    NULL,
    'AMW-CANON-PG-445-BLACK-ORIGINAL-INK-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Canon PG 445 Black Original Ink Cartridge',
    '📌 Key Features Genuine Canon Quality An original Canon cartridge (model 8283B001AA), ensuring optimal compatibility and performance with Canon PIXMA printers Pigment‑Based Black Ink Delivers crisp, sharp, and smudge‑resistant text—ideal for documents—thanks to its pigment formula. 8 mL Ink Volume, ~180‑Page Yield Cartridge capacity is approximately 8 mL, yielding around 180 A4 pages at 5% coverage (ISO standard) Fade‑Resistant, Long‑Lasting Prints Designed for durability and longevity—printouts stand the test of time Wide Printer Compatibility Works with a range of Canon PIXMA printers, including models: iP2840, MG2440/MG2540/MG2545S/MG2940/MG3040, MX494, TS204/TS3140/TS3440, TR4540/TR3340/TR4640',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 52, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Canon PG 445 Black Original Ink Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdb835f262.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 9, NOW(), NOW());

-- DisplayPort to VGA Adapter
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'DisplayPort to VGA Adapter',
    'displayport-to-vga-adapter',
    '🔧 Key Features',
    13.00,
    NULL,
    'AMW-DISPLAYPORT-TO-VGA-ADAPTER',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'DisplayPort to VGA Adapter',
    '🔧 Key Features Active Signal Conversion: Converts digital DisplayPort signals to analog VGA, ensuring compatibility even with devices that lack dual-mode (DP++) support. High-Resolution Support: Supports resolutions up to 2048×1536 at 60Hz, including 1080p and 1920×1200, delivering clear and sharp visuals. Plug-and-Play: No drivers or external power sources are required, simplifying setup and usage. Secure Connections: Features a latching DisplayPort connector and a screw-locking VGA connector to maintain stable and reliable connections. Wide Compatibility: Works seamlessly with various operating systems, including Windows, macOS, Linux, an d ChromeOS',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'DisplayPort to VGA Adapter', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'DisplayPort to VGA Adapter', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'DisplayPort to VGA Adapter', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'DisplayPort to VGA Adapter', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'DisplayPort to VGA Adapter', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'DisplayPort to VGA Adapter', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'DisplayPort to VGA Adapter', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'DisplayPort to VGA Adapter', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'DisplayPort to VGA Adapter', FALSE, 8, NOW(), NOW());

-- HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A',
    'hp-201a-magenta-compatible-laserjet-toner-cartridge-cf403a',
    'Key Features:',
    23.00,
    NULL,
    'AMW-HP-201A-MAGENTA-COMPATIBLE-LASERJET-TONER-CARTRIDGE-CF403A',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A',
    'Key Features: Compatibility: Designed for use with HP Color LaserJet Pro M252dw, M252n, MFP M277dw, and MFP M277n printers High Performance: Yields up to 1,400 pages at 5% coverage Vibrant Color: Produces brilliant magenta hues with smooth gradients and solid fills Cost-Effective: Offers significant savings over OEM cartridges without compromising on quality Eco-Friendly: Built with recycled components and meets environmental standards Reliable Operation: Manufactured to strict ISO standards to ensure consistent print quality and cartridge performance',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 58, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 8, NOW(), NOW());

-- HP 85A Black original LaserJet Toner Cartridge (CE285A)
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'HP 85A Black original LaserJet Toner Cartridge (CE285A)',
    'hp-85a-black-original-laserjet-toner-cartridge-ce285a',
    'Key Features',
    71.00,
    NULL,
    'AMW-HP-85A-BLACK-ORIGINAL-LASERJET-TONER-CARTRIDGE-CE285A',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'HP 85A Black original LaserJet Toner Cartridge (CE285A)',
    'Key Features Page Yield: Approximately 1,600 pages, based on ISO/IEC 19752 standards. Actual yield may vary depending on printing conditions and content. Print Technology: Laser Color: Black Cartridge Type: Standard Capacity Toner Cartridge Compatibility: Compatible with HP LaserJet Pro P1102, P1102w, M1132, M1212nf, and M1217nfw printers. Operating Conditions: Temperature Range: 10 to 32.5°C Humidity Range: 20 to 80% RH Storage Conditions: Temperature Range: -20 to 40°C Humidity Range: 10 to 90% RH Package Dimensions: 375 x 113 x 125 mm Weight: Cartridge: 0.62 kg Package: 0.83 kg Environmental Consideration: Contains 29% recycled content and is eligible for HP’s free recycling program through HP Planet Partners. Benefits Consistent Print Quality: Delivers sharp black text and clear images, ensuring professional-looking documents every time. Easy Installation: The all-in-one cartridge design simplifies replacement, minimizing downtime. Reliable Performance: Engineered to work seamlessly with HP printers, reducing the risk of print defects and reprints. Eco-Friendly: Designed with the environment in mind, offering easy recycling options and reduced waste.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 25, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 8, NOW(), NOW());

-- HP KEYBOARD CS10 WIRELESS WHITE
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'HP KEYBOARD CS10 WIRELESS WHITE',
    'hp-keyboard-cs10-wireless-white',
    'Feature Highlights',
    23.00,
    NULL,
    'AMW-HP-KEYBOARD-CS10-WIRELESS-WHITE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'HP KEYBOARD CS10 WIRELESS WHITE',
    'Feature Highlights Wireless 2.4 GHz dongle, up to 10 m range, energy-saving Keyboard Full-size, 104 keys, hollowed keycaps, AAA power Mouse Ambidextrous, 3-button optical, DPI switch Design & Build Sleek white, slim, ~0.8 kg, durable keycaps Ease of Use Plug‑and‑play, no drivers, multi-language layouts',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'HP KEYBOARD CS10 WIRELESS WHITE', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'HP KEYBOARD CS10 WIRELESS WHITE', FALSE, 8, NOW(), NOW());

-- Haysenser Smart Card Reader hukoomi
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Haysenser Smart Card Reader hukoomi',
    'haysenser-smart-card-reader-hukoomi',
    '🔍 Key Features',
    18.00,
    NULL,
    'AMW-HAYSENSER-SMART-CARD-READER-HUKOOMI',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Haysenser Smart Card Reader hukoomi',
    '🔍 Key Features Supported Card Types : Compatible with 5V, 3V, and 1.8V smart cards adhering to ISO 7816 Class A, B, and C standards. Interface & Speed : Connects via USB 2.0, offering a full-speed data transfer rate of 12 Mbps. Operating System Compatibility : Supports Windows, macOS, and Linux platforms. Application Support : Suitable for web-ATM transactions, I-Cash systems, SIM card editing, ID card processing, and e-commerce applications. Safety Features : Equipped with short circuit protection to ensure safe and reliable operation.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Haysenser Smart Card Reader hukoomi', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'Haysenser Smart Card Reader hukoomi', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'Haysenser Smart Card Reader hukoomi', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'Haysenser Smart Card Reader hukoomi', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'Haysenser Smart Card Reader hukoomi', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'Haysenser Smart Card Reader hukoomi', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'Haysenser Smart Card Reader hukoomi', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'Haysenser Smart Card Reader hukoomi', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'Haysenser Smart Card Reader hukoomi', FALSE, 8, NOW(), NOW());

-- Plugable HDMI to VGA Active Adapter
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Plugable HDMI to VGA Active Adapter',
    'plugable-hdmi-to-vga-active-adapter',
    '',
    8.00,
    NULL,
    'AMW-PLUGABLE-HDMI-TO-VGA-ACTIVE-ADAPTER',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Plugable HDMI to VGA Active Adapter',
    '',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Plugable HDMI to VGA Active Adapter', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'Plugable HDMI to VGA Active Adapter', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'Plugable HDMI to VGA Active Adapter', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'Plugable HDMI to VGA Active Adapter', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'Plugable HDMI to VGA Active Adapter', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'Plugable HDMI to VGA Active Adapter', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'Plugable HDMI to VGA Active Adapter', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'Plugable HDMI to VGA Active Adapter', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'Plugable HDMI to VGA Active Adapter', FALSE, 8, NOW(), NOW());

-- TOTAL STEEL MEASURING TAPE 20 MTR.
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'TOTAL STEEL MEASURING TAPE 20 MTR.',
    'total-steel-measuring-tape-20-mtr',
    '📏 Key Specifications',
    15.00,
    NULL,
    'AMW-TOTAL-STEEL-MEASURING-TAPE-20-MTR',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'TOTAL STEEL MEASURING TAPE 20 MTR.',
    '📏 Key Specifications Length × Width: 20 m × 12.5 mm Blade Material: Heat-treated, nylon-reinforced steel (~0.15 mm thick) with rust-resistant coating Scales: Both metric (cm/mm) and imperial (inch/ft) clearly p rinted',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 25, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'TOTAL STEEL MEASURING TAPE 20 MTR.', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'TOTAL STEEL MEASURING TAPE 20 MTR.', FALSE, 8, NOW(), NOW());

-- TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Computer Items', 'computer-items', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless',
    'tp-link-tl-wn725nwifi-adpter-150mbps-wireless',
    '🔑 Key Features',
    13.00,
    NULL,
    'AMW-TP-LINK-TL-WN725NWIFI-ADPTER-150MBPS-WIRELESS',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless',
    '🔑 Key Features Compact Nano Design: The TL-WN725N boasts a sleek, miniature design that allows it to remain plugged into a laptop’s USB port without obstructing other interfaces. Its dimensions are 18.6 x 15 x 7.1 mm, and it weighs just 2.1 grams, making it ideal for users on the move. Wireless Speed: Offers wireless transmission speeds of up to 150Mbps, suitable for activities like video streaming, internet calls, and online gaming. Advanced Security: Supports multiple encryption standards, including 64/128-bit WEP, WPA/WPA2, and WPA-PSK/WPA2-PSK (TKIP/AES), ensuring secure wireless connections. SoftAP Mode: Enables the adapter to function as a Wi-Fi hotspot, allowing users to share a wired internet connection wirelessly with other devices. Easy Setup: Comes with a user-friendly setup utility available in 14 languages, facilitating quick and straightforward installation. Broad OS Compatibility: Compatible with various operating systems, including Windows (XP/Vista/7/8/8.1/10), Mac OS X (10.7~10.10), and Linux, ensuring versatility across different platforms. Internal Antenna: Features an internal antenna design, maintaining the adapter’s compact profile while providing stable wireless performance. Wireless Standards: Complies with IEEE 802.11b/g/n standards, operating on the 2.4GHz frequency band (2 .400–2.4835GHz).',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdc74d1fcd.jpg', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdced04519.jpg', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdd62b3fa1.png', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bde0731669.png', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdecaa8627.png', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2bdf22b84d0.jpg', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be21b89c1e.webp', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2be2788c4e8.jpg', 'TP-Link TL-WN725N,Wifi Adpter 150Mbps Wireless', FALSE, 8, NOW(), NOW());

-- 16A LaserJet Toner Cartridge – Black (Q7516A)
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    '16A LaserJet Toner Cartridge – Black (Q7516A)',
    '16a-laserjet-toner-cartridge-black-q7516a',
    '✅ Key Features:',
    164.00,
    NULL,
    'AMW-16A-LASERJET-TONER-CARTRIDGE-BLACK-Q7516A',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    '16A LaserJet Toner Cartridge – Black (Q7516A)',
    '✅ Key Features: High-Quality Printing Produces sharp, crisp black text and graphics. Delivers professional-quality results page after page. Page Yield Yields approximately 12,000 standard pages (based on 5% coverage per ISO/IEC 19752). Consistent Performance Engineered to work seamlessly with compatible HP LaserJet printers. Maintains consistent quality throughout the cartridge life. Smart Printing Technology Built-in intelligence enables alerts when toner is low or out. Helps optimize print quality and cartridge efficiency. Easy Installation Designed for quick, clean, and easy replacement. Environmental Responsibility Recyclable through the HP Planet Partners program. Meets environmental standards for waste reduction. Compatibility Compatible with: HP LaserJet 5200 Series Printers (including 5200n, 5200tn, 5200dtn)',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', '16A LaserJet Toner Cartridge – Black (Q7516A)', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', '16A LaserJet Toner Cartridge – Black (Q7516A)', FALSE, 8, NOW(), NOW());

-- Brother BT 5000 Cyan Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother BT 5000 Cyan Cartridge',
    'brother-bt-5000-cyan-cartridge',
    'Key Features',
    11.00,
    NULL,
    'AMW-BROTHER-BT-5000-CYAN-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother BT 5000 Cyan Cartridge',
    'Key Features Ultra High Page Yield : Capable of printing approximately 5,000 pages based on Brother’s original methodology using test patterns ISO/IEC 24712 . Pigment-Based Ink : Utilizes pigment-based ink for sharp, vibrant, and long-lasting prints . Genuine Brother Quality : Ensures optimal performance and longevity of your printer by using original Brother ink . Cost-Effective Printing : High page yield reduces the cost per page, making it economical for both home and office use . Easy Refilling : Designed for seamless refilling, minimizing waste and downtime.',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother BT 5000 Cyan Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother BT 5000 Cyan Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother BT 5000 Cyan Cartridge', FALSE, 8, NOW(), NOW());

-- Brother BT 5000 Magenta Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother BT 5000 Magenta Cartridge',
    'brother-bt-5000-magenta-cartridge',
    'Clean, crisp copies from your Inkjet printer are important. The genuine Brother BT5000M Magenta Cartridge will give you just that.',
    11.00,
    NULL,
    'AMW-BROTHER-BT-5000-MAGENTA-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother BT 5000 Magenta Cartridge',
    'Clean, crisp copies from your Inkjet printer are important. The genuine Brother BT5000M Magenta Cartridge will give you just that. Ink Cartridge Inkjet Printing Technology Page Yield 6000 Magenta',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother BT 5000 Magenta Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother BT 5000 Magenta Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother BT 5000 Magenta Cartridge', FALSE, 8, NOW(), NOW());

-- Brother BT 5000 Yellow Catridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother BT 5000 Yellow Catridge',
    'brother-bt-5000-yellow-catridge',
    'Clean, crisp copies from your Inkjet printer are important. The genuine Brother BT5000Y Yellow Cartridge will give you just that.',
    11.00,
    NULL,
    'AMW-BROTHER-BT-5000-YELLOW-CATRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother BT 5000 Yellow Catridge',
    'Clean, crisp copies from your Inkjet printer are important. The genuine Brother BT5000Y Yellow Cartridge will give you just that. Ink Cartridge Inkjet Printing Technology Page Yield 6000 Y ellow',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother BT 5000 Yellow Catridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother BT 5000 Yellow Catridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother BT 5000 Yellow Catridge', FALSE, 8, NOW(), NOW());

-- Brother BT-D60 BK Black Ink Bottle Original
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother BT-D60 BK Black Ink Bottle Original',
    'brother-bt-d60-bk-black-ink-bottle-original',
    'Brother Colour Inkjet MFCs are the perfect technology for your home and office. The range allows you to colour scan, copy, print and fax from one compact unit designed for your use. Eliminating the frustration of having to throw away unused inks, Brother’s colour inkjet machines have separate ink cartridges for each colour. All you have to do is replace the empty cartridge – reducing waste and cost.',
    12.00,
    NULL,
    'AMW-BROTHER-BT-D60-BK-BLACK-INK-BOTTLE-ORIGINAL',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother BT-D60 BK Black Ink Bottle Original',
    'Brother Colour Inkjet MFCs are the perfect technology for your home and office. The range allows you to colour scan, copy, print and fax from one compact unit designed for your use. Eliminating the frustration of having to throw away unused inks, Brother’s colour inkjet machines have separate ink cartridges for each colour. All you have to do is replace the empty cartridge – reducing waste and cost. Prints 6500 pages, based on industry standard test charts, offering low costs per page High quality genuine Brother ink Prevents waste to save you paper, time and money',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother BT-D60 BK Black Ink Bottle Original', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother BT-D60 BK Black Ink Bottle Original', FALSE, 8, NOW(), NOW());

-- Brother Cartridge Black LC539XL
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother Cartridge Black LC539XL',
    'brother-cartridge-black-lc539xl',
    'Brother LC539XL black ink cartridge allows you to print out vivid colour documents and images that stand out. This colour cartridge provides black ink, which is smudge proof and water resistant.',
    14.00,
    NULL,
    'AMW-BROTHER-CARTRIDGE-BLACK-LC539XL',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother Cartridge Black LC539XL',
    'Brother LC539XL black ink cartridge allows you to print out vivid colour documents and images that stand out. This colour cartridge provides black ink, which is smudge proof and water resistant. Compatible Printers Brother DCP-J100 Brother DCP-J105 Brother MFC-J200 Page yield: 2400 per cartridge',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother Cartridge Black LC539XL', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother Cartridge Black LC539XL', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother Cartridge Black LC539XL', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother Cartridge Black LC539XL', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother Cartridge Black LC539XL', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother Cartridge Black LC539XL', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother Cartridge Black LC539XL', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother Cartridge Black LC539XL', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother Cartridge Black LC539XL', FALSE, 8, NOW(), NOW());

-- Brother DR-1000 Original Drum Black
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother DR-1000 Original Drum Black',
    'brother-dr-1000-original-drum-black',
    'Type: Image Drum Capacity: Standard Yield Cartridge Color: Black Compatible Printer: Brother DCP-1510, Brother DCP-1512A, Brother DCP-1512, Brother HL-1110E, Brother HL-1110R, Brother HL-1110, Brother HL-1112A',
    38.00,
    NULL,
    'AMW-BROTHER-DR-1000-ORIGINAL-DRUM-BLACK',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother DR-1000 Original Drum Black',
    'Type: Image Drum Capacity: Standard Yield Cartridge Color: Black Compatible Printer: Brother DCP-1510, Brother DCP-1512A, Brother DCP-1512, Brother HL-1110E, Brother HL-1110R, Brother HL-1110, Brother HL-1112A Page Yield: 10000 Pages',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother DR-1000 Original Drum Black', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother DR-1000 Original Drum Black', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother DR-1000 Original Drum Black', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother DR-1000 Original Drum Black', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother DR-1000 Original Drum Black', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother DR-1000 Original Drum Black', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother DR-1000 Original Drum Black', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother DR-1000 Original Drum Black', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother DR-1000 Original Drum Black', FALSE, 8, NOW(), NOW());

-- Brother DR-3215 Drum Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Brother DR-3215 Drum Cartridge',
    'brother-dr-3215-drum-cartridge',
    'This drum unit covers up to 25,000 pages at 5% coverage.',
    226.00,
    NULL,
    'AMW-BROTHER-DR-3215-DRUM-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Brother DR-3215 Drum Cartridge',
    'This drum unit covers up to 25,000 pages at 5% coverage. Compatible with following Brother Printers: HL-5340D HL-5350DN HL-5370DW HL-5380DN MFC-8380DN MFC-8880DN MFC-8370DN DCP-8070D',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Brother DR-3215 Drum Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Brother DR-3215 Drum Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Brother DR-3215 Drum Cartridge', FALSE, 8, NOW(), NOW());

-- Canon CL 446 Tri-Color Original Ink Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Canon CL 446 Tri-Color Original Ink Cartridge',
    'canon-cl-446-tri-color-original-ink-cartridge',
    '🧾 Key Specifications',
    16.00,
    NULL,
    'AMW-CANON-CL-446-TRI-COLOR-ORIGINAL-INK-CARTRIDGE',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Canon CL 446 Tri-Color Original Ink Cartridge',
    '🧾 Key Specifications Feature Details Page Yield ~180 pages at 5% coverage (A4 size) — approx. single‑letter‑sized text Ink Capacity Around 8–9 ml total for color inks Colors Included Cyan, Magenta, Yellow Compatibility Works with a range of Canon PIXMA printers, including models like: – iP2840, MG2440, MG2540/2540S/2545, MG2940, MG3040, MX494, TR4540, TS204, TS304, TS3140, TS334',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 12, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Canon CL 446 Tri-Color Original Ink Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa793a2d57.png', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Canon CL 446 Tri-Color Original Ink Cartridge', FALSE, 9, NOW(), NOW());

-- Canon PG 445 Black Original Ink Cartridge
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'Canon PG 445 Black Original Ink Cartridge',
    'canon-pg-445-black-original-ink-cartridge-2606152243-397',
    '📌 Key Features',
    16.00,
    NULL,
    'AMW-CANON-PG-445-BLACK-ORIGINAL-INK-CARTRIDGE-2606152243-397',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'Canon PG 445 Black Original Ink Cartridge',
    '📌 Key Features Genuine Canon Quality An original Canon cartridge (model 8283B001AA), ensuring optimal compatibility and performance with Canon PIXMA printers Pigment‑Based Black Ink Delivers crisp, sharp, and smudge‑resistant text—ideal for documents—thanks to its pigment formula 8 mL Ink Volume, ~180‑Page Yield Cartridge capacity is approximately 8 mL, yielding around 180 A4 pages at 5% coverage (ISO standard) Fade‑Resistant, Long‑Lasting Prints Designed for durability and longevity—printouts stand the test of time Wide Printer Compatibility Works with a range of Canon PIXMA printers, including models: iP2840, MG2440/MG2540/MG2545S/MG2940/MG3040, MX494, TS204/TS3140/TS3440, TR4540/TR3340/TR4640',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'Canon PG 445 Black Original Ink Cartridge', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa83ac59e6.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'Canon PG 445 Black Original Ink Cartridge', FALSE, 9, NOW(), NOW());

-- HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A',
    'hp-201a-magenta-compatible-laserjet-toner-cartridge-cf403a-2606152432-232',
    'Key Features:',
    23.00,
    NULL,
    'AMW-HP-201A-MAGENTA-COMPATIBLE-LASERJET-TONER-CARTRIDGE-CF403A-2606152432-232',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A',
    'Key Features: Compatibility: Designed for use with HP Color LaserJet Pro M252dw, M252n, MFP M277dw, and MFP M277n printers High Performance: Yields up to 1,400 pages at 5% coverage Vibrant Color: Produces brilliant magenta hues with smooth gradients and solid fills Cost-Effective: Offers significant savings over OEM cartridges without compromising on quality Eco-Friendly: Built with recycled components and meets environmental standards Reliable Operation: Manufactured to strict ISO standards to ensure consistent print quality and cartridge performance',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa8a8770cf.png', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'HP 201A Magenta Compatible LaserJet Toner Cartridge CF403A', FALSE, 9, NOW(), NOW());

-- HP 85A Black original LaserJet Toner Cartridge (CE285A)
WITH cat AS (
  INSERT INTO categories (name, slug, parent_id, icon, is_active, position, created_at, updated_at)
  VALUES ('Ink & Toner Cartridge', 'ink-toner-cartridge', NULL, NULL, TRUE, 0, NOW(), NOW())
  ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name, is_active = TRUE, updated_at = NOW()
  RETURNING id
), prod AS (
  INSERT INTO products (name, slug, description, price, discount_price, sku, category_id, brand_id, featured, best_selling, top_rated, is_active, meta_title, meta_description, total_sold, view_count, created_at, updated_at)
  VALUES (
    'HP 85A Black original LaserJet Toner Cartridge (CE285A)',
    'hp-85a-black-original-laserjet-toner-cartridge-ce285a-2606152641-290',
    'Key Features',
    71.00,
    NULL,
    'AMW-HP-85A-BLACK-ORIGINAL-LASERJET-TONER-CARTRIDGE-CE285A-2606152641-290',
    (SELECT id FROM cat),
    NULL, FALSE, FALSE, FALSE, TRUE,
    'HP 85A Black original LaserJet Toner Cartridge (CE285A)',
    'Key Features Page Yield : Approximately 1,600 pages, based on ISO/IEC 19752 standards. Actual yield may vary depending on printing conditions and content. Print Technology : Laser Color : Black Cartridge Type : Standard Capacity Toner Cartridge Compatibility : Compatible with HP LaserJet Pro P1102, P1102w, M1132, M1212nf, and M1217nfw printers. Operating Conditions : Temperature Range : 10 to 32.5°C Humidity Range : 20 to 80% RH Storage Conditions : Temperature Range : -20 to 40°C Humidity Range : 10 to 90% RH Package Dimensions : 375 x 113 x 125 mm',
    0, 0, NOW(), NOW()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    discount_price = EXCLUDED.discount_price,
    sku = EXCLUDED.sku,
    category_id = EXCLUDED.category_id,
    is_active = TRUE,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description,
    updated_at = NOW()
  RETURNING id
), deleted_images AS (
  DELETE FROM images WHERE product_id = (SELECT id FROM prod)
), upsert_inventory AS (
  INSERT INTO inventory (product_id, quantity, low_stock_threshold, warehouse_location, created_at, updated_at)
  VALUES ((SELECT id FROM prod), 23, 5, NULL, NOW(), NOW())
  ON CONFLICT (product_id) DO UPDATE SET quantity = EXCLUDED.quantity, updated_at = NOW()
)
INSERT INTO images (product_id, url, alt_text, is_primary, position, created_at, updated_at)
VALUES
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a27da5b1a2cd.jpeg', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', TRUE, 0, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa929c33ba.png', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 1, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fa9a443cd7.png', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 2, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa2df1594.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 3, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faa90d48d0.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 4, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fae68e5683.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 5, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faed44e454.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 6, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2faf3f191fc.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 7, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fafaa148b1.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 8, NOW(), NOW()),
  ((SELECT id FROM prod), 'https://amwajalmsela.org/storage/photos/1/6a2fb00d129a5.webp', 'HP 85A Black original LaserJet Toner Cartridge (CE285A)', FALSE, 9, NOW(), NOW());

COMMIT;

-- Quick check after import:
-- SELECT COUNT(*) FROM products;
-- SELECT COUNT(*) FROM images;