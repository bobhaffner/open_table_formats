---
marp: true
theme: default

class:
    - invert
---

<style>
section {
  background: #4a80ed;
  color: white
}
</style>


# Open Table Formats
## The Foundation of the Data Lakehouse

---

# Obligatory Intro Slide

* Long time data person holding various roles over the years
* Consultant specializing in Data Engineering and Architecture
* Working with AWS for 7 years
* I'll post the Github link in the Meetup and LinkedIn groups
* Please jump in with questions along the way or at the end

<!--
Thanks to Improving for hosting
-->


---

# Outline
* Some history
* Open Table Formats Intro
* Apache Iceberg Intro
* Athena and Iceberg Demo

---

# Some History

* First there was the Data Warehouse
* Then the Data Lake
* And now a hybrid approach called Data Lakehouse

<!--
Data Warehouses were all the rage.  Before Data Warehouses, it was difficult to write BI and analytical queries (ie OLAP) against application databases.  They were often slower as well.   OLAP queries became easier and faster in a Data Warehouse.  Data Warehouse were also expensive to build and operate.


Data Lakes were a cheaper than Data Warehouses and they were often pitched as a replacement to Data Warehouses.  Not only could you store tabular data, you could store unstructured and semi-structured data.  And lots of it.  Sounds great, but what happens when you need to delete data for compliance reasons or update a customer address?   Nothing makes you miss databases quite like working with data lakes.  


And now, Data Lakehouses, a hybrid approach.  An attempt to combine the good things about Data Warehouses and Data Lakes
-->


---

# Open Table Formats Intro

* Its the foundation of the Data Lakehouse
* A layer that sits on top of object stores that brings database-like features to Data Lakes
* Delivering on the Data Lake hype
* Cheaper than Data Warehouses

<!--
Data Lake are still a good fit for append-only workloads and unstructured data

Not file formats (parquet or orc)
-->

---

# The Database-Like features

* ACID transactions
* Deletes, updates and inserts
* Time Travel queries
* Schema Evolution

<!--
Database-Like Features

- ACID –transactions – The king of database like features

- Deletes – for compliance reasons.  A user wants all their data removed 

- Updates which can be handy for Slowly Changing Dimensions

- Time Travel so we view our data has things change

- Schema Evolution including Adds, Drops and Type Promotions


-->

---

# The Open Table Format Players

* Delta Lake
* Apache Hudi
* Apache Iceberg
* Also, Apache XTable formerly OneTable
    
<!--

The Players

- Delta Lake – Open source, but heavily controlled by Databricks.  The default choice if you’re Databricks and Azure
- Apache Hudi. Pronounced Hoodie.  The most mature of the three.  Started at Uber.  Strong in the streaming space
- Apache Iceberg – Started at Netflix – Lots of momentum and backing from big vendors such as Snowflake, Google, Confluent, Dremio, AWS and Cloudera
- and there are things like Apache XTable that act as a universal interface to these 3.  Maybe some commercial solutions as well

We’ll be focusing on Iceberg for the rest of the presentation

-->

---

# Apache Iceberg Intro

---


![bg center:25% 25%](../../images/iceberg_metadata_1.png)

<!--

Iceberg uses a sophisticated Metadata Layer comprised of 4 different levels

1. Catalog
This is what Athena and Spark connect to. What tables exist and what is the current set of metadata.  

2. Metadata Files
This includes information about the table’s schema, partition information, snapshots, and which snapshot is the current one.

3. Manifest List Files
Contains a list of all the manifests that make up a snaphot or version. It can also contain partition level info for more efficient pruning

4. Manifest Files
Contains a list of all the data files and statistics about those data files.  Upper and lower bounds for a column.  eg this data file contains all data for 2023.   This allows for more efficient pruning

This heirachal meta file approach can be confusing but it allows for minimal metadata rewrites and paralellized data reading 

-->

---



![bg center:40% 40%](../../images/iceberg_metadata_2.png)

---

# How does this all fit in a Data Platform?

![w:1100 h:250](../../images/dlh.png)


<!--
Lakehouse can fulfill your OLAP needs as long as you can live with performance :-)

Spark and SQL(Presto or Trino or Athena) are two popular ways to write, update and read data stored in open table formats.   Another way is Flink

-->

---

# How does this all fit in a Data Platform?

![w:1100 h:300](../../images/dlh_with_RS.png)

<!--
And Lakehouses can be complementary to Data Warehouses where Data Warehouses handle queries that require faster response time

-->

---

# Athena and Iceberg Demo


<!--
1. Athena SQL
2. Branch Creation

-->