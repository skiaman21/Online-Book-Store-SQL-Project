-- 1) Retrieve all books in the "Fiction" genre:
select * from Books where genre='Fiction';

-- 2) Find books published after the year 1950:
select * from Books where published_year>1950;

-- 3) List all customers from the Canada:
select * from Customers where country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_Stock from books;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where total_amount>20;

-- 9) List all genres available in the Books table:
select Distinct genre from  books;

-- 10) Find the book with the lowest stock:
select * from books order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) from orders;

--Advance questions

-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(o.quantity) as total_book
from books b
join orders o
on b.book_id=o.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) from books where genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;


-- 4) Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as order_count 
from orders o
join books b
on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc 
limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where genre='Fantasy' order by price desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) as total_quantity
from books b
join orders o
on b.book_id=o.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city
from orders o
join customers c
on o.customer_id=c.customer_id
where total_amount>30;

-- 8) Find the customer who spent the most on orders:
select c.name, sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customer_id=o.customer_id 
group by c.name
order by total_spent desc
limit 1;

--9) Calculate the stock remaining after fulfilling all orders:
select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) as stock_sold,
b.stock-coalesce(sum(o.quantity),0) as stock_left
from books b
left join orders o
on b.book_id=o.book_id
group by b.book_id,b.title, b.stock
order by b.book_id;



