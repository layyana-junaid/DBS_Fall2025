<div align="center">

# 📘 Database Lab Notes  
**Layyana Junaid 23k-0056**

[![Typing SVG](https://readme-typing-svg.demolab.com/?lines=Databases%2C%20SQL%2C%20and%20PL%2FSQL;Designing%20Efficient%20Data%20Systems;Oracle%20SQL%20Developer%20Practices;Learning%20Queries%20Step-by-Step&color=32CD32&center=true&width=700&pause=1500)](https://git.io/typing-svg)

This repo serves as both a **learning journal** and a **reference guide** for everything I practice in SQL and database concepts during my labs.

</div>

---


## 💾 Database Tech Stack

<p align="center">
  <img src="https://img.shields.io/badge/SQL-006400?style=for-the-badge&logo=postgresql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Oracle-228B22?style=for-the-badge&logo=oracle&logoColor=white"/>
  <img src="https://img.shields.io/badge/PLSQL-2E8B57?style=for-the-badge&logo=databricks&logoColor=white"/>
  <img src="https://img.shields.io/badge/Database-3CB371?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/ERD%20Design-32CD32?style=for-the-badge&logo=drawio&logoColor=white"/>
</p>

---

## 📖 What Are Databases?

A **database** is an organized collection of data that allows efficient storage, retrieval, and manipulation.  
In this course, I am mainly working with **Oracle SQL Developer**, learning both **SQL (Structured Query Language)** and **PL/SQL** to query and manage relational databases.  

Key concepts I’ve explored so far:
- Data storage in **tables (rows & columns)**.  
- Writing **SQL queries** for retrieval and manipulation.  
- Using **functions** (date, string, numeric).  
- Grouping, aggregation, and **analytic queries**.  

---

## 📝 Lab Notes

### 🔹 Lab 2 – SQL Functions & Queries
In this lab, I practiced:

- **Date & Time Functions**
  - Display current system date (`select sysdate from dual;`).
  - Format date like `Monday August 2025`.
  - Find next Monday after a given date.
  - Convert string to date and format as `MM-YYYY`.

- **String Functions**
  - Extract first 5 characters of last name.
  - Pad first names with `*` to width 15.
  - Remove leading spaces (`ltrim`).
  - Capitalize names (`initcap`).

- **Aggregates**
  - Count months each employee worked (`months_between`).
  - Distinct salaries in ascending order.
  - Round salaries to nearest hundred.

- **Analytic Queries**
  - Department(s) with max employees (using `dense_rank`).
  - Top 3 departments by salary expense.

✅ **Key Takeaway**: Learned to combine **date, string, aggregation, and analytic functions** in Oracle SQL to solve real business-style queries.

---
