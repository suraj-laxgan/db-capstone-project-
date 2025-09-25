DROP PROCEDURE IF EXISTS AddBooking
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN p_booking_date DATE,
    IN p_table_no INT,
    IN p_customer_id INT,
    IN p_staff_id INT
)
BEGIN
    INSERT INTO bookings (booking_date,book_table_id,book_by_casotmer_id,assign_to_staff_id)
    VALUES (p_booking_date, p_table_no, p_customer_id, p_staff_id); 
    SELECT "New Booking is Added" AS 'Confirmation';      
END 
//
DELIMITER ;
call AddBooking('2025-09-23',1,1,1)

-- Update Procedure

DROP PROCEDURE IF EXISTS UpdateBooking
DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN p_booking_id INT,
    IN p_booking_date DATE
   )
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF v_exists > 0 THEN
		UPDATE bookings SET booking_date = p_booking_date WHERE booking_id = p_booking_id;
		SELECT concat("Booking id ", p_booking_id, " Updated") AS 'Confirmation';
    ELSE
        SELECT "Booking id is invalid" AS 'Confirmation';
    END IF;
END 
//
DELIMITER ;
call UpdateBooking(6,'2022-12-17')


-- Delete Procedure

DROP PROCEDURE IF EXISTS CancelBooking 
DELIMITER //
CREATE PROCEDURE CancelBooking(IN p_booking_id INT)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO v_exists
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF v_exists > 0 THEN
		DELETE FROM bookings WHERE booking_id = p_booking_id;
		SELECT concat("Booking id ", p_booking_id, " Cancelled") AS 'Confirmation';
    ELSE
        SELECT "Booking id is invalid" AS 'Confirmation';
    END IF;
END 
//
DELIMITER ;
call CancelBooking(6)