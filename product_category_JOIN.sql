-- Задание 
-- В базе данных MS SQL Server есть продукты и категории. 
-- Одному продукту может соответствовать много категорий, в одной категории может быть много продуктов. 
-- Напишите SQL запрос для выбора всех пар «Имя продукта – Имя категории». 
-- Если у продукта нет категорий, то его имя все равно должно выводиться.
 
-- DROP DATABASE Test 
CREATE DATABASE Test 
GO     

ALTER DATABASE Test
COLLATE Cyrillic_General_CI_AS	
GO

USE Test
GO

--DROP TABLE Products
CREATE TABLE Products
(
	ProductId int NOT NULL IDENTITY CONSTRAINT PK_Products_ProductId PRIMARY KEY,
	ProductName nvarchar(50) NOT NULL
); 
GO

INSERT INTO Products(ProductName)
	VALUES
		('ботинки'), --1
		('сандали'), --2
		('чемодан'), --3
		('сумка'),   --4
		('диван'),   --5
		('самолёт'), --6
		('коленвал') --7
GO		

--DROP TABLE Categories		
CREATE TABLE Categories (
  CategoryId int NOT NULL IDENTITY CONSTRAINT PK_Categories_CategoryId PRIMARY KEY,
  CategoryName nvarchar(50) NOT NULL
)
GO

INSERT INTO Categories(CategoryName) VALUES
('изделия из кожи'),                --1
('обувь'),                          --2
('принадлежности для путешествий'), --3
('мебель'),                         --4
('электроника')                     --5
GO

-- Связь между таблицами - многие ко многим, нужна 3-я таблица:

CREATE TABLE ProductsCategories (
  ProductId int NULL CONSTRAINT FK_ProductsCategories_Products FOREIGN KEY (ProductId)  REFERENCES Products (ProductId),
  CategoryId int NULL CONSTRAINT FK_ProductsCategories_Categories FOREIGN KEY (CategoryId)  REFERENCES Categories (CategoryId),
  --CONSTRAINT PK_ProductsCategories PRIMARY KEY (ProductId, CategoryId)
)
GO

INSERT INTO ProductsCategories (ProductId, CategoryId)
	VALUES
		('1', '1'), --ботинки1 - изделия из кожи1
		('1', '2'), --ботинки1 - обувь2
		('2', '1'), --сандали2 - изделия из кожи1
    ('2', '2'), --сандали2 - обувь2
		('3', '1'), --чемодан3 - изделия из кожи1
    ('3', '3'), --чемодан3 - принадлежности для путешествий 3
    ('4', '1'), --сумка4   - изделия из кожи1
    ('4', '3'), --сумка4   - принадлежности для путешествий 3
		('5', '4'), --диван5   - мебель4
		('6', null), --самолет6  - -
		('7', null), --коленвал7 - -
    (null, '5')  -- -        - электроника5
GO		

  --По заданию если у продукта нет категорий, то его имя все равно должно выводиться,
  --Значит, если у категории нет продукта, то ёё НЕ НАДО выводить
  --Тогда нужно взять из табл. ProductsCategories все не null значения ProductId и найти им соответсвующие пары имен ProductName - CategoryName


SELECT p.ProductName, c.CategoryName FROM ProductsCategories pk 
  JOIN Products p                --простой JOIN уберет null из табл. ProductsCategories при объединении
  ON pk.ProductId = p.ProductId
 
  LEFT JOIN Categories c         --LEFT JOIN оставит значения с null в правом столбике
  ON pk.CategoryId = c.CategoryId

  

