# Secure Data Lake Ingestion using Snowflake and AWS IAM

This project demonstrates how to securely ingest structured data from Amazon S3 into Snowflake using External Stage Objects and Snowflake-created AWS IAM roles. It showcases secure cross-platform integration between cloud services and data platforms in a scalable, production-grade architecture.

# 🚀 Project Overview

- **Objective:** Set up a secure data ingestion pipeline that allows Snowflake to read data files stored in AWS S3 using an External Stage.
- **Scope:** Includes Snowflake integration, IAM role creation, S3 bucket configuration, and access policy setup for secure and scalable data lake ingestion.
  <img width="1372" alt="Screenshot 2025-05-21 at 18 27 23" src="https://github.com/user-attachments/assets/95e63e0b-0292-49ab-8705-d60d66eefc8a" />


🛠️ Tech Stack
	•	Snowflake — Cloud-based data warehouse platform for analytics
	•	Amazon S3 — Cloud object storage for staging raw and ingested data
	•	AWS IAM — Role-based access control for secure authentication between Snowflake and S3
	•	SQL — Used for Snowflake DDL operations, integration setup, and data querying
	•	External Stages — Snowflake objects that link directly to S3 storage securely


📁 Project Structure

├── create_stage.sql          # SQL script to create external stage in Snowflake
├── aws_iam_policy.json       # IAM policy for S3 access
├── snowflake_integration.sql # Snowflake integration setup
├── sample_data/              # Example files stored in S3
└── README.md

🔧 Setup Instructions

1. 📦 Upload Data to S3
	•	Create an S3 bucket (e.g., my-snowflake-data)
	•	Upload sample data files (CSV/JSON/etc.) to a folder within the bucket

   <img width="1440" alt="Screenshot 2025-05-24 at 10 07 37" src="https://github.com/user-attachments/assets/07da4618-a605-4cfe-9e8c-b02c6025aeaf" />

2. 🔐 Create IAM Role for Snowflake

	•	In AWS IAM, create a new role with:
	•	Trust policy for Snowflake account
	•	Permissions policy (read-only) for the S3 bucket
     <img width="1440" alt="Screenshot 2025-05-24 at 10 07 47" src="https://github.com/user-attachments/assets/6e378d55-ea54-4675-a200-c68c10eb3a91" />
     
3. 🔗 Set Up Snowflake Integration

  <img width="1440" alt="Screenshot 2025-05-24 at 10 08 25" src="https://github.com/user-attachments/assets/3f0ee4a1-0231-4438-83d1-8a1aa73c53c6" />

  • Use DESC INTEGRATION to get the external ID
  • Add external ID to IAM role trust relationship
4. 🌐 Create External Stage
    CREATE OR REPLACE STORAGE INTEGRATION my_s3_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::767397922128:role/demo-2025-aws-snowflake'
    STORAGE_ALLOWED_LOCATIONS = ('s3://demo-2025-aws-snowflake/');

✅ Test the Integration
    Run the following to list files from the external stage:
    <img width="1440" alt="Screenshot 2025-05-24 at 10 08 37" src="https://github.com/user-attachments/assets/ea7bb7d5-282b-46f2-ad6d-5578a56a88a4" />

     LIST @my_ext_stage;

🔒 Security Highlights
	•	Uses Snowflake-created IAM roles with least privilege principle
	•	No static credentials — all access is token-based and scoped
	•	Ensures secure, auditable data access between Snowflake and AWS
📈 Use Cases
	•	Secure data ingestion from AWS to Snowflake
	•	Building a scalable data lakehouse architecture
	•	Enterprise-grade cloud integration for analytics workloads
