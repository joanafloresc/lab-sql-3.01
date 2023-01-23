USE sakila;

-- 1. Drop column picture from staff.
ALTER TABLE sakila.staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO sakila.staff (first_name, last_name, address_id, store_id, username)
SELECT first_name, last_name, address_id, store_id, first_name
FROM customer WHERE first_name IN('TAMMY');

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
INSERT INTO sakila.rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
NOW(),

(SELECT min(inventory_id) FROM inventory 
WHERE film_id IN (
	SELECT film_id 
	FROM film
	WHERE title IN('ACADEMY DINOSAUR'))
AND store_id = 1),

(SELECT customer_id FROM customer 
WHERE first_name IN('Charlotte') AND last_name IN('Hunter')),

(SELECT staff_id FROM staff 
WHERE first_name IN('mike'))
)