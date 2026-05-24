# Pizza Runner - SQL Analysis and Power BI Dashboard

## Project Overview

Pizza Runner is a pizza delivery service dataset. This project focuses on analyzing the data using MySQL and visualizing the results through a Power BI dashboard. The goal is to understand customer ordering patterns, runner performance, and delivery trends.

## Database Schema

The database pizza_runner contains 6 tables - runners, customer_orders, runner_orders, pizza_names, pizza_recipes, and pizza_toppings.

- runners stores the registration date of each runner.
- customer_orders captures each pizza ordered with details like exclusions and extras.
- runner_orders contains delivery information such as distance, duration, and cancellation status.
- pizza_names, pizza_recipes, and pizza_toppings store pizza and topping related information.

## Data Cleaning

The raw dataset had several inconsistencies that needed to be handled before analysis. String values like 'null' were present in numeric and date columns instead of actual NULL values. Some columns had extra text attached to numbers such as 'km' in distance and 'minutes' in duration. Empty strings were also mixed in alongside NULL values in columns like exclusions, extras, and cancellation. All of these were cleaned before running any queries.

## SQL Topics Covered

- Aggregate functions - COUNT, SUM, AVG, ROUND
- Joins - INNER JOIN across multiple tables
- Filtering - WHERE clause with NULL handling and multiple conditions
- Grouping - GROUP BY with ORDER BY
- Date and time functions - HOUR, DAYNAME, TIMESTAMPDIFF
- String functions - REPLACE, SUBSTRING_INDEX, CAST
- Conditional logic - CASE WHEN statements
- Common Table Expressions - WITH clause
- Window functions - RANK OVER

## Power BI Dashboard

The dashboard was built by connecting Power BI directly to the MySQL database. Data cleaning was done in Power Query before building the visuals. The dashboard includes KPI cards for key metrics, charts for order trends by hour and day, pizza type breakdown, runner performance table, and a cancellation breakdown chart. Slicers were added to filter by pizza type and runner.

## Tools Used

- MySQL - database creation, data cleaning, and analysis queries
- Power BI Desktop - dashboard and data visualization
- Power Query - data transformation and cleaning

## How to Run

1. Open MySQL Workbench and run the scripts file to create the database and tables.
2. Run the queries file to execute the analysis.
3. Open the Power BI file and connect to your local MySQL database if prompted.
