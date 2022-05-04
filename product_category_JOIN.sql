-- ������� 
-- � ���� ������ MS SQL Server ���� �������� � ���������. 
-- ������ �������� ����� ��������������� ����� ���������, � ����� ��������� ����� ���� ����� ���������. 
-- �������� SQL ������ ��� ������ ���� ��� ���� �������� � ��� ���������. 
-- ���� � �������� ��� ���������, �� ��� ��� ��� ����� ������ ����������.
 
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
		('�������'), --1
		('�������'), --2
		('�������'), --3
		('�����'),   --4
		('�����'),   --5
		('������'), --6
		('��������') --7
GO		

--DROP TABLE Categories		
CREATE TABLE Categories (
  CategoryId int NOT NULL IDENTITY CONSTRAINT PK_Categories_CategoryId PRIMARY KEY,
  CategoryName nvarchar(50) NOT NULL
)
GO

INSERT INTO Categories(CategoryName) VALUES
('������� �� ����'),                --1
('�����'),                          --2
('�������������� ��� �����������'), --3
('������'),                         --4
('�����������')                     --5
GO

-- ����� ����� ��������� - ������ �� ������, ����� 3-� �������:

CREATE TABLE ProductsCategories (
  ProductId int NULL CONSTRAINT FK_ProductsCategories_Products FOREIGN KEY (ProductId)  REFERENCES Products (ProductId),
  CategoryId int NULL CONSTRAINT FK_ProductsCategories_Categories FOREIGN KEY (CategoryId)  REFERENCES Categories (CategoryId),
  --CONSTRAINT PK_ProductsCategories PRIMARY KEY (ProductId, CategoryId)
)
GO

INSERT INTO ProductsCategories (ProductId, CategoryId)
	VALUES
		('1', '1'), --�������1 - ������� �� ����1
		('1', '2'), --�������1 - �����2
		('2', '1'), --�������2 - ������� �� ����1
    ('2', '2'), --�������2 - �����2
		('3', '1'), --�������3 - ������� �� ����1
    ('3', '3'), --�������3 - �������������� ��� ����������� 3
    ('4', '1'), --�����4   - ������� �� ����1
    ('4', '3'), --�����4   - �������������� ��� ����������� 3
		('5', '4'), --�����5   - ������4
		('6', null), --�������6  - -
		('7', null), --��������7 - -
    (null, '5')  -- -        - �����������5
GO		

  --�� ������� ���� � �������� ��� ���������, �� ��� ��� ��� ����� ������ ����������,
  --������, ���� � ��������� ��� ��������, �� �� �� ���� ��������
  --����� ����� ����� �� ����. ProductsCategories ��� �� null �������� ProductId � ����� �� �������������� ���� ���� ProductName - CategoryName


SELECT p.ProductName, c.CategoryName FROM ProductsCategories pk 
  JOIN Products p                --������� JOIN ������ null �� ����. ProductsCategories ��� �����������
  ON pk.ProductId = p.ProductId
 
  LEFT JOIN Categories c         --LEFT JOIN ������� �������� � null � ������ ��������
  ON pk.CategoryId = c.CategoryId

  

