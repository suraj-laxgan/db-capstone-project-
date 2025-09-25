PREPARE GetOrderDetail 
FROM 'SELECT orders_id, quantity, price FROM orders WHERE price = ?';
SET @id = 100;
EXECUTE GetOrderDetail USING @id;
-- DEALLOCATE PREPARE GetOrderDetail;