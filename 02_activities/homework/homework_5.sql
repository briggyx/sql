-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */


-- Step 1: CROSS JOIN between vendor_inventory and customers
WITH cross_join_sales AS (
    SELECT 
        vi.vendor_id,
        vi.product_id,
        5 * vi.original_price AS total_sales_per_customer_per_product,
        c.customer_id
    FROM vendor_inventory vi
    CROSS JOIN customer c
)

-- Step 2: Replace vendor_id and product_id with vendor_name and product_name, and calculate total sales
SELECT 
    v.vendor_name, 
    p.product_name, 
    COUNT(cjs.customer_id) * SUM(cjs.total_sales_per_customer_per_product) AS total_sales
FROM cross_join_sales cjs
JOIN vendor v ON cjs.vendor_id = v.vendor_id
JOIN product p ON cjs.product_id = p.product_id
GROUP BY v.vendor_name, p.product_name;

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TABLE product_units AS
SELECT 
    product_id,
    product_name,
    product_size,
    product_category_id,
    product_qty_type,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES (7, 'Apple Pie', '1 lb', 3, 'unit', CURRENT_TIMESTAMP);


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units
WHERE product_id = 7
AND snapshot_timestamp = (
    SELECT snapshot_timestamp
    FROM product_units
    WHERE product_id = 7
    ORDER BY snapshot_timestamp ASC
    LIMIT 1
);

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

-- Step 2: Update the current_quantity with the last known quantity from vendor_inventory

ALTER TABLE product_units
ADD current_quantity INT;


UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(vi.quantity, 0) -- If quantity is NULL, replace with 0
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    ORDER BY vi.market_date DESC -- Get the most recent quantity by market_date
    LIMIT 1
)
WHERE EXISTS (
    SELECT 1
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
);


