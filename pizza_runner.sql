
-- 1.How many pizzas were ordered?
select 
	count(*) as total_pizzas_ordered
from customer_orders;        

-- 2.How many unique customer orders were made?
select 
	count(distinct order_id) as unique_cus_orders
from customer_orders;

-- 3.How many successful orders were delivered by each runner?
select
    runner_id,
    count(*) as successful_orders
from runner_orders
where pickup_time is not null and pickup_time != 'null'
group by runner_id
order by runner_id;

-- 4.How many of each type of pizza was delivered?
select
	pizza_id,
	count(*) as total_pizzas_delivered
from customer_orders co
join runner_orders   ro
on co.order_id=ro.order_id
where pickup_time is not null and pickup_time != 'null'
group by pizza_id
order by pizza_id;        

-- 5.How many Vegetarians and Meatlovers were ordered by each customer?
select 
	co.customer_id,
	pn.pizza_name,
	count(*) as cnt
from  customer_orders co
join pizza_names pn
on co.pizza_id=pn.pizza_id
group by  co.customer_id,pn.pizza_name 
order by  co.customer_id,pn.pizza_name;   

-- 6.What was the maximum number of pizzas delivered in a single order?
select
	co.order_id,
	count(*) as pizzas_delivered
from customer_orders co
join runner_orders ro
on co.order_id = ro.order_id
where ro.cancellation is null
   or ro.cancellation = ''
   or ro.cancellation = 'null'
group by co.order_id
order by pizzas_delivered desc
limit 1;

-- 7.	For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select
    co.customer_id,
    sum(
        case
            when (co.exclusions is not null and co.exclusions != '' and co.exclusions != 'null')
              or (co.extras is not null and co.extras != '' and co.extras != 'null')
            then 1 else 0
        end) as pizzas_with_changes,
    sum(
        case
            when (co.exclusions is null or co.exclusions = '' or co.exclusions = 'null')
             and (co.extras is null or co.extras = '' or co.extras = 'null')
            then 1 else 0
        end) as pizzas_with_no_changes
from customer_orders co
join runner_orders ro
    on co.order_id = ro.order_id
where ro.cancellation is null
   or ro.cancellation = ''
   or ro.cancellation = 'null'
group by co.customer_id
order by co.customer_id;
   

-- 8.	How many pizzas were delivered that had both exclusions and extras?
select
    count(*) pizzas_cnt
from customer_orders co
join runner_orders ro
    on co.order_id = ro.order_id
where ro.cancellation is null
   or ro.cancellation = ''
   or ro.cancellation = 'null' and
 (co.exclusions is not null and co.exclusions != '' and co.exclusions != 'null')
              and (co.extras is not null and co.extras != '' and co.extras != 'null');


select
    count(*) as pizzas_with_both_exclusions_and_extras
from customer_orders co
join runner_orders ro
    on co.order_id = ro.order_id
where (ro.cancellation is null
    or ro.cancellation = ''
    or ro.cancellation = 'null')
and (co.exclusions is not null and co.exclusions != '' and co.exclusions != 'null')
and (co.extras is not null and co.extras != '' and co.extras != 'null');


-- 9.What was the total volume of pizzas ordered for each hour of the day?
select
	hour(order_time) as hour_of_day,
	count(*) as pizza_cnt
from customer_orders
group by hour_of_day
order by hour_of_day;       


-- 10.What was the volume of orders for each day of the week?
select
	dayname(order_time) as day_of_week,
	count(*) as pizza_cnt
from customer_orders
group by day_of_week
order by day_of_week;

-- 11.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select 
     t.runner_id,
     round(avg(pickup_duration))
from
(select 
      ro.runner_id,
      timestampdiff(minute,co.order_time,ro.pickup_time) as pickup_duration
from customer_orders co
join runner_orders ro
on co.order_id=ro.order_id
where ro.pickup_time != "null") t
group by t.runner_id;

-- 12.What was the average speed for each runner for each delivery ?
with runnerorders as (
    select
        runner_id,
        cast(replace(distance, 'km', '') as decimal(5,2)) as distance_km,
        cast(substring_index(duration, ' ', 1) as signed) as duration_min
    from runner_orders
    where distance != 'null' and duration != 'null'
)

select
    runner_id,
    avg(distance_km / (duration_min / 60)) as avg_speed_kmh
from runnerorders
group by runner_id;


-- 13."Can you rank the runners based on their total number of successful deliveries?"
with delivery_cnt as
(select 
	  runner_id,
	  count(*) as cnt
 from runner_orders
 where pickup_time!='null'
 group by runner_id
 order by runner_id)
 
 select *,
 rank() over(order by cnt desc) as runner_rank
 from delivery_cnt;










