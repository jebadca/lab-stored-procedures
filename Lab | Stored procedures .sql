USE sakila;

#1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:
DELIMITER //
CREATE PROCEDURE GetCustomersInActionCategory()
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = 'Action'
  GROUP BY first_name, last_name, email;
END //
DELIMITER ;

#2. Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.
DELIMITER //
CREATE PROCEDURE GetCustomersInCategory(IN categoryName VARCHAR(255))
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = categoryName
  GROUP BY first_name, last_name, email;
END //
DELIMITER ;

CALL GetCustomersInCategory('Action');

#3. Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.
DELIMITER //
CREATE PROCEDURE GetPopularCategories(IN minMovies INT)
BEGIN
  SELECT category.name AS Category, COUNT(film.film_id) AS Number_of_Movies
  FROM film
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON category.category_id = film_category.category_id
  GROUP BY category.name
  HAVING Number_of_Movies > minMovies;
END //
DELIMITER ;

CALL GetPopularCategories(50);