USE sakila;

#21. List all films along with their corresponding categories

SELECT f.title AS film_title, c.name AS category_name
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY f.title , c.name;

#22. Show the names of all customers along with their rented films.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
f.title AS rented_film_title
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
ORDER BY customer_name;
USE sakila;

#23. Retrieve the names of all staff members and their respective stores.

SELECT CONCAT(sta.first_name, ' ' , sta.last_name) AS staff_name,
sto.store_id AS store_number
FROM staff sta
JOIN store sto ON sto.store_id = sta.store_id
ORDER BY staff_name;

#24. List all films along with their actors

SELECT f.title AS film_title, 
CONCAT(a.first_name, ' ' , a.last_name) AS actor_name
FROM film f
JOIN film_actor fa  ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
ORDER BY  film_title, actor_name;

#25. Display the category name and the number of films in each category.

SELECT c.name AS category_name, 
COUNT(f.film_id) AS number_of_film
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name 
ORDER BY number_of_film DESC;

#26. Find the film with the highest rental rate using a subquery.

#highest rental rate 
SELECT MAX(rental_rate) FROM film;

# WITH SUBQUERY 
SELECT title, rental_rate 
FROM film
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);

#WITHOUT SUBQUERY 
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC;

#27. List all customers who have rented more than 5 films.

SELECT customer_id FROM rental 
GROUP BY customer_id 
HAVING COUNT(rental_id) > 5;

SELECT first_name, last_name, customer_id
FROM customer 
WHERE customer_id IN (
SELECT customer_id FROM rental 
GROUP BY customer_id 
HAVING COUNT(rental_id) > 5);

#28. Retrieve the titles of films that have been rented more than 50 times.

SELECT i.film_id 
FROM inventory i
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY i.film_id
HAVING COUNT(r.rental_id) > 10;

SELECT f.title
FROM film f
WHERE f.film_id IN(SELECT i.film_id 
FROM inventory i
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY i.film_id
HAVING COUNT(r.rental_id) > 10);

#29. Find the stores with the most customers using a subquery.
USE sakila;
SELECT store_id, COUNT(customer_id) AS customer_count
FROM customer
GROUP BY store_id;

SELECT MAX(customer_count)
FROM(
SELECT store_id, COUNT(customer_id) AS customer_count
FROM customer 
GROUP BY store_id
)
AS store_counts;

SELECT store_id FROM customer 
GROUP BY store_id 
HAVING COUNT(customer_id) =
(
SELECT MAX(customer_count)
FROM(
SELECT store_id, COUNT(customer_id) AS customer_count
FROM customer 
GROUP BY store_id
)
AS store_count
);

#WITHOUT QUERY 
SELECT store_id, COUNT(customer_id) AS total_customer
FROM customer
GROUP BY store_id
ORDER BY total_customer DESC
LIMIT 1;

#30. Get the names of customers who have never rented a film.

SELECT first_name, last_name
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE r.customer_id IS NULL;
  







