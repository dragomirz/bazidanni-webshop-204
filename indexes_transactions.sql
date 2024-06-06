-- Прост индекс на Username в Users
CREATE INDEX idx_username ON Users (Username);

-- Съставен индекс на OrderID и ProductID в OrderDetails
CREATE INDEX idx_order_product ON OrderDetails (OrderID, ProductID);

-- Префиксен индекс на ProductName в Products
CREATE INDEX idx_productname_prefix ON Products (ProductName(10));

-- Пример за транзакция при създаване на поръчка
BEGIN;

INSERT INTO Orders (UserID, OrderDate, TotalAmount)
VALUES (2, NOW(), 30.00);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (LAST_INSERT_ID(), 1, 2, 10.00),
       (LAST_INSERT_ID(), 2, 1, 20.00);

UPDATE Products
SET Stock = Stock - 2
WHERE ProductID = 1;

UPDATE Products
SET Stock = Stock - 1
WHERE ProductID = 2;

