-- Use our database
USE ShopDB;

START TRANSACTION;

UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1 AND WarehouseAmount >= 1;

SELECT ROW_COUNT() INTO @affected_rows;

INSERT INTO Orders (CustomerID, Date)
SELECT '1', '2023-01-01'
WHERE @affected_rows > 0;

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, ProductID, Count)
SELECT @new_order_id, 1, 1
WHERE @affected_rows > 0;

COMMIT;
