# Secure Data Lake Ingestion using Snowflake and AWS IAM

This project demonstrates how to securely ingest structured data from Amazon S3 into Snowflake using External Stage Objects and Snowflake-created AWS IAM roles. It showcases secure cross-platform integration between cloud services and data platforms in a scalable, production-grade architecture.

## 🚀 Project Overview

- **Objective:** Set up a secure data ingestion pipeline that allows Snowflake to read data files stored in AWS S3 using an External Stage.
- **Scope:** Includes Snowflake integration, IAM role creation, S3 bucket configuration, and access policy setup for secure and scalable data lake ingestion.

---

## 🧰 Tech Stack

- **Snowflake** – Data warehouse platform for cloud analytics  
- **Amazon S3** – Cloud object storage for staging raw data  
- **AWS IAM** – Role-based access control for secure authentication  
- **SQL** – Snowflake DDL for stage creation and testing

---

## 📁 Project Structure

```bash
.
├── create_stage.sql          # SQL script to create external stage in Snowflake
├── aws_iam_policy.json       # IAM policy for S3 access
├── snowflake_integration.sql # Snowflake integration setup
├── sample_data/              # Example files stored in S3
└── README.md

🔧 Setup Instructions

1. 📦 Upload Data to S3
	•	Create an S3 bucket (e.g., my-snowflake-data)
	•	Upload sample data files (CSV/JSON/etc.) to a folder within the bucket

2. 🔐 Create IAM Role for Snowflake
	•	In AWS IAM, create a new role with:
	•	Trust policy for Snowflake account
	•	Permissions policy (read-only) for the S3 bucket

3. 🔗 Set Up Snowflake Integration
  CREATE STORAGE INTEGRATION my_s3_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<YOUR_IAM_ROLE_ARN>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://my-snowflake-data/');

	•	Use DESC INTEGRATION to get the external ID
	•	Add external ID to IAM role trust relationship
4. 🌐 Create External Stage

✅ Test the Integration
Run the following to list files from the external stage:
LIST @my_ext_stage;

🔒 Security Highlights
	•	Uses Snowflake-created IAM roles with least privilege principle
	•	No static credentials — all access is token-based and scoped
	•	Ensures secure, auditable data access between Snowflake and AWS
📈 Use Cases
	•	Secure data ingestion from AWS to Snowflake
	•	Building a scalable data lakehouse architecture
	•	Enterprise-grade cloud integration for analytics workloads
