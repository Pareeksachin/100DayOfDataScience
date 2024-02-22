show databases;

use laptop_data;

select * from laptopdata;

# renaming the table name
alter table laptopdata rename to laptop;

# create a backup table and insert data in to it
create table laptop_backup AS select * from laptop;

select * from laptop_backup;

# checking memory consumption of data

show table status like 'laptop';
# you will get name of the table, enginer , version , row_format, rows and data length etc from above query

# fatch data_lenth 
select data_length/1024 as 'data_size(KB)' from information_schema.tables where table_schema='laptop_data' and table_name = 'laptop';
# here information_schema.tables contains the metadata about table

select * from laptop limit 1,10;


# DROP non-important column
alter table laptop drop column `Unnamed: 0`; # use backticks or square brackets

#The sql_safe_updates mode in MySQL is a safety feature that prevents you from executing an UPDATE or DELETE statement without specifying 
# a key constraint in the WHERE clause. When sql_safe_updates is enabled (set to 1), MySQL restricts you from updating or deleting rows 
# without using a WHERE clause with a key constraint.
# To disable sql_safe_updates and allow unsafe updates, you can set it to 0.

#please be cautious when using this setting, as it allows you to execute UPDATE and DELETE statements without key constraints, which can 
#potentially lead to unintended data modification or deletion. After you've finished your operation, it's a good practice to re-enable 
#sql_safe_updates by setting it back to 1:
set sql_safe_updates = 0;
set sql_safe_updates = 1;

#To check the current value of sql_safe_updates
SELECT @@sql_safe_updates;

# Drop all the rows where all values are NULL
DELETE FROM laptop
WHERE 
  Company IS NULL OR
  TypeName IS NULL OR
  Inches IS NULL OR
  ScreenResolution IS NULL OR
  Cpu IS NULL OR
  Ram IS NULL OR
  Memory IS NULL OR
  Gpu IS NULL OR
  OpSys IS NULL OR
  Weight IS NULL OR
  Price IS NULL;
  
  select * from laptop;

# ADD A INDEX COLUMN TO IDENTIFY EACH RECORD UNIQUELY
alter table laptop add column index_number INT AUTO_INCREMENT PRIMARY KEY;

## Drop 15 rows 
delete from laptop where index_column between 1 AND 15;

# Below query will throw an error becuase delete statement doesn't support order by or  desc. 
#delete from laptop where order by index_column desc limit 15;

#so to delete 15 record on the basis of index_column
DELETE FROM laptop
WHERE index_number IN (
    SELECT index_number
    FROM (
        SELECT index_number
        FROM laptop
        ORDER BY index_number DESC
        LIMIT 15
    ) AS subquery
);

# to show record in desc order 
select * from laptop order by index_number desc limit 15;

# check duplicate records 

select Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price, count(*) from laptop group by 
Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price having count(*)>1;

# remove duplicate record 
# method 1 : by creating another table 
# method 2 : by using window function




# to view duplicate record 
with ranked_row as (
select *, row_number() over(partition by Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price order by index_number) 
as row_num from laptop )
select * from ranked_row where row_num > 1;

# to delete these record 

set sql_safe_updates = 0;
DELETE FROM laptop
WHERE index_number IN (
    SELECT index_number
    FROM (
        SELECT index_number,
               ROW_NUMBER() OVER (PARTITION BY Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price ORDER BY index_number) AS row_num
        FROM laptop
    ) AS ranked_rows
    WHERE row_num > 1
);


# Checking all columns for null or missing value

SELECT *
FROM laptop
WHERE Company IS NULL
   OR TypeName IS NULL
   OR Inches IS NULL
   OR ScreenResolution IS NULL
   OR Cpu IS NULL
   OR Ram IS NULL
   OR Memory IS NULL
   OR Gpu IS NULL
   OR OpSys IS NULL
   OR Weight IS NULL
   OR Price IS NULL;
 
 
 # Check Datatype 
 describe laptop;
 
 # Convert inches column to decimal
 alter table laptop modify column Inches decimal(10,1);
 
  # Check unique values
  select distinct Inches from laptop;
 
# Cleaning or Changing Data type of a column "Ram"
 
 update laptop l1 join (select index_number, replace(Ram,'GB',"") as new_ram from laptop) as l2 on l1.index_number=l2.index_number set l1.ram = l2.new_ram;

update laptop set ram = replace(Ram,'GB',""); 

describe laptop;

alter table laptop modify column Ram int;


# Clean Weight column or Change Data Type of Weight column

update laptop l1 join (select index_number,replace(Weight,'Kg',"") as new_wt from laptop) as l2 on l1.index_number = l2.index_number
set l1.Weight= l2.new_wt;

update laptop set Weight = replace(Weight,'KG',""); 
Describe laptop;
# Change data type for Weight column 
alter table laptop modify column Weight decimal(10,2);

describe laptop;
select * from laptop;

  select distinct weight from laptop;



