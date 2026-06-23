# 💳 Credit Card Fraud Detection — End-to-End Data Analysis Project

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi)
![Status](https://img.shields.io/badge/Status-Completed-green)

---

## 📌 Project Overview

This project is a full end-to-end data analysis of credit card fraud transactions.
The goal was to explore, analyze, and model fraudulent transaction patterns using
real-world simulated banking data — covering data cleaning, SQL analysis,
machine learning, and an interactive Power BI dashboard.

**Business Question:**

> _Can we identify patterns in fraudulent credit card transactions to help banks
> detect and prevent fraud more effectively?_

---

## 📊 Key Findings

| Metric                    |         |
| ------------------------- | ---------------- |
| Total Transactions        |  1852394   |
| Total Fraud Cases         |  9651   |
| Fraud Rate                | 0.52% |
| Total Fraud Amount Lost   |   |
| Average Fraud Transaction | $530.66 |
| Peak Fraud Hour           | 22 |
| Highest Risk Category     |  grocery_pos |
| Most Targeted Age Group   | |
| Top Fraud State           | NY   |
| Model ROC-AUC Score       |    |

---

## 🗂️ Project Structure

```
credit-card-fraud-detection/
│
├── data/
│   ├── fraudtrain.csv              ← Original training data
│   ├── fraudtest.csv               ← Original test data
│   └── fraud_cleaned.csv           ← Cleaned & engineered dataset
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb      ← Data cleaning & feature engineering
│   └── 02_eda_and_model.ipynb      ← EDA, visualizations & ML model
│
├── sql/
│   └── queries.sql                 ← All 12 business analysis queries
│
├── powerbi/
│   ├── fraud_dashboard.pbix        ← Interactive Power BI dashboard
│   └── data/                       ← Aggregated CSVs for dashboard
│
├── models/
│   └── fraud_rf_model.pkl          ← Trained Random Forest model
│
└── README.md
```

---

## 🛠️ Tools & Technologies

| Tool                         | Purpose                                 |
| ---------------------------- | --------------------------------------- |
| **Python**                   | Data cleaning, EDA, machine learning    |
| **Pandas & NumPy**           | Data manipulation                       |
| **Matplotlib & Seaborn**     | Data visualization                      |
| **Scikit-learn**             | Random Forest model, evaluation metrics |
| **Imbalanced-learn (SMOTE)** | Handling class imbalance                |
| **PostgreSQL**               | Business queries & data analysis        |
| **Power BI**                 | Interactive dashboard                   |
| **VS Code + Jupyter**        | Development environment                 |

---

## 📁 Dataset

**Source:** [Kaggle — Credit Card Transactions Fraud Detection Dataset](https://www.kaggle.com/datasets/kartik2112/fraud-detection)

**Author:** Kartik Shenoy

| Feature                 | Description                                 |
| ----------------------- | ------------------------------------------- |
| `trans_date_trans_time` | Transaction timestamp                       |
| `merchant`              | Merchant name                               |
| `category`              | Merchant category                           |
| `amt`                   | Transaction amount                          |
| `gender`                | Cardholder gender                           |
| `state`                 | Cardholder state                            |
| `city_pop`              | City population                             |
| `job`                   | Cardholder occupation                       |
| `dob`                   | Date of birth                               |
| `is_fraud`              | Target variable (1 = Fraud, 0 = Legitimate) |

**Engineered Features:**

- `trans_hour` — Hour of transaction
- `trans_day` — Day of week
- `trans_month` — Month of transaction
- `age` — Cardholder age at transaction time
- `age_group` — Binned age categories

---

## 🧹 Phase 1 — Data Cleaning (Python)

**Notebook:** `notebooks/01_data_cleaning.ipynb`

Steps performed:

- Combined fraudtrain.csv and fraudtest.csv into one dataset
- Checked and confirmed zero missing values
- Removed duplicate rows
- Fixed data types (datetime, date, numeric)
- Engineered new features: trans_hour, trans_day, trans_month, age, age_group
- Dropped irrelevant columns: first, last, street, trans_num, unix_time, cc_num
- Saved cleaned file as fraud_cleaned.csv

**Key Challenge — Class Imbalance:**
The dataset is heavily imbalanced — legitimate transactions make up over 99%
of all records. This is a critical real-world challenge in fraud detection.
SMOTE (Synthetic Minority Over-sampling Technique) was applied during
modeling to address this.

---

## 🔍 Phase 2 — SQL Business Analysis (PostgreSQL)

**File:** `sql/queries.sql`

12 business queries were written to answer key fraud questions:

| #   | Query                 | Key Insight    |
| --- | --------------------- | -------------- |
| 1   | Overview KPIs         |  |
| 2   | Fraud by Category     | |
| 3   | Fraud by Hour         | 
| 4   | Fraud by Day          | 
| 5   | Fraud by Month        | |
| 6   | Fraud by State        |  |
| 7   | Fraud by Gender       | |
| 8   | Fraud by Age Group    | 
| 9   | Amount Distribution   | 
| 10  | Top 15 Merchants       |
| 11  | Category + Hour Combo |
| 12  | Fraud by City Size    |  |

---

## 📈 Phase 3 — EDA & Machine Learning (Python)

**Notebook:** `notebooks/02_eda_and_model.ipynb`

### Exploratory Data Analysis

8 visualizations were created covering:

- Class imbalance distribution
- Fraud by merchant category
- Fraud by hour of day (dual axis — count + rate)
- Transaction amount distribution (fraud vs legitimate)
- Fraud by age group and gender
- Top states by fraud cases

### Machine Learning Model

**Algorithm:** Random Forest Classifier

**Steps:**

1. Feature selection — 9 features used
2. Label encoding for categorical columns
3. Train/test split — 80/20 with stratification
4. SMOTE applied to training data to balance classes
5. Model trained with 100 estimators, max depth 10
6. Evaluated on unseen test data

**Model Results:**

| Metric            | Score        |
| ----------------- | ------------ |
| ROC-AUC           | [your score] |
| Precision (Fraud) | [your score] |
| Recall (Fraud)    | [your score] |
| F1-Score (Fraud)  | [your score] |

**Most Important Features:**

1. `amt` — Transaction amount
2. `trans_hour` — Hour of transaction
3. `age` — Cardholder age
4. `category` — Merchant category
5. `city_pop` — City population

---

## 📊 Phase 4 — Power BI Dashboard

**File:** `powerbi/fraud_dashboard.pbix`

### Page 1 — Fraud Overview

- 5 KPI Cards: Total Transactions, Fraud Cases, Fraud Rate, Total Fraud Amount, Avg Fraud Amount
- Horizontal Bar Chart: Fraud cases by merchant category
- Line Chart: Fraud cases and rate by hour of day
- Filled Map: Fraud distribution across US states
- Column Chart: Fraud cases by day of week

### Page 2 — Fraud Deep Dive

- Donut Chart: Fraud vs Legitimate split
- Bar Chart: Fraud cases by age group
- Column Chart: Fraud cases by gender
- Table: Top 15 merchants with conditional formatting
- Bar Chart: Total fraud amount by category
- Line Chart: Fraud trend by month
- Interactive slicers: Category, Gender, Year

**Theme:** Custom dark navy theme with crimson red and teal accents

---

## 💡 Business Recommendations

Based on the analysis, the following recommendations can be made to the bank:

1. **Increase monitoring during [peak hour] hours** — fraud spikes significantly
   during this window, especially for [top category] transactions

2. **Flag high-value [top category] transactions** — this category has both
   the highest fraud count and highest fraud rate

3. **Enhanced verification for customers aged [age group]** — this group
   is disproportionately targeted by fraudsters

4. **Geographic fraud task force for [top state]** — this state consistently
   shows the highest fraud concentration

5. **Real-time amount threshold alerts** — fraud transactions average
   $[your avg fraud amount] vs $[your avg legit amount] for legitimate,
   suggesting amount-based triggers could catch many cases early

---

## 🚀 How to Run This Project

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/credit-card-fraud-detection.git
cd credit-card-fraud-detection
```

### 2. Install Python Dependencies

```bash
pip install pandas numpy matplotlib seaborn scikit-learn imbalanced-learn joblib
```

### 3. Download the Dataset

Download from [Kaggle](https://www.kaggle.com/datasets/kartik2112/fraud-detection)
and place `fraudtrain.csv` and `fraudtest.csv` in the `data/` folder.

### 4. Run the Notebooks

```bash
# Open VS Code
code .
# Run notebooks in order:
# 1. notebooks/01_data_cleaning.ipynb
# 2. notebooks/02_eda_and_model.ipynb
```

### 5. Run SQL Queries

Load `fraud_cleaned.csv` into PostgreSQL and run queries from `sql/queries.sql`

### 6. Open Dashboard

Open `powerbi/fraud_dashboard.pbix` in Power BI Desktop

---

## 📬 Connect With Me

**[Your Name]**

- 💼 LinkedIn: [your linkedin url]
- 🐙 GitHub: [your github url]
- 📧 Email: [your email]

---

_This project was built as part of my data analyst portfolio to demonstrate
end-to-end analytical skills across Python, SQL, and Power BI._
