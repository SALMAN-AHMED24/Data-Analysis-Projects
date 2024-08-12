# Counting the total sales based on Town

Select town, Count(serial_number) as total_sales
From real_estate_18_21
Group by town
Order by total_sales Desc;



# Comparing assessed value and sale price based on town

With CTE_1 as
(
Select town, avg(assessed_value) average_assessed_value, avg(sale_amount) as average_sale_amount
From real_estate_18_21
Group by town
Order by average_assessed_value Desc, average_sale_amount Asc
)

Select *,
Case
	When average_assessed_value < average_sale_amount Then 'Price increased'
    When average_assessed_value > average_sale_amount Then 'Price decreased'
    Else 'No change'
End as Statement
From CTE_1;



# Demand for different property types

Drop Table If Exists temp_1;
Create Temporary Table temp_1
Select property_type, Count(serial_number) as total_unit_sold
From real_estate_18_21
Group by property_type
;
Select *
From temp_1;

# Trends of different property types based on town

Select town, property_type, Count(serial_number) as unit_sold
From real_estate_18_21
Group by town, property_type
Order by property_type Desc, unit_sold Desc
;



# Breaking the residential property type and find the rend based on town

Select town, property_type, residential_type, Count(residential_type) as unit_sold
From real_estate_18_21
Where property_type = 'Residential'
Group by town, property_type, residential_type
Order by town Asc
;




