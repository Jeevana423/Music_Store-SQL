-- 1. Genre and MediaType
create database music;
use music;
CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 2. Employee
CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
);

-- 4. Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);


show tables;
select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoiceline;
select * from mediatype;
select * from playlist;
select * from playlisttrack;
select * from track;

select title,min(hire_date) as join_date 
from employee
group by title
order by join_date desc;

select billing_country, count(*) as number_of_invoice
from invoice
group by billing_country
order by number_of_invoice desc;

select invoice_id, total from invoice
order by total
limit 3;

select billing_city, sum(total) as total_invoice
from invoice
group by billing_city
order by total_invoice
limit 1;

select customer_id, sum(total) as total_spent
from invoice
group by customer_id
order by total_spent desc
limit 1;

select c.customer_id, c.first_name, c.last_name, sum(i.total) as total_spent
from customer c
join invoice i
on c.customer_id = i.customer_id
group by customer_id
order by total_spent desc
limit 1;

select distinct c.email, c.first_name, c.last_name, g.name as genre
from customer c
join invoice i
on  c.customer_id = i.customer_id
join invoiceline il
on i.invoice_id = il.invoice_id
join track t
on il.track_id = t.track_id
join genre g
on t.genre_id = g.genre_id
where g.name = 'Rock'
order by c.email asc;

select a.name, count(track_id) as total_tracks
from artist a
join album al
on a. artist_id = al. artist_id
join track t
on al.album_id = t.album_id
join genre g
on t.genre_id = g.genre_id
where g.name = 'rock'
group by a.artist_id,a.name
order by total_tracks desc
limit 10;

select name, milliseconds
from track 
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;

select c.first_name as customer_name, a.name as artist_name, sum(il.unit_price*il.quantity) as total_spent
from customer c
join invoice i
on c.customer_id = i.customer_id
join invoiceline il
on i.invoice_id = il.invoice_id
join track t
on il.track_id =t.track_id
join album al
on t.album_id = al.album_id
join artist a 
on al.artist_id = a.artist_id
group by c.customer_id, c.first_name,a.artist_id, a.name
order by total_spent desc;

select i.billing_country, g.name as genre, count(*) as tot_spent
from invoice i
join invoiceline il
on i.invoice_id = il.invoice_id
join track t
on il.track_id = t.track_id
join genre g
on t.genre_id = g.genre_id
group by i.billing_country,g.name
order by i.billing_country,tot_spent;


SELECT 
    c.country,
    c.first_name,
    SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.country, c.customer_id, c.first_name
HAVING SUM(i.total) = (
    SELECT MAX(total_spent)
    FROM (
        SELECT 
            c2.customer_id,
            c2.country,
            SUM(i2.total) AS total_spent
        FROM customer c2
        JOIN invoice i2
        ON c2.customer_id = i2.customer_id
        GROUP BY c2.country, c2.customer_id
    ) t
    WHERE t.country = c.country
);