-- 1. List all customer who live in Texas(use Joins)
select customer.first_name, customer.last_name, district
from customer 
full join address 
on customer.address_id = address.address_id  
where district = 'Texas';
-- 5 customers

-- 2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, amount
from customer 
full join payment 
on customer.customer_id = payment.customer_id 
where amount > 6.99;
-- 1498 payments



--3. Show all customers names who have made payments over $175 (use subqueries)
select first_name, last_name
from customer 
where customer_id in (
	select customer_id
	from payment 
	group by customer_id
	having SUM(amount) > 175
	order by SUM(amount) desc 
)
-- 12 customers


-- 4. List all customers that live in Nepal(use the city table)
select customer.first_name, customer.last_name, city 
from customer
full join address
on customer.address_id = address.address_id 
full join city 
on address.city_id = city.city_id 
where city = 'Nepal';
-- Nepal isn't a city that appears in the city table


-- 5. Which staff member had the most transactions?
select staff_id, count(payment_id)
from payment 
group by staff_id
-- staff_id 2 has 7,304

-- 6. How many movies of each rating are there?
select rating, count(rating)
from film 
group by rating
-- pg-13 has 223, nc-17 has 209, g has 179, pg has 194, r has 195


-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name 
from customer 
where customer_id in (
	select customer_id
	from payment 
	group by customer_id, amount
	having amount > 6.99
	order by amount desc 
)
-- 538 customers


-- 8. How many free rentals did our stores give away?
select amount 
from rental 
full join payment 
on payment.rental_id = rental.rental_id 
where amount = 0.00;
-- 23 free rentals
