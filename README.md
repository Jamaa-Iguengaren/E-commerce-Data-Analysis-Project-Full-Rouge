# 📊 E-Commerce Data Analytics Project

## 🚀 Overview

Ce projet est une solution complète de **Data Analytics & Business Intelligence** appliquée à un dataset e-commerce.

L’objectif est de transformer des données brutes en **insights business exploitables** à travers un pipeline complet :

- Data Engineering (Data Warehouse)
- SQL (modélisation en étoile - Star Schema)
- Data Cleaning & Transformation
- Exploratory Data Analysis (EDA en Python)
- KPI Business Analysis
- Data Visualization (Power BI Dashboard)

---

## 🎯 Business Objectives

Ce projet vise à répondre aux problématiques suivantes :

- 📉 Manque de visibilité sur les performances des ventes
- 👥 Absence de segmentation client claire
- 🛍️ Identification des produits les plus et moins performants
- 🌍 Analyse géographique des ventes
- 💰 Suivi des KPIs financiers (Revenue, Profit, Panier moyen)
- 📊 Aide à la prise de décision basée sur les données

---

## 🏗️ Data Architecture (Medallion Architecture)

Le projet est structuré en 3 couches :

### 🥉 Bronze Layer
- Données brutes (CSV)
- Aucune transformation
- Source initiale du dataset

### 🥈 Silver Layer
- Nettoyage des données
- Suppression des doublons
- Gestion des types (CAST / TRY_CAST)
- Création des tables :
  - `dim_customer`
  - `dim_product`
  - `dim_date`
  - `fact_sales`

### 🥇 Gold Layer
- Vues analytiques prêtes pour BI
- Optimisées pour Power BI
- Support des KPIs et dashboards

---

## 🧠 Data Modeling (Star Schema)

Le modèle utilisé est un **Star Schema** :
dim_customer
│
dim_product ── fact_sales ── dim_date

### 📌 Fact Table:
- fact_sales (transactions de vente)

### 📌 Dimensions:
- Customers
- Products
- Date

---

## 🐍 Exploratory Data Analysis (EDA - Python)

L’analyse exploratoire a été réalisée avec :

### 📚 Libraries utilisées
- Pandas
- NumPy
- Matplotlib
- Seaborn

### 📊 Analyses réalisées
- Data cleaning (missing values, duplicates)
- Analyse univariée (distribution des ventes, profit)
- Analyse bivariée (discount vs profit, category vs revenue)
- Analyse temporelle (trends mensuels, saisonnalité)
- Analyse des corrélations

---

## 📈 Key Business KPIs

Les indicateurs clés calculés :

- 💰 Total Revenue (Chiffre d’affaires)
- 📦 Total Orders
- 💵 Panier Moyen (AOV)
- 📈 Total Profit
- 📊 Profit Margin %
- 👥 Number of Customers
- 🛍️ Top Products & Categories

---

## 📊 Power BI Dashboard

Le dashboard interactif permet :

- Suivi des ventes en temps réel
- Analyse des performances produits
- Segmentation client
- Analyse géographique
- Suivi des KPIs financiers

---

## 🛠️ Technologies Used

- SQL Server
- Python (Pandas, NumPy, Matplotlib, Seaborn)
- Power BI
- Git & GitHub

---

## 📌 Key Insights

- Certaines catégories génèrent la majorité du revenu
- Les clients VIP contribuent fortement au profit
- Les promotions influencent le volume des ventes mais réduisent parfois le profit
- Forte saisonnalité des ventes
- Différences significatives entre segments clients

---

## 🚀 Project Impact

Ce projet démontre :

- Compétences en Data Engineering
- Maîtrise du SQL et Data Warehouse
- Analyse exploratoire avancée (EDA)
- Capacité à créer des KPI business
- Construction de dashboards décisionnels

---

## 📌 Future Improvements

- Intégration Machine Learning (forecasting des ventes)
- Automatisation du pipeline ETL
- Dashboard temps réel
- Segmentation client avancée (RFM)

---

## ⭐ Repository Goal

Ce projet est un **portfolio professionnel** démontrant une maîtrise complète du cycle de vie des données :
From **Raw Data → Insights → Business Decisions**
```
