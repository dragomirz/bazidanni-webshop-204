CREATE TRIGGER before_insert_orders
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN

    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists FROM Users WHERE UserID = NEW.UserID;

    IF user_exists = 0 THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User does not exist';

    END IF;

END;

CREATE TRIGGER after_insert_orders

AFTER INSERT ON Orders

FOR EACH ROW

BEGIN

    UPDATE Products

    SET Stock = Stock - (SELECT Quantity FROM OrderDetails WHERE OrderID = NEW.OrderID AND ProductID = Products.ProductID)

    WHERE ProductID IN (SELECT ProductID FROM OrderDetails WHERE OrderID = NEW.OrderID);

END;

CREATE TRIGGER before_update_products

BEFORE UPDATE ON Products

FOR EACH ROW

BEGIN

    IF NEW.Price < 0 THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';

    END IF;

END;

CREATE TRIGGER after_update_products

AFTER UPDATE ON Products

FOR EACH ROW

BEGIN

    INSERT INTO PriceChangeLog (ProductID, OldPrice, NewPrice, ChangeDate)

    VALUES (OLD.ProductID, OLD.Price, NEW.Price, NOW());

END;


