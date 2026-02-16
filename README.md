# Data waherehouse and Analytics Project**

📌 Overview

This project demonstrates a complete data warehousing and analytics solution, built to showcase modern data engineering practices. It simulates a real-world scenario: ingesting data from multiple source systems (ERP and CRM), transforming it into a structured data warehouse, and delivering actionable insights via a BI dashboard.

### Objective
The goal is to Develop a modern warehouse using SQL Server,illustrate proficiency in data modeling, ETL/ELT pipelines, cloud data platforms, and business intelligence.

🏗️ Architecture

· Source Systems: Simulated transactional data (e.g., sales, customers, products) loaded into a staging area.
· Ingestion: Python scripts and Apache Airflow DAGs to extract and load raw data.
· Warehouse: Snowflake (or BigQuery/Redshift) – raw, staging, and mart layers using a star schema.
· Transformation: dbt (Data Build Tool) for modular, tested SQL transformations.
· BI: Interactive dashboards built with Power BI (or Tableau/Looker).

🛠️ Tech Stack

Component Technology
Database Snowflake
Orchestration Apache Airflow
Transformation dbt
Version Control Git & GitHub
BI / Visualization Power BI
Language SQL, Python
Infrastructure Docker (optional)

📊 Dataset

The project uses a publicly available dataset (e.g., TPC-H, AdventureWorks, or a custom-generated e-commerce dataset) modified to include realistic dimensions and facts. The data includes:

· Customers (demographics, segments)
· Products (categories, pricing)
· Sales Orders (transactions, quantities, dates)
· Inventory (stock levels, movements)

📁 Repository Structure

```
.
├── airflow/ # Airflow DAGs for orchestration
├── dbt/ # dbt models, macros, tests, and docs
│ ├── models/
│ │ ├── staging/ # Clean and standardize raw data
│ │ ├── marts/ # Fact and dimension tables
│ │ └── intermediate/ # Business-level transformations
│ ├── tests/ # Custom data quality tests
│ └── dbt_project.yml
├── sql/ # Raw DDL/DML scripts (optional)
├── notebooks/ # Jupyter notebooks for exploration
├── dashboard/ # Power BI/Tableau files
├── docker-compose.yml # For local Airflow setup
├── requirements.txt # Python dependencies
└── README.md
```

🚀 How to Run the Project Locally

1. Clone the repository
      git clone https://github.com/yourusername/data-warehouse-portfolio.git
2. Set up the data warehouse
   · Create a Snowflake (or your chosen DB) account and configure credentials.
   · Run the initial setup scripts in sql/ to create databases and schemas.
3. Install dependencies
      pip install -r requirements.txt
4. Configure dbt
   · Update dbt/profiles.yml with your database connection details.
   · Run dbt debug to verify connection.
5. Run dbt transformations
      cd dbt && dbt run
6. Orchestrate with Airflow (optional)
   · Use Docker Compose: docker-compose up -d
   · Access Airflow UI at http://localhost:8080 and trigger the DAG.
7. Explore the BI dashboard
   · Open the Power BI/Tableau file in dashboard/ and connect to your warehouse.

🔍 Key Features

· Modular dbt models with clear staging, intermediate, and mart layers.
· Data quality tests (not-null, uniqueness, referential integrity) via dbt.
· Incremental loading for large fact tables.
· Airflow DAG to automate the entire pipeline.
· Interactive dashboards showing KPIs: revenue trends, customer segmentation, inventory turnover.

📈 What I Learned

· Designing a star schema for analytical queries.
· Implementing ELT pipelines with dbt and Airflow.
· Writing efficient SQL for transformations.
· Building a production-like environment for data engineering projects.

📜 License
This Project is licensed under MIT License- see the License [MIT License](LICENSE). file  for Detail

📧 Contact
Email: LukmanAbdulkadri1@gmail.com/
Feel free to connect with me on LinkedIn or check out my other projects on GitHub.

---

This project is for educational purposes and part of my data engineering portfolio.
