# Trainee_Test_FigureArea_SQL

## 1
Write a C# library for delivery to external clients that can calculate the area of ​​a circle from its radius and a triangle from three sides.
In addition to performance, we evaluate:
- Unit tests
- Ease of adding other shapes.
 You can simply add Figure_Lib?.dll with other figures to the library project

- Calculating the area of a figure without knowing the type of figure in compile-time.
 Implemented input of figure data separated by a space. How many values there will be, this type will work for the calculation.

- Checking if a triangle is a rectangular triangle.
 The check is built in. The interface of the type that performs the calculation provides an output comment.
 
 ## 2
MS SQL Server database has products and categories.
One product can have many categories, and one category can have many products.
Write an SQL query to select all pairs of "Product Name - Category Name".
If a product has no categories, then its name should still be displayed.
