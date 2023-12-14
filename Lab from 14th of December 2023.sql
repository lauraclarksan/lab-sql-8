-- Lab 8 Unit 2
-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over (order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- rank()

select title, length, dense_rank() over (order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- dense_rank()

select title, length, row_number() over (order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- row_number()

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, length, rating, rank() over (partition by rating order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- rank()

select title, length, rating, dense_rank() over (partition by rating order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- dense_rank()

select title, length, rating, row_number() over (partition by rating order by length desc) as 'Rank' from sakila.film
where length <> '0' or ' '; -- row_number()

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from sakila.category;
select * from sakila.film_category;

select a.name as 'Category', count(b.film_id) as 'Film count'
from sakila.category as a
join sakila.film_category as b on a.category_id = b.category_id
group by a.name
order by a.name asc;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from sakila.actor;
select * from film_actor;

select a.first_name, a.last_name, count(b.film_id) as 'Number of times appeared'
from sakila.actor as a
join sakila.film_actor as b on a.actor_id = b.actor_id
group by first_name, last_name
order by first_name asc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select * from sakila.customer;
select * from sakila.rental;

select a.first_name, a.last_name, count(rental_id) as 'Number of rentals'
from sakila.customer as a
join sakila.rental as b on a.customer_id = b.customer_id
group by first_name, last_name
order by first_name asc;

-- Bonus: Which is the most rented film?
select * from sakila.film;
select * from sakila.inventory;
select * from sakila.rental;

select a.title, count(c.rental_id) as 'Rental count'
from sakila.film as a
join sakila.inventory as b on a.film_id = b.film_id
join sakila.rental as c on b.inventory_id = c.inventory_id
group by a.title
order by `Rental count` desc
limit 1;