# 🧠 League of Legends Champion Stats Analysis

This project analyzes champion performance across roles using unfiltered telemetry data from League of Legends. The goal is to extract actionable insights from raw gameplay stats by cleaning, modeling, and visualizing champion-level metrics such as win rate, pick rate, and ban rate.

## 📁 Dataset

- Source: [Kaggle - League of Legends Champion Stats](https://www.kaggle.com/datasets/vivovinco/league-of-legends-champion-stats)
- Format: CSV files (23 total)
- Focus: Most recent patch only for clarity and relevance
- Includes: Champion-level performance metrics per role (Top, Jungle, Mid, ADC, Support)

---

## 🧹 Data Cleaning & Transformation

- Selected the most recent patch file and loaded it into **MySQL** for querying
- Cleaned in **Excel** to remove null values and standardize column types
- Used SQL to:
  - Filter champions by role
  - Calculate win, pick, and ban rates
  - Rank champions by performance
  - Compute correlation coefficients between key KPIs

---

## 🔍 Key SQL Insights

- **Top Champions by Win Rate per Role** using `ROW_NUMBER()` window function
- **Correlation Analysis** between:
  - Win Rate vs Pick Rate
  - Win Rate vs Ban Rate
  - Pick Rate vs Ban Rate (moderate correlation found: ~0.5)
- **Role Distribution Heatmap Data Prep** for Power BI

---

## 📊 Visualizations

### 1. Champion Performance Heatmap (Power BI)
The Champion Performance Heatmap presents win rates across five roles (ADC, Jungle, Mid, Support, Top) for all 253 League of Legends champions. Conditional formatting highlights strong role-specific performers, allowing quick identification of top-tier picks. This visual helps uncover role versatility and performance consistency at a glance, making it an effective tool for champion analysis.
A matrix showing win rates per champion by role with conditional formatting. Makes it easy to:
- Identify champions that excel in multiple roles
- Compare role strength across the entire champion pool

---

### 2. Win Rate vs Pick Rate Scatter Plot (Power BI)
This scatter plot visualizes the correlation between pick rate and win rate across 253 League of Legends champions in Patch X.Y. Champions are grouped into three categories: balanced, high-performing niche picks, and low-performing meta picks. The chart reveals minimal correlation between pick rate and win rate (R² ≈ 0), highlighting how popularity doesn’t necessarily equate to performance.
- Built from SQL export
- Visualized performance trends and outliers
- Pick Rate on X-axis, Win Rate on Y-axis
- Helps identify underused but high-performing champions

---

## 💡 Key Takeaways

- No strong linear correlation between win rate and pick/ban rates — meta influences likely
- Pick rate moderately correlates with ban rate (~0.5)
- Certain champions perform well across multiple roles, suggesting flexibility in draft
- Heatmaps and scatter plots are highly effective for visual storytelling in game telemetry

---

## 🛠 Tools Used

- **Excel** – data cleaning, pivot tables, scatter plots
- **MySQL** – querying and transformation of champion data
- **Power BI** – advanced visualizations (matrix heatmap, filters, formatting)

---

## 📁 Folder Structure

project/
│
├── data/ # Raw and cleaned datasets
├── queries/ # SQL queries used for analysis
├── visuals/ # Excel and Power BI exports
├── heatmap.png # Power BI champion heatmap
├── scatter_plot.png # Excel scatter plot
└── README.md # Project overview

---

## 📫 Contact

Feel free to reach out if you want to collaborate or discuss the project!
