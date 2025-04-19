-- SQL PROJECT- MUSIC STORE DATA ANALYSIS 

-- 1.Who is the senior most employee based on job title? 

select* from employee e ;

select first_name, last_name,title,levels
from employee e 
order by e.levels desc
limit 1;

-- 2.Which countries have the most Invoices?

select* from invoice i ;

select count(*) as top_invoices, billing_country
from invoice
group by billing_country 
order by top_invoices desc
limit 5;

-- 3.	What are top 3 values of total invoice? 

select total
from invoice i 
order by total desc
limit 3;

-- 4.Which city has the best customers? 
-- We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals 

select* from invoice i ;

select billing_city, sum(total) as most_invoices
from invoice i 
group by billing_city 
order by most_invoices desc
limit 1;

-- 5.Who is the best customer? 
-- The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money 

select* from customer c ;

select customer.customer_id, customer.first_name s_name, customer.last_name, sum(invoice.total) as total
from customer 
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;


-- 6.Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A 

select* from customer c  ;



select distinct email, first_name, last_name
from customer
join invoice on customer.customer_id= invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
select track_id
from track
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock')
order by email;

-- 7.Let's invite the artists who have written the most rock music in our dataset. --- rock music in genre
-- Write a query that returns the Artist name and total track count of the top 10 rock bands ---artist name in artist table, tracks in tracks top 10

select* from genre g ;--genre_id
select* from artist a  ; --artist_id
select* from album a ;--artist_id
select* from track t ;--genre_id

SELECT 
  a.artist_id, 
  a.name, 
  COUNT(a.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist a ON a.artist_id = album.artist_id
JOIN genre g ON g.genre_id = track.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY number_of_songs DESC
LIMIT 10;

-- 8.Return all the track names that have a song length longer than the average song length. -- track name
--Return the Name and Milliseconds for each track. -- miliseconds
--Order by the song length with the longest songs listed first --desc

select* from track t ;

select name, milliseconds
from track t 
where milliseconds  > (select AVG(milliseconds) from track)
order by milliseconds desc;


--9.Find how much amount spent by each customer on artists? - amount
--Write a query to return customer name, artist name and total spent --customer name, artist name, time spent

select* from invoice_line il  ;

select c.first_name || ' ' || c.last_name as CustomerName ,a2.name as ArtistName, sum(il.unit_price *il.quantity) as amount_spent
from customer c 
join invoice i on i.customer_id = c.customer_id
join invoice_line il on il.invoice_id = i.invoice_id 
join track t on t.track_id = il.track_id
join album a on a.album_id = t.album_id 
join artist a2 on a2.artist_id = a.artist_id 
group by customername, artistname 
order by amount_spent desc;












  







