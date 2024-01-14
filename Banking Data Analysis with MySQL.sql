
use bank;
select * from bank_inventory;
# 1) What is the value of Geo_Location for product : ‘PayCard’?

#ANS-1)
update bank_inventory set geo_location = 'Noida' where Product='PayCard';
update bank_inventory set geo_location = null where Product='PayPoint';

# 2) How many characters does the  Product : ‘PayCard’ store in the Bank_Inventory table.

#ANS-2)
select char_length('PayCard') from bank_inventory;

# Question 3:
# a) Update the Geo_Location field from NULL to ‘Delhi-City’ 
# b) How many characters does the  Geo_Location field value ‘Delhi-City’ stores in the Bank_Inventory table

#Ans-3)
update bank_inventory set Geo_location = 'Delhi-City' where Geo_location = null;

# Question 4:
# 4) Step 1: Insert today’s date details in all fields of Bank_Holidays 
-- Step 2: After step1, perform the below 
-- Postpone Holiday to next day by updating the Holiday field

#ANS-4)
insert into bank_holidays values(curdate(),current_timestamp(),'2023-06-10 23:59:59');
set sql_safe_updates = 0;

# 5) Modify  the Start_time data with today's datetime in the Bank_Holidays table 

#ANS-5)
update bank_holidays set start_time = current_timestamp() where start_time = '2023-06-08 14:10:27';

# 6) Update the End_time with UTC time(GMT Time) in the Bank_Holidays table.

#ANS-6)
update bank_holidays set end_time = current_timestamp() where start_time = '2023-06-08 08:39:50';

# 7) Modify  the End_time data with today's datetime in the Bank_Holidays table

#ANS-7)
update bank_holidays set end_time = current_timestamp() where start_time = '2023-06-08 08:39:50';


# 8) Display the first five rows of the Geo_location field of Bank_Inventory.
#ANS-8)
select product, geo_location from bank_inventory limit 5;

# Question 9:
# 9) Print sum of Purchase_cost and average of estimated_sale_price of table
# Bank_inventory_pricing  during 2nd month . 

#ANS-9)
select sum(Purchase_cost) as purchase_cost, avg(estimated_sales_price) as avg_saleprice from bank_inventory_pricing where month = 2;

# Question 10:
# 10) Print average of estimated_sale_price upto two decimals from bank_inventory_pricing table.

#ANS-10)

select round(avg(estimated_sales_price),2) as avg_saleprice from bank_inventory_pricing;

# Question 11:
# 11) Print the sum of  purchase_cost of Bank_Inventory_pricing table with default value of 2000/-
# if there is no value given

#ANS-11
select product, coalesce(sum(purchase_cost),2000) as Purchase_Cost
from bank_inventory_pricing ;

# Question 12:
# 12) Print unique records of bank_inventory_pricing without displaying the month.

#ANS-12)
select distinct product, quantity, price, purchase_cost, Estimated_sales_price
from bank_inventory_pricing;

# Question 13:
# 13) Print the Products which are appearing in bank_inventory_pricing more than once during the month : 1

#ANS-13)

select Product, month from bank_inventory_pricing where month = 1 group by product having count(product) >1;

# Question 14:
# 14) Print Products that are appearing more than once in bank_inventory_pricing and whose purchase_cost is
# greater than  estimated_sale_price , assuming estimated_sale_price is 0 when there is no value given


#ANS-14)
select bi.Product, bi.purchase_cost, COALESCE(estimated_sale_price, 0)
from bank_inventory_pricing bp join bank_inventory bi on bi.product = bp.product group by bi.product
having count(bi.product)>1 and purchase_cost > estimated_sale_price ;


# Question 15:
# 15) Print product and the difference of maximum and minimum purchase_cost of each product in Bank_Inventory_Pricing.

#ANS-15)
Select Product, max(purchase_cost) - min(purchase_cost) as Cost_difference
from bank_inventory group by Product;


# Question 16:
# 16) Print the sum of Purchase_cost of Bank_inventory_pricing during 1st and 2nd month

#ANS-16)
SELECT SUM(Purchase_cost) AS Total_Purchase_Cost
FROM bank_inventory, bank_inventory_pricing where Month<=2;


# Question 17:
# 5) Print Products with an average value of Purchase_cost per product only when exceeding average of 6000.

#ANS-17
Select Product, avg(purchase_cost)from bank_inventory
group by Product
having avg(purchase_cost)>6000;


# Question 18:
# 18) Print  products whose average of purchase_cost is less than sum of purchase_cost of  Bank_inventory_pricing.

#ANS-18)

select Product from bank_inventory group by product having avg(purchase_cost)<sum(purchase_cost);

# Question 19:
# 19) Print product and its average of Estimated_sale_price when  purchase_cost is not mentioned.

#ANS-19)
select product, avg(Estimated_sale_price)from bank_inventory
where purchase_cost is null group by Product;



# Question 20:
# 20) Display maximum estimated_sale_price of each product  when the product total quantity is exceeding 4 
# and its purchase_cost has some value given.

#ANS-20)
select product, max(estimated_sale_price) from bank_inventory
where quantity>4 and purchase_cost is not null group by product;

# Question 21:
# 21) Print products whose average of purchase_cost per product is less than 200
#  from the table Bank_inventory_pricing

#ANS-21)
select product, avg(purchase_cost) from bank_inventory_pricing where avg(purchase_cost)< 200 group by product;

# Question 22:
# 22) Print each Product with its highest estimated_sale_price in bank_inventory_pricing

#ANS-22)
select Product,estimated_sale_price from bank_inventory_pricing order by Estimated_sale_price desc limit 1;

# Question 23:
# 23) Print product with an increase in  average of estimated_sale_price  by 15% when average product_cost is more than average 
# estimated_sale_price

#ANS-23)
Select avg(Estimated_sale_price)*1.15 as new_price
from bank_inventory_pricing group by Product having avg(purchase_cost)>avg(Estimated_sale_price);

# Question 24:
# 24) For product = ‘BusiCard’,  print average of purchase_cost on condition that when purchase_cost  
# is not given, choose any of the higher value between price  and estimated_sale_price

#ANS-24)
select Product, avg(ifnull(purchase_cost, greatest(price,estimated_sale_price))) from bank_inventory
where Product = 'BusiCard' group by Product;

# Question 25:
# 25) Calculate average estimated_sale_price for each product .
# For any null estimated_sale_price, replace the value with purchase_cost

#ANS-25)
select Product, avg(ifnull(Estimated_sale_price, purchase_cost)) from bank_inventory_pricing group by Product;


# Question 26:
# 26) Print products and their avg price on condition that products appeared in at least three different months.

#ANS-26)
Select bp.Product, avg(Price) from bank_inventory_pricing bp,
bank_inventory bi group by Product having count(distinct(month))>=3;


# Question 27:
# 27) print the average of Purchase_cost from the table Bank_inventory_pricing.If the purchase_cost has  no value given
#   then it’s value is equal to estimated_sale_price.

#ANS-27)

Select Product, avg(ifnull(purchase_cost,Estimated_sale_price)) from bank_inventory_pricing group by Product;


# Question 28:
# 28) Print the count of unique Products used in  Bank_inventory_pricing

#ANS-28)
select count(distinct Product) from bank_inventory_pricing;