-- ########################################

CREATE VIEW `ordersview` AS
    SELECT 
        `orders`.`orders_id` AS `orders_id`,
        `orders`.`quantity` AS `quantity`,
        `orders`.`price` AS `price`
    FROM
        `orders`
    WHERE
        (`orders`.`quantity` > 2)