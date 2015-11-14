title: "mysql_basic"
date: 2015-07-11 14:52:15
updated: 2015-07-11 14:52:15
tags:
categories:
---

# MySQL on Ubuntu

## How to install MySQL on Ubuntu and CentOS

Ubuntu:  

    sudo apt-get install mysql-server

CentOS:  
    
    sudo yum install mysql-server 
    /etc/init.d/mysqld start

## Access MySQL shell

Command into termainl:  

    mysql -u root -p

After entering the `root` password, you will able to build your MySQL statmase. 

**Two points to keep in mind:**  
1. All MySQL commands end with **semicolon(;)**  
2. MySQL commands ususally written in uppsercase. Database, tables, usernames, or text are in lowercase. 

## Create and Delete a MySQL Database

Show current databases:

    SHOW DATABASES;

Your screen should look like this: 

    mysql> SHOW DATABASES;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | RZwpDatabase       |
    | XRwpDatabase       |
    | mysql              |
    | performance_schema |
    | phpmyadmin         |
    +--------------------+
    6 rows in set (0.00 sec)

Creating a database:

    CREATE DATABASE databaseName;

Delete a database: 

    DROP DATABASE databseName;
    
## Access a MySQL Database

Let's open up the database we just created `events`: 

    USE events;

Create a MySQL Table: 
