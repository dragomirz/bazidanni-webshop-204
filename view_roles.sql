CREATE VIEW UserOrdersView AS
SELECT u.UserID, u.Username, o.OrderID, o.OrderDate, o.TotalAmount
FROM Users u
JOIN Orders o ON u.UserID = o.UserID;

-- Изглед за наличността на продуктите
CREATE VIEW ProductStockView AS
SELECT ProductID, ProductName, Stock
FROM Products;

-- Изглед за детайли на поръчките
CREATE VIEW OrderDetailsView AS
SELECT o.OrderID, od.ProductID, p.ProductName, od.Quantity, od.Price
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Създаване на роли и привилегии
-- Роля Admin
CREATE ROLE Admin;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';

-- Роля User с права на ниво таблица
CREATE ROLE UserRole;
GRANT SELECT, INSERT ON webshop.Orders TO 'user'@'localhost';

-- Роля с права на ниво колона
CREATE ROLE ColumnRole;
GRANT SELECT (Username, Email) ON webshop.Users TO 'user'@'localhost';

-- Създаване на потребители и присвояване на роли
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT Admin TO 'admin'@'localhost';

CREATE USER 'user'@'localhost' IDENTIFIED BY 'userpassword';
GRANT UserRole TO 'user'@'localhost';
GRANT ColumnRole TO 'user'@'localhost';
