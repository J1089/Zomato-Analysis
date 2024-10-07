
# Zomato Analysis Project

## Project Overview

This project aims to analyze key metrics from Zomato's restaurant data, focusing on city and country-level trends, average ratings, and services like table bookings and online delivery. The analysis explores how restaurant openings, costs, and customer preferences evolve over time.

---

## Key Performance Indicators (KPIs)

### 1. **Build a Data Model Using the Sheets in the Excel File**
   - **Description**: Create a structured data model to organize and analyze the dataset efficiently.
   - **Tools Used**: Excel (Data Modeling)

### 2. **Build a Calendar Table**
   - **Description**: Using the `Datekey_Opening` column, generate a calendar table and add the following columns using formulas:
     - Year
     - Monthno
     - Monthfullname
     - Quarter (Q1, Q2, Q3, Q4)
     - YearMonth (YYYY-MMM)
     - Weekdayno
     - Weekdayname
     - FinancialMonth (April = FM1, May = FM2, …, March = FM12)
     - Financial Quarter (FQ-1, FQ-2, etc.)
   - **Tools Used**: Excel

### 3. **Convert Average Cost for 2 People to USD**
   - **Description**: Convert the "Average cost for 2" column (currently in local currency) into USD using the relevant exchange rate.
   - **Tools Used**: Excel

### 4. **Number of Restaurants by City and Country**
   - **Description**: Count the total number of restaurants across various cities and countries.
   - **Tools Used**: Excel, Power BI, Tableau

### 5. **Restaurants Opened by Year, Quarter, and Month**
   - **Description**: Analyze the number of new restaurant openings over time, broken down by year, quarter, and month.
   - **Tools Used**: Excel, Power BI, Tableau

### 6. **Count of Restaurants by Average Ratings**
   - **Description**: Categorize restaurants based on their average customer ratings.
   - **Tools Used**: Excel, Tableau

### 7. **Bucketization of Restaurants by Average Price**
   - **Description**: Group restaurants into buckets based on their average price for two people and count how many fall into each price range.
   - **Tools Used**: Excel, Tableau

### 8. **Percentage of Restaurants with Table Booking**
   - **Description**: Calculate the percentage of restaurants that offer table booking services.
   - **Tools Used**: Excel, Tableau

### 9. **Percentage of Restaurants with Online Delivery**
   - **Description**: Calculate the percentage of restaurants that offer online delivery services.
   - **Tools Used**: Excel, Tableau

### 10. **Develop Charts Based on Cuisines, Cities, and Ratings**
   - **Description**: Create visualizations to analyze trends related to cuisines, cities, and restaurant ratings. Additional KPIs can be considered based on findings.
   - **Tools Used**: Power BI, Tableau

---

## Tools Used

1. **Excel**: For data cleaning, analysis, and building the calendar table.
2. **Power BI**: Used for interactive dashboards and visualizations.
3. **Tableau**: Data visualization for analyzing trends and generating insights.
4. **MySQL**: Data validation and handling large datasets.

---

## Challenges Faced

- **Converting Data from XLSX to CSV**: Issues with transforming the Excel files into CSV format for loading into MySQL.
- **Performance Issues in MySQL**: Loading large CSV files into MySQL took a considerable amount of time.
- **Date Function as Text**: Dates in the dataset were stored as text, requiring conversion to proper date formats.
- **New Columns in Calendar Table**: Additional columns such as Year, Month, Quarter, Weekday No., Weekday Name, Financial Month (FM), and Financial Quarter (FQ) were added to facilitate time-based analysis.
- **DAX Expressions**: Used DAX expressions to calculate average ratings and average price per restaurant.

---

## Conclusion

- **Restaurant Openings**: The number of new restaurants opening over the years in various cities and countries has been adequate, reflecting a growing market.
- **Customer Ratings**: Most restaurants have received average ratings between 3 and 4, indicating moderate customer satisfaction.
- **Restaurant Costs**: A significant portion of restaurants charge less than $50 for two people, making them affordable for most customers.
- **Service Availability**: The majority of restaurants do not offer table booking (around 88%), and almost 75% do not provide online delivery services.
