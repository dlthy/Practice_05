--Bài 1
select country.continent, floor(avg(city.population)) from city 
inner join country on CITY.CountryCode = COUNTRY.Code 
group by country.continent;
--Bài 2
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
--Bài 3
SELECT 
  age.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
      SUM(activities.time_spent),2) AS send_perc, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
      SUM(activities.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;
--Bài 4
SELECT 
  customers.customer_id
FROM 
  customer_contracts AS customers
LEFT JOIN products 
  ON customers.product_id = products.product_id
GROUP BY 
  customers.customer_id
HAVING 
  COUNT(DISTINCT products.product_category) = 3;
--Bài 5
select e1.reports_to as employee_id,
       e2.name,
       count(e1.reports_to) as reports_count,
       round(avg(e1.age),0) as average_age
from employees e1
join employees e2
on e1.reports_to=e2.employee_id
group by e1.reports_to
order by e1.reports_to
--Bài 6
  select a.product_name, sum(unit) as unit
from Products a
left join Orders b
on a.product_id = b.product_id
where b.order_date between '2020-02-01' and '2020-02-29'
group by a.product_id
having sum(unit) >= 100
--Bài 7
  SELECT pg.page_id from pages pg 
LEFT JOIN page_likes as pl 
ON pg.page_id = pl.page_id 
where pl.page_id is NULL 
ORDER BY pg.page_id Asc;
--MID-TERM TEST
--Bài 1
select 
distinct(replacement_cost) 
from film
order by replacement_cost 
--Bài 2
  select 
case
	when replacement_cost between 9.99 and 19.99 then 'low'
	when replacement_cost between 20.00 and 24.99 then 'medium'
	else 'high'
end as category,
count (*) as so_luong
from film
group by category

--Bài 3
select film.title, film.length,category.name
from film
join film_category
on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where name in ('Drama', 'Sports')
order by length desc
--Bài 4
select category.name,
count(category.name) as so_luong
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name
order by count(category.name) desc
--Bài 5
select 
concat(first_name,' ',last_name) as name, 
count (concat(first_name,' ',last_name)) as so_luong
from actor 
join film_actor
on actor.actor_id = film_actor.actor_id
group by concat(first_name,' ',last_name)
order by count (concat(first_name,' ',last_name)) desc
--Bài 6
  select address.address, customer.customer_id,
count(address.address) 
from address
left join customer on address.address_id=customer.address_id
where customer.customer_id is null 
group by address.address,customer.customer_id
--Bài 7
select city.city,
sum(payment.amount) as doanh_thu
from city
join address on city.city_id = address.city_id
join customer on address.address_id=customer.address_id
join payment on customer.customer_id = payment.customer_id
group by city.city
order by sum(payment.amount) desc
--Bài 8
select concat(city.city,' ', country.country),
sum(payment.amount) as doanh_thu
from city
join country on city.country_id = country.country_id
join address on city.city_id = address.city_id
join customer on address.address_id=customer.address_id
join payment on customer.customer_id = payment.customer_id
group by city.city,country.country
order by sum(payment.amount) 

