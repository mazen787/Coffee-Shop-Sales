# Sales Data Analysis Project

## [Click here to view the Interactive Power BI Dashboard](#)

### Dashboard Snapshot:
1. ![Dashboard Overview]!(<img width="714" alt="image" src="https://github.com/user-attachments/assets/001432fe-4c84-4ab5-be97-4c31eb980353">
)


---

## Overview

This project focuses on analyzing sales data to uncover insights into sales volume, order quantity, and product performance. The analysis was conducted using SQL for data extraction and Power BI for visualization, focusing on key performance indicators (KPIs) such as total sales, total orders, and total quantity sold. The goal of this project is to provide a comprehensive view of sales performance, allowing businesses to identify trends, assess store performance, and optimize sales strategies.

## Dataset

The dataset `sales_data.csv` contains the following details:
- **Sales Information**: Daily sales data, including the sales amount, number of orders, and product quantities.
- **Product Details**: Information on the products sold, including product category and location.
- **Time Details**: Date and time of each sale, enabling analysis by day, week, and month.

## Project Workflow

### 1. **Data Cleaning and Preprocessing**
   - Removed any null or irrelevant data.
   - Ensured data consistency and accuracy, especially in terms of date formatting and sales values.
   - Aggregated sales data on a monthly level for KPI calculations.

### 2. **Exploratory Data Analysis (EDA)**
   - Analyzed overall sales trends, total orders, and quantities sold on a monthly basis.
   - Explored variations in sales performance between weekdays and weekends.
   - Investigated sales performance across different store locations and product categories.

### 3. **KPI Tracking**
   Several KPIs were calculated to track sales performance:
   
   - **Total Sales**: The total sales amount for each respective month, with insights into month-on-month increases or decreases.
   - **Total Orders**: The total number of orders for each respective month, with month-over-month comparisons.
   - **Total Quantity Sold**: The total quantity of products sold for each respective month, with changes from the previous month.

### 4. **Sales Insights and Trends**
   - **Month-on-Month Sales Trends**: Identified sales growth or decline patterns based on historical sales data.
   - **Sales by Weekdays vs. Weekends**: Analyzed sales differences between weekdays and weekends to highlight potential areas of focus for promotional efforts.
   - **Sales by Store Location**: Compared sales across different store locations, identifying which locations performed better and which had a decrease in sales.

### 5. **Sales Analysis by Product Category**
   - Analyzed performance across different product categories, identifying top-performing categories that contribute most to overall sales.
   - Highlighted sales performance trends for specific categories, providing insights for inventory and sales planning.

### 6. **Top Products by Sales**
   - Identified the top 10 products based on sales volume, offering key insights into the most popular items among customers.
   - Enabled easy visualization of top-performing products and provided a focus for inventory and sales strategies.

### 7. **Hourly and Daily Sales Analysis**
   - Analyzed sales patterns by hour of the day and day of the week using heat maps to uncover optimal sales periods.
   - Visualized exceptional sales days with bars exceeding the average sales line, indicating key sales events.

## Key Insights

1. **Month-on-Month Sales Trends**: Analyzed how sales increased or decreased over each month, highlighting any seasonal sales fluctuations.

2. **Weekday vs Weekend Performance**: Sales were significantly higher on weekends, prompting the need for weekend-specific promotions to boost weekday sales.

3. **Sales by Location**: Store locations with higher sales volumes consistently outperformed others, while some locations showed month-over-month declines in sales, signaling potential issues.

4. **Top Products**: The top 10 products generated the majority of sales, emphasizing the importance of focusing on these bestsellers.

5. **Product Category Contribution**: Certain product categories drove more sales than others, indicating areas where marketing and stocking efforts should be concentrated.

## Power BI Dashboards

The following dashboards were created to visually represent the findings:

- **Calendar Heat Map**: A dynamic calendar heat map that adjusts based on the selected month and displays sales volume for each day. Tooltips show detailed sales, order, and quantity metrics for each day.
- **Sales by Weekdays and Weekends**: A comparison of sales performance between weekdays and weekends to identify variations in sales patterns.
- **Sales by Store Location**: A visualization of sales data by store location with month-over-month comparisons to highlight trends.
- **Daily Sales with Average Line**: A daily sales line chart for the selected month, showing average sales with bars that indicate sales days above or below average.
- **Sales by Product Category**: A breakdown of sales performance by product category to identify key contributing categories.
- **Top 10 Products by Sales**: A list of the top 10 products based on sales, highlighting the best-performing products.
- **Sales by Days and Hours**: A heat map that visualizes sales patterns across days of the week and hours of the day, with tooltips for detailed metrics.

## Tools Used

- **SQL**: For querying and extracting sales data.
- **Power BI**: For creating dynamic and interactive dashboards that visualize key insights.

## Conclusion

This project provided valuable insights into sales performance across various dimensions. By analyzing total sales, orders, and quantities sold, along with sales trends by location, product category, and time, businesses can better understand their sales dynamics. The findings from this analysis can be used to refine sales strategies, improve inventory management, and target high-performance products and locations more effectively.
