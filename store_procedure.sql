DROP PROCEDURE IF EXISTS CancelOrder;

CREATE PROCEDURE CancelOrder(IN p_order_id int)
BEGIN
	DELETE FROM orders WHERE orders_id = p_order_id;
    IF ROW_COUNT() > 0 THEN
        SELECT 'confirmation' AS status,
               CONCAT('Order ', p_order_id, ' deleted.') AS message;
    ELSE
        SELECT 'confirmation' AS status,
               CONCAT('Order ', p_order_id, ' not found.') AS message;
    END IF;
END

-- ############################3

DROP PROCEDURE IF EXISTS GetMaxQuantity;
CREATE  PROCEDURE GetMaxQuantity()
BEGIN
	SELECT MAX(quantity) AS 'Max Quantity in Order' FROM orders;
END