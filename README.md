# 🏦 Bank360: AI-Powered Customer Retention System

![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Domain](https://img.shields.io/badge/Domain-BFSI-blue)
![Tech Stack](https://img.shields.io/badge/Tech-SQL%20%7C%20Python%20%7C%20PowerBI%20%7C%20GenAI-orange)

## 📌 Executive Summary
**Bank360** is an end-to-end retention intelligence system designed for the Banking, Financial Services, and Insurance (BFSI) sector. It moves beyond historical churn analysis to **predictive action**.

By integrating **Advanced SQL**, **Machine Learning (Random Forest)**, and **Generative AI (Gemini API)**, this system not only predicts which customers will leave but also automates the creation of personalized retention strategies, identifying **$466.8M in revenue at risk**.

<img width="1206" height="677" alt="image" src="https://github.com/user-attachments/assets/9f1edb58-c12a-4db4-a842-f257080e1af5" />
<img width="1194" height="670" alt="image" src="https://github.com/user-attachments/assets/3765b37b-254c-4ae0-ac9a-4efa0dee3970" />
<img width="1200" height="678" alt="image" src="https://github.com/user-attachments/assets/1b9d586c-b252-46d5-a116-15be6c3cfabd" />



---

## 💼 Business Problem
The bank was suffering from **"Silent Attrition"**—high-value customers were leaving without warning.
* **The Impact:** A historical churn rate of **21.16%** resulting in **$2.49 Billion** in lost deposits.
* **The Goal:** Build a proactive system to identify at-risk customers *before* they leave and equip Relationship Managers with an immediate "Call List" and personalized script.

---

## 🛠️ Tech Stack & Architecture

| Component | Tools Used | Key Skills Demonstrated |
| :--- | :--- | :--- |
| **Data Database** | **PostgreSQL / MySQL** | Schema Design, Window Functions (`ROW_NUMBER`), CTEs, Data Cleaning |
| **Analysis & ML** | **Python (Pandas, Scikit-Learn)** | Feature Engineering, Random Forest Classifier, Model Evaluation (ROC-AUC) |
| **GenAI Integration** | **Google Gemini API** | Prompt Engineering, Automated Content Generation |
| **Visualization** | **Power BI** | DAX Measures, Dynamic Parameters, Custom Tooltips |

---

## 🚀 Key Features

### 1. Advanced SQL Analysis
Instead of basic queries, I used advanced techniques to uncover hidden trends:
* **Segmentation Logic:** Used CTEs to categorize customers by balance (Zero vs. High Value).
* **Competitive Ranking:** Used `ROW_NUMBER()` to identify top loyal customers per region.
* **Churn Contribution:** Calculated that **Germany** accounts for 37.5% of total churn using Window Functions.

### 2. Machine Learning Model
Built a **Random Forest Classifier** to predict customer churn probability.
* **Performance:** Achieved **88% ROC-AUC Score** on validation data.
* **Key Drivers:** Identified **Age**, **Number of Products**, and **Balance** as the top predictors of churn.

### 3. 🤖 GenAI "Action Layer" (Unique Differentiator)
A standard dashboard just shows numbers. **Bank360 acts on them.**
* I integrated the **Google Gemini API** to analyze high-risk customer profiles.
* **Automated Output:** The system auto-generates a personalized email for the bank manager to send.
    * *Example:* For a high-balance customer, it drafts a "Wealth Advisory" offer.
    * *Example:* For a multi-product user, it drafts a "Portfolio Consolidation" offer.

### 4. Interactive Power BI Dashboard
* **Scenario Planning:** Includes a dynamic parameter to adjust "Risk Thresholds" in real-time.
* **"Kill List":** A prioritized table of high-risk customers.
* **Smart Tooltips:** Hovering over a customer shows the **AI-Generated Email** directly in the dashboard.

---

## 📊 Critical Insights Discovered

1.  **The "Product Trap":**
    * Customers with 1 or 2 products are stable.
    * Customers with **3 or 4 products** have a catastrophic **82-87% churn rate**.
    * *Recommendation:* Halt aggressive cross-selling of complex bundles.

2.  **High-Value Flight:**
    * Churn is not limited to low-value accounts. Significant attrition was found among customers with balances **>$100k**.
    * *Recommendation:* Launch a "Premium Wealth Advisory" retention campaign.

3.  **The "German Problem":**
    * **Germany** has a churn rate (37.9%) nearly double that of France or Spain.
    * *Recommendation:* Immediate regional intervention required.


---


## 💻 How to Run This Project

1.  **SQL Analysis:**
    * Load `train.csv` into your SQL database.
    * Run scripts in `Bank360_SQL_queries.sql` to reproduce the insights.

2.  **Machine Learning:**
    * Install dependencies: `pip install pandas scikit-learn google-generativeai`.
    * Run `bank_churn_model.ipynb` to train the model and generate the `submission.csv`.
    * *Note:* You will need your own Google Gemini API key for the GenAI cell to work.

3.  **Dashboard:**
    * Open `bank360_dashboard.pbix` in Power BI Desktop.
    * Connect it to the `Bank360_Dashboard_Data.csv` file.

---

## 📬 Contact
**Vinayak jain**
* **Role:** Data Analyst
* **Email:** vinayakjainn11@gmail.com
* **LinkedIn:** www.linkedin.com/in/vinayak-jain-69801b328
