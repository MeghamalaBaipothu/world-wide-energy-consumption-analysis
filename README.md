# 🌍 World Wide Energy Consumption Analysis

## 📌 Project Overview

This project analyzes global energy consumption, production, emissions, GDP, and population data using **MySQL**.

The objective is to explore relationships between energy usage, economic development, population, and environmental impact across countries and identify meaningful trends and insights through SQL-based data analysis.

---

## 🎯 Objectives

- Analyze global energy consumption and production patterns.
- Compare energy consumption and production across countries.
- Study the relationship between energy usage and GDP.
- Analyze carbon emissions and their relationship with energy consumption.
- Examine population and energy consumption patterns.
- Identify countries with high and low energy consumption.
- Perform advanced SQL analysis using joins, subqueries, aggregate functions, CTEs, window functions, and ranking techniques.

---

## 🗃️ Datasets

The project contains six datasets:

| Dataset | Description |
|---|---|
| `country_3.csv` | Country information and country identifiers |
| `consum_3.csv` | Energy consumption data |
| `production_3.csv` | Energy production data |
| `emission_3.csv` | Energy-related emissions data |
| `gdp_3.csv` | GDP data for countries |
| `population_3.csv` | Population data for countries |

All datasets are connected through country-level information for integrated analysis.

---

## 🏗️ Database Structure

The `country` table acts as the central reference table and connects the analytical datasets using country identifiers.

```text
                    ┌─────────────────┐
                    │     COUNTRY     │
                    └────────┬────────┘
                             │
        ┌────────────┬───────┼────────┬─────────────┐
        │            │       │        │             │
        ▼            ▼       ▼        ▼             ▼
   CONSUMPTION  PRODUCTION EMISSION   GDP       POPULATION
````

This structure enables combined analysis across energy, economic, environmental, and demographic indicators.

---

## 🛠️ Technologies Used

* **MySQL**
* **MySQL Workbench**
* **SQL**
* Relational Database Concepts
* Data Analysis

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* Aggregate Functions
* `JOIN`
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Ranking
* Conditional Logic
* Data Filtering
* Comparative Analysis

---

## 🔍 Analysis Performed

The SQL analysis investigates questions such as:

* Which countries have the highest energy consumption?
* Which countries have the highest energy production?
* Which countries have the highest emissions?
* How does energy consumption vary with GDP?
* How does population relate to energy consumption?
* Which countries have high consumption but relatively low production?
* Which countries contribute significantly to global emissions?
* How do countries rank based on energy-related indicators?
* What patterns can be observed between economic development and energy usage?

---

## 💡 Key Areas of Insight

The analysis focuses on identifying:

* 🌎 Global energy consumption patterns
* ⚡ Energy production differences
* 💰 GDP and energy relationships
* 🌱 Emission trends
* 👥 Population and energy demand
* 📈 Country-level rankings and comparisons
* 🔗 Relationships between economic, demographic, and energy indicators

---

## 📁 Repository Structure

```text
world-wide-energy-consumption-analysis/
│
├── dataset/
│   ├── country_3.csv
│   ├── consum_3.csv
│   ├── production_3.csv
│   ├── emission_3.csv
│   ├── gdp_3.csv
│   └── population_3.csv
│
├── sql/
│   └── sis_SQLProject_Meghamala_523.sql
│
├── presentation/
│   └── Energy Consumption Analysis_SQLProject_PPT.pptx
│
└── README.md
```

---

## ▶️ How to Use

### 1. Download or clone the repository

Open the repository and download the project files.

### 2. Open MySQL Workbench

Create a MySQL database for the project.

### 3. Import the datasets

Load the six CSV datasets into their respective tables.

### 4. Run the SQL script

Open:

```text
sql/sis_SQLProject_Meghamala_523.sql
```

Execute the queries in MySQL Workbench to reproduce the analysis.

---

## 📊 Project Deliverables

- ✅ Six datasets
- ✅ MySQL database structure
- ✅ ER diagram
- ✅ SQL analysis queries
- ✅ MySQL SQL script
- ✅ Project presentation
- ✅ Project documentation

---

## 📚 Learning Outcomes

Through this project, I strengthened my practical knowledge of:

* SQL-based data analysis
* Relational database design
* Multi-table joins
* Advanced querying
* Data aggregation
* Analytical SQL
* Window functions
* Business-oriented data interpretation

---

## 👩‍💻 Author

**Meghamala Baipothu**

B.Tech – Computer Science Engineering

Interested in **Data Analytics, Data Science, SQL, Python, Power BI, Machine Learning and AI**.

---

⭐ If you find this project useful, feel free to explore the SQL queries and datasets.
