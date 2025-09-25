INSERT INTO bookings(booking_id,book_table_id,booking_date,book_by_casotmer_id,assign_to_staff_id)
VALUES(3,1,'2022-10-11',1,1),
(4,2,'2022-10-13',2,1)


-- #######################################

SELECT booking_id AS BookingId,booking_date AS BookingDate,book_table_id AS TableNumber,book_by_casotmer_id AS CustomerID
FROM bookings


-- #########################################

DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(IN p_booking_date DATE,IN p_table_no INT)
BEGIN
DECLARE table_status VARCHAR(100);
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN CONCAT('Table ', p_table_no, ' Already Booked')
        ELSE CONCAT('Table ', p_table_no, 'Available')
    END
INTO table_status
FROM bookings
WHERE booking_date = p_booking_date
  AND book_table_id  = p_table_no;
  SELECT table_status AS 'Booking Status';

END
//
DELIMITER ;
CALL CheckBooking('2022-10-13',2)


-- #########################################

DROP PROCEDURE IF EXISTS AddValidBooking
DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN p_booking_date DATE,
    IN p_table_no INT,
    IN p_customer_id INT,
    IN p_staff_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    START TRANSACTION;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_date = p_booking_date
      AND book_table_id  = p_table_no;

    IF v_exists > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', p_table_no,
                      ' is already booked on ',
                      DATE_FORMAT(p_booking_date,'%Y-%m-%d')
                     ) AS 'Booking Status';
    ELSE
        INSERT INTO bookings (booking_date,book_table_id,book_by_casotmer_id,assign_to_staff_id)
        VALUES (p_booking_date, p_table_no, p_customer_id, p_staff_id);

        COMMIT;
        SELECT CONCAT('Booking confirmed: Table ', p_table_no,
                      ' on ',
                      DATE_FORMAT(p_booking_date,'%Y-%m-%d')
                     ) AS 'Booking Status';
    END IF;
END //
DELIMITER ;
call AddValidBooking('2025-09-24',1,1,1)


