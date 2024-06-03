CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL
);


INSERT INTO Roles (RoleName) VALUES ('Admin'), ('User');
INSERT INTO Users (Username, Password, Email, RoleID) VALUES 
('admin', 'adminpassword', 'admin@example.com', 1),
('user1', 'user1password', 'user1@example.com', 2);
INSERT INTO Products (ProductName, Price, Stock) VALUES 
('Product1', 10.00, 100),
('Product2', 20.00, 50);
INSERT INTO Orders (UserID, OrderDate, TotalAmount) VALUES 
(2, NOW(), 30.00);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES 
(1, 1, 2, 10.00),
(1, 2, 1, 20.00);