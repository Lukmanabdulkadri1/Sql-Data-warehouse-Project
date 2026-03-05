# Data waherehouse and Analytics Project**

📌 Overview

This project demonstrates a complete data warehousing and analytics solution, built to showcase modern data engineering practices. It simulates a real-world scenario: ingesting data from multiple source systems (ERP and CRM), transforming it into a structured data warehouse, and delivering actionable insights via a BI dashboard.

### Objective
The goal is to Develop a modern warehouse using SQL Server,illustrate proficiency in data modeling, ETL/ELT pipelines, cloud data platforms, and business intelligence.

🏗️ Architecture

The data architecture of this project follows the Medallion Architecture **Bronze**,**Silver** and **Gold**
<img width="771" height="570" alt="Data Warehouse Piipeline drawio" src="https://github.com/user-attachments/assets/49fe972f-d211-4a85-b576-261c3cff7d04" />
)
Bronze: Raw ingested data from sources, untransformed and preserved for auditing.
Silver: Cleaned, validated, and standardized data integrated for analytics.
Gold: Business-ready, optimized datasets for reporting, BI, and ML.

🛠️ Tech Stack
MSQL
Python
Version Control Git & GitHub
BI / Visualization Power BI

📊 Dataset

The project uses a publicly available dataset (e.g., TPC-H, AdventureWorks, or a custom-generated e-commerce dataset) modified to include realistic dimensions and facts. The data includes:

· Customers (demographics, segments)
· Products (categories, pricing)
· Sales Orders (transactions, quantities, dates)

📁 Repository Structure
data-warehouse-project/
│
├─ README.md                 # Project overview, pipeline description, and tech stack
├─ /docs                     # Documentation, diagrams, data dictionary
│
├─ /bronze                   # Raw data ingestion layer
│   ├─ /scripts              # Ingestion scripts (Python, SQL, etc.)
│   └─ /samples              # Sample raw data files
│
├─ /silver                   # Cleaned and standardized data
│   ├─ /transformations      # dbt models, Spark/Pandas scripts
│   └─ /tests                # Data quality and validation checks
│
├─ /gold                     # Analytics-ready datasets
│   ├─ /models                # Fact/dimension table definitions
│   └─ /views                 # SQL views for BI & reporting
│
├─ /config                   # Config files, connection strings, secrets (use env variables!)
├─ requirements.txt / pyproject.toml  # Python dependencies
└─ .gitignore                # Ignore raw data, credentials, temporary files


🚀 How to Run the Project Locally

1. Clone the repository
      git clone https://github.com/Lukmanabdulkadri1/sql-Data-warehouse-project.git
2. Set up the data warehouse
   · Create a Snowflake (or your chosen DB) account and configure credentials.
   · Run the initial setup scripts in sql/ to create databases and schemas.

🔍 Key Features

· Modular dbt models with clear staging, intermediate, and mart layers.
· Data quality tests (not-null, uniqueness, referential integrity) via dbt.


📈 What I Learned

· Designing a star schema for analytical queries.
· Writing efficient SQL for transformations.
· Building a production-like environment for data engineering projects.

📜 License
This Project is licensed under MIT License- see the License [MIT License](LICENSE). file  for Detail

📧 Contact
Email: LukmanAbdulkadri1@gmail.com/
Feel free to connect with me on LinkedIn or check out my other projects on GitHub.
