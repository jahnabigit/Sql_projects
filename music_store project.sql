--1. Who is the senior most employee based on job title?

select * from employee order by levels desc limit 1;

--2. Who is the senior most employee based on Age?

select first_name,last_name,title,(extract(year from current_date)-(extract(year from birthdate))) as Age from employee order by Age desc limit 1;

--3. Who is the most senior in terms of working years?

select first_name,last_name,title, (extract(year from current_date)-(extract(year from hire_date))) As Oldest_employee from employee order by Oldest_employee desc limit 5;

--4.Which countries have the most Invoices?

select count(*) as c,
billing_country as country 
from invoice 
group by billing_country
order by c desc;

--5.What are top 3 values of total invoice?

select total
from invoice
order by total desc
limit 3;

--6.Which city has the best customers? We would like to throw a promotional Music 
--Festival in the city we made the most money. Write a query that returns one city that 
--has the highest sum of invoice totals. Return both the city name & sum of all invoice 
--totals

select billing_city as city ,sum(total) as total_invoice
from invoice
group by city
order by total_invoice desc

--7.Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

select customer.first_name as name, 
customer.customer_id,
sum(invoice.total) as Total
from customer join invoice
on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by Total desc
limit 1

--8.Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A

SELECT distinct email, first_name, last_name
from customer 
JOIN invoice on customer.customer_id=invoice.customer_id
JOIN invoice_line on invoice.invoice_id=invoice_line.invoice_id
WHERE track_id IN(
	select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name like 'Rock'
)
order by email;

--9. Let's invite the artists who have written the most rock music in our dataset. Write a qry that returns the Artist name and total track count of the top 10 rock ban

select artist.name, artist.artist_id,
count(artist.artist_id) as Number_of_songs
from artist 
join album on artist.artist_id=album.artist_id
join track on album.album_id=track.album_id
where track_id In(
	select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name LIKE 'Rock'
	)
	group by artist.artist_id
	order by Number_of_songs desc
	limit 10
	
--10.Return all the track names that have a song length longer than the average song length.return the Name and Milliseconds for each track. Order by the song length with the long songs listed first


select name, milliseconds from track 
where milliseconds>
(
select avg(milliseconds)
from track
	)
	
order by milliseconds desc


