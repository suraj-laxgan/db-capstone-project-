CREATE VIEW `orderdetails` AS
    SELECT 
        `o`.`orders_id` AS `orders_id`,
        `o`.`booking_id` AS `booking_id`,
        `m`.`menu_name` AS `menu_name`,
        `m`.`price` AS `price`,
        `o`.`quantity` AS `quantity`,
        (`o`.`price` * `o`.`quantity`) AS `Total_Price`,
        `bt`.`name` AS `table_name`,
        `c`.`castomer_name` AS `castomer_name`,
        `s`.`name` AS `name`
    FROM
        (((((`orders` `o`
        JOIN `menu` `m` ON ((`o`.`menu_id` = `m`.`menu_id`)))
        JOIN `bookings` `b` ON ((`o`.`booking_id` = `b`.`booking_id`)))
        JOIN `book_table` `bt` ON ((`b`.`book_table_id` = `bt`.`id`)))
        JOIN `castomers` `c` ON ((`b`.`book_by_casotmer_id` = `c`.`castomer_id`)))
        JOIN `staffs` `s` ON ((`b`.`assign_to_staff_id` = `s`.`staff_id`)))
    WHERE
        (`o`.`price` >= 50)