# 🎵 Music Store SQL Project (Tabular README)

## 📌 Project Overview

| Item         | Description                                        |
| ------------ | -------------------------------------------------- |
| Project Name | Music Store Data Analysis                          |
| Purpose      | Analyze customer behavior, sales, and music trends |
| Tools Used   | MySQL, SQL Workbench                               |
| Dataset      | Music Store (Chinook Schema)                       |

---

## 🗂️ Tables Used

| Table Name   | Description            |
| ------------ | ---------------------- |
| customer     | Customer details       |
| invoice      | Billing & total amount |
| invoice_line | Individual purchases   |
| track        | Song details           |
| album        | Album info             |
| artist       | Artist info            |
| genre        | Music categories       |

---

## 🎯 Business Questions & Insights

| #  | Question                        | Insight                     |
| -- | ------------------------------- | --------------------------- |
| 1  | Senior-most employee            | Found using hierarchy       |
| 2  | Countries with most invoices    | Top revenue regions         |
| 3  | Top 3 invoice values            | Highest purchases           |
| 4  | Best city                       | Highest total revenue       |
| 5  | Best customer                   | Highest spender             |
| 6  | Rock listeners                  | Customer genre preference   |
| 7  | Top rock artists                | Most rock tracks            |
| 8  | Long tracks                     | Above-average duration      |
| 9  | Spending by customer on artists | Customer-artist revenue     |
| 10 | Popular genre per country       | Based on purchase count     |
| 11 | Top customer per country        | Highest spender per country |

---

## 🧠 SQL Concepts Used

| Concept           | Usage                   |
| ----------------- | ----------------------- |
| JOIN              | Combine multiple tables |
| GROUP BY          | Aggregate data          |
| SUM / COUNT / AVG | Calculations            |
| HAVING            | Filter aggregated data  |
| SUBQUERY          | Nested queries          |
| RANK()            | Top per group logic     |
| DISTINCT          | Remove duplicates       |

---

## 🔗 Table Relationship

| Flow                                                       |
| ---------------------------------------------------------- |
| customer → invoice → invoice_line → track → album → artist |

---

## ⚡ Key Learnings

| Topic                 | Explanation            |
| --------------------- | ---------------------- |
| Revenue vs Popularity | SUM vs COUNT           |
| Debugging             | Check joins & columns  |
| Top per group         | Use RANK or JOIN + MAX |
| Data duplication      | Use DISTINCT           |

---

## 🚀 Sample Query

```sql
SELECT 
    c.country,
    c.first_name,
    SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.country, c.customer_id, c.first_name;
```

---

## 📊 Insights

| Insight                                |
| -------------------------------------- |
| Top countries generate most revenue    |
| Rock is a dominant genre               |
| Few customers contribute major revenue |
| Popular artists drive sales            |

---

## 💡 Future Improvements

| Idea                              |
| --------------------------------- |
| Add dashboards (Power BI/Tableau) |
| Time-based analysis               |
| Customer segmentation             |

---

## 🙌 Author

| Name    | Role             |
| ------- | ---------------- |
| Jeevana | SQL Data Analyst |
