IF OBJECT_ID('EMPLOYEE', 'U') IS NOT NULL DROP TABLE EMPLOYEE;
IF OBJECT_ID('DEPARTMENT', 'U') IS NOT NULL DROP TABLE DEPARTMENT;
IF OBJECT_ID('ORDER_ITEM_DELIVERY', 'U') IS NOT NULL DROP TABLE ORDER_ITEM_DELIVERY;
IF OBJECT_ID('REVIEWS', 'U') IS NOT NULL DROP TABLE REVIEWS;
IF OBJECT_ID('ITEMS', 'U') IS NOT NULL DROP TABLE ITEMS;
IF OBJECT_ID('CATEGORIES', 'U') IS NOT NULL DROP TABLE CATEGORIES;
IF OBJECT_ID('DELIVERIES', 'U') IS NOT NULL DROP TABLE DELIVERIES;
IF OBJECT_ID('ORDERS', 'U') IS NOT NULL DROP TABLE ORDERS;
IF OBJECT_ID('USERS', 'U') IS NOT NULL DROP TABLE USERS;

--CREATE TABLE
    CREATE TABLE USERS
    (
        UserNo      INT       NOT NULL CHECK(UserNo BETWEEN 0 AND 99999999),
        UserName    CHAR(20)  NOT NULL,
        PhoneNo     CHAR(13),
        Balance     INT       NOT NULL CHECK(Balance BETWEEN 0 AND 10000000),
        ID          CHAR(20)  NOT NULL UNIQUE,
        PW          CHAR(20)  NOT NULL,
        PRIMARY KEY(UserNo)
    );

    CREATE TABLE ORDERS
    (
        OrderNo        INT       NOT NULL CHECK(OrderNo BETWEEN 0 AND 9999),
        OrderDate      DATE      NOT NULL CHECK(OrderDate > '2025-05-12'),
        PriceAtOrder   INT       NOT NULL CHECK(PriceAtOrder BETWEEN 0 AND 10000000),
        Quantity       INT       NOT NULL,
        UserNo         INT       NOT NULL CHECK(UserNo BETWEEN 0 AND 99999999),
        PRIMARY KEY(OrderNo),
        FOREIGN KEY(UserNo) REFERENCES USERS(UserNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

    CREATE TABLE DELIVERIES
    (
        DeliveryNo     INT   NOT NULL CHECK(DeliveryNo BETWEEN 0 AND 99999),
        Zipcode        INT   NOT NULL CHECK(Zipcode BETWEEN 0 AND 99999),
        DeliveryStatus INT   NOT NULL CHECK(DeliveryStatus BETWEEN 0 AND 4),
            -- 0 �ֹ�����, 1 ��ǰ�غ���, 2 �����, 3 ��ۿϷ�, 4 ��۽���
        Carrier        INT   CHECK(Carrier BETWEEN 0 AND 99999),
        PRIMARY KEY(DeliveryNo)
    );

    CREATE TABLE CATEGORIES
    (
        CategoryNo       INT       NOT NULL CHECK(CategoryNo BETWEEN 0 AND 999),
        CategoryName     CHAR(20)  NOT NULL,
        ParentCategoryNo INT       CHECK(ParentCategoryNo BETWEEN 0 AND 999),
        PRIMARY KEY(CategoryNo),
        FOREIGN KEY(ParentCategoryNo) REFERENCES CATEGORIES(CategoryNo)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );

    CREATE TABLE ITEMS
    (
        ItemNo       INT       NOT NULL CHECK(ItemNo BETWEEN 0 AND 99999),
        ItemName     CHAR(50)  NOT NULL,
        ItemStock    INT       NOT NULL CHECK(ItemStock BETWEEN 0 AND 99),
        ItemStatus   BIT       NOT NULL,
        CategoryNo   INT       NOT NULL DEFAULT 0 CHECK(CategoryNo BETWEEN 0 AND 999),
        ItemPrice    INT       NOT NULL CHECK(ItemPrice BETWEEN 0 AND 10000000),
        PRIMARY KEY(ItemNo),
        FOREIGN KEY(CategoryNo) REFERENCES CATEGORIES(CategoryNo)
            ON DELETE NO ACTION
            ON UPDATE CASCADE
    );

    CREATE TABLE REVIEWS
    (
        UserNo      INT       NOT NULL CHECK(UserNo BETWEEN 0 AND 99999999),
        ItemNo      INT       NOT NULL CHECK(ItemNo BETWEEN 0 AND 99999),
        ReviewDate  DATE      NOT NULL CHECK(ReviewDate > '2025-05-12'),
        Content     CHAR(100) NOT NULL,
        Rating      INT       NOT NULL CHECK(Rating BETWEEN 0 AND 5),
        PRIMARY KEY(UserNo, ItemNo, ReviewDate),
        FOREIGN KEY(UserNo) REFERENCES USERS(UserNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY(ItemNo) REFERENCES ITEMS(ItemNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

    CREATE TABLE ORDER_ITEM_DELIVERY
    (
        OrderNo     INT   NOT NULL CHECK(OrderNo BETWEEN 0 AND 9999),
        DeliveryNo  INT   NOT NULL CHECK(DeliveryNo BETWEEN 0 AND 99999),
        ItemNo      INT   NOT NULL CHECK(ItemNo BETWEEN 0 AND 99999),
        PRIMARY KEY(OrderNo, DeliveryNo, ItemNo),
        FOREIGN KEY(OrderNo)    REFERENCES ORDERS(OrderNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY(DeliveryNo) REFERENCES DELIVERIES(DeliveryNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY(ItemNo)     REFERENCES ITEMS(ItemNo)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

--INSERT INTO
    INSERT INTO USERS VALUES (0, 'KIM', '010-1234-5610', 1352858, 'user0', 'pw0');
    INSERT INTO USERS VALUES (1, 'LEE', '010-1234-5601', 1883820, 'user1', 'pw1');
    INSERT INTO USERS VALUES (2, 'YANG', '010-1234-5602', 456063, 'user2', 'pw2');
    INSERT INTO USERS VALUES (3, 'HONG', '010-1234-5603', 1639178, 'user3', 'pw3');
    INSERT INTO USERS VALUES (4, 'KANG', '010-1234-5604', 1066431, 'user4', 'pw4');
    INSERT INTO USERS VALUES (5, 'GILL', '010-1234-5605', 1178295, 'user5', 'pw5');
    INSERT INTO USERS VALUES (6, 'PARK', '010-1234-5606', 277844, 'user6', 'pw6');
    INSERT INTO USERS VALUES (7, 'JUNG', '010-1234-5607', 1408324, 'user7', 'pw7');
    INSERT INTO USERS VALUES (8, 'RHO', '010-1234-5608', 1715070, 'user8', 'pw8');
    INSERT INTO USERS VALUES (9, 'AHN', '010-1234-5609', 340449, 'user9', 'pw9');

    INSERT INTO ORDERS VALUES (0, '2025-10-28', 1990000, 1, 3);
    INSERT INTO ORDERS VALUES (1, '2025-08-02', 2290000, 1, 8);
    INSERT INTO ORDERS VALUES (2, '2025-08-13', 2990000, 2, 6);
    INSERT INTO ORDERS VALUES (3, '2025-08-06', 1890000, 1, 9);
    INSERT INTO ORDERS VALUES (4, '2025-10-15', 1500000, 1, 8);
    INSERT INTO ORDERS VALUES (5, '2025-06-04', 990000, 2, 9);
    INSERT INTO ORDERS VALUES (6, '2025-11-15', 900000, 3, 6);
    INSERT INTO ORDERS VALUES (7, '2025-07-04', 1400000, 1, 9);
    INSERT INTO ORDERS VALUES (8, '2025-08-31', 20000, 1, 3);
    INSERT INTO ORDERS VALUES (9, '2025-06-25', 1400000, 3, 9);
    INSERT INTO ORDERS VALUES (10, '2025-11-20', 1400000, 2, 5);
    INSERT INTO ORDERS VALUES (11, '2025-11-22', 3000000, 1, 6);
    INSERT INTO ORDERS VALUES (12, '2025-11-25', 1130000, 1, 7);
    INSERT INTO ORDERS VALUES (13, '2025-12-01', 329000, 2, 2);
    INSERT INTO ORDERS VALUES (14, '2025-12-04', 12000, 1, 0);
    INSERT INTO ORDERS VALUES (15, '2025-12-18', 1771000, 2, 6);
    INSERT INTO ORDERS VALUES (16, '2025-11-20', 1729000, 2, 5);
    INSERT INTO ORDERS VALUES (17, '2025-12-19', 1850000, 2, 2);
    INSERT INTO ORDERS VALUES (18, '2025-12-30', 879000, 1, 3);
    INSERT INTO ORDERS VALUES (19, '2025-11-20', 2500000, 1, 4);
    INSERT INTO ORDERS VALUES (20, '2025-11-19', 1421000, 3, 6);
    INSERT INTO ORDERS VALUES (21, '2025-11-04', 45000, 4, 8);
    INSERT INTO ORDERS VALUES (22, '2025-12-25', 1090000, 5, 2);
    INSERT INTO ORDERS VALUES (23, '2025-12-11', 2290000, 2, 1);


    INSERT INTO DELIVERIES VALUES (0, 34014, 2, 4);
    INSERT INTO DELIVERIES VALUES (1, 78312, 3, 1);
    INSERT INTO DELIVERIES VALUES (2, 48788, 2, 2);
    INSERT INTO DELIVERIES VALUES (3, 69752, 0, 3);
    INSERT INTO DELIVERIES VALUES (4, 72708, 3, 2);
    INSERT INTO DELIVERIES VALUES (5, 82556, 1, 3);
    INSERT INTO DELIVERIES VALUES (6, 88942, 0, 4);
    INSERT INTO DELIVERIES VALUES (7, 84561, 3, 0);
    INSERT INTO DELIVERIES VALUES (8, 80410, 1, 2);
    INSERT INTO DELIVERIES VALUES (9, 49839, 0, 0);
    INSERT INTO DELIVERIES VALUES (10, 42100, 1, 5);
    INSERT INTO DELIVERIES VALUES (11, 38901, 2, 3);
    INSERT INTO DELIVERIES VALUES (12, 55982, 0, 1);
    INSERT INTO DELIVERIES VALUES (13, 61033, 3, 2);
    INSERT INTO DELIVERIES VALUES (14, 73400, 1, 4);
    INSERT INTO DELIVERIES VALUES (15, 32877, 4, 7);
    INSERT INTO DELIVERIES VALUES (16, 43329, 4, 3);
    INSERT INTO DELIVERIES VALUES (17, 67620, 2, 8);
    INSERT INTO DELIVERIES VALUES (18, 30546, 0, 6);
    INSERT INTO DELIVERIES VALUES (19, 75445, 0, 1);
    INSERT INTO DELIVERIES VALUES (20, 96974, 2, 5);
    INSERT INTO DELIVERIES VALUES (21, 19921, 1, 6);
    INSERT INTO DELIVERIES VALUES (22, 25088, 1, 2);
    INSERT INTO DELIVERIES VALUES (23, 34324, 3, 5);
    INSERT INTO DELIVERIES VALUES (24, 27129, 2, 1);

    INSERT INTO CATEGORIES VALUES (0, 'Electronics', NULL);
    INSERT INTO CATEGORIES VALUES (4, 'Computers', 0);
    INSERT INTO CATEGORIES VALUES (1, 'TV/Monitor', 0);
    INSERT INTO CATEGORIES VALUES (11, 'Home Appliances', 0);
    INSERT INTO CATEGORIES VALUES (3, 'Mobile Devices', 0);
    INSERT INTO CATEGORIES VALUES (7, 'Peripherals', 0);
    INSERT INTO CATEGORIES VALUES (2, 'Refrigerator', 11);
    INSERT INTO CATEGORIES VALUES (5, 'Laptops', 4);
    INSERT INTO CATEGORIES VALUES (6, 'Desktops', 4);
    INSERT INTO CATEGORIES VALUES (8, 'Smartphones', 3);
    INSERT INTO CATEGORIES VALUES (9, 'Tablets', 3);
    INSERT INTO CATEGORIES VALUES (10, 'Chargers/Cables', 7);

    INSERT INTO ITEMS VALUES (0, 'LG OLED TV', 20, 1, 1, 1990000);
    INSERT INTO ITEMS VALUES (1, 'Samsung QLED TV', 15, 1, 1, 2290000);
    INSERT INTO ITEMS VALUES (2, 'LG Refrigerator', 8, 1, 2, 1850000);
    INSERT INTO ITEMS VALUES (3, 'iPad Pro', 10, 0, 9, 990000);
    INSERT INTO ITEMS VALUES (4, 'MacBook Pro', 12, 1, 5, 2990000);
    INSERT INTO ITEMS VALUES (5, 'LG Gram Laptop', 25, 0, 5, 1890000);
    INSERT INTO ITEMS VALUES (6, 'Custom Desktop PC', 7, 1, 6, 1450000);
    INSERT INTO ITEMS VALUES (7, 'Logitech Mouse', 50, 1, 7, 45000);
    INSERT INTO ITEMS VALUES (8, 'Samsung Monitor', 30, 1, 1, 279000);
    INSERT INTO ITEMS VALUES (9, 'iPad Air', 18, 1, 9, 879000);
    INSERT INTO ITEMS VALUES (10, 'Galaxy S24', 22, 1, 8, 1350000);
    INSERT INTO ITEMS VALUES (11, 'iPhone 15', 14, 1, 8, 1550000);
    INSERT INTO ITEMS VALUES (12, 'USB-C Charger', 90, 1, 10, 15000);
    INSERT INTO ITEMS VALUES (13, 'Lightning Cable', 80, 1, 10, 18000);
    INSERT INTO ITEMS VALUES (14, 'Galaxy Tab S9', 11, 1, 9, 999000);
    INSERT INTO ITEMS VALUES (15, 'Samsung Washer', 12, 1, 11, 1280000);
    INSERT INTO ITEMS VALUES (16, 'LG Dryer', 10, 1, 11, 1130000);
    INSERT INTO ITEMS VALUES (17, 'Bose Headphones', 25, 1, 7, 329000);
    INSERT INTO ITEMS VALUES (18, 'Anker Cable', 80, 1, 10, 12000);
    INSERT INTO ITEMS VALUES (19, 'MSI Gaming Laptop', 6, 1, 5, 2490000);
    INSERT INTO ITEMS VALUES (20, 'Air Purifier', 41, 1, 11, 1420000);
    INSERT INTO ITEMS VALUES (21, 'Dishwasher', 44, 1, 11, 1560000);
    INSERT INTO ITEMS VALUES (22, 'Smartwatch', 1, 1, 3, 1070000);
    INSERT INTO ITEMS VALUES (23, 'ASUS Gaming Desktop', 37, 1, 6, 1980000);
    INSERT INTO ITEMS VALUES (24, 'Samsung Desktop', 44, 1, 6, 1770000);
    INSERT INTO ITEMS VALUES (25, 'Portable SSD', 1, 1, 7, 1360000);
    INSERT INTO ITEMS VALUES (26, 'Noise Cancelling Earbuds', 16, 1, 7, 1130000);
    INSERT INTO ITEMS VALUES (27, 'Smart Lock', 15, 0, 11, 1720000);
    INSERT INTO ITEMS VALUES (28, 'Robot Vacuum', 44, 1, 11, 1630000);
    INSERT INTO ITEMS VALUES (29, 'Fitness Tracker', 46, 1, 3, 1630000);

    INSERT INTO REVIEWS VALUES (0, 0, '2025-06-12', 'Excellent TV!', 5);
    INSERT INTO REVIEWS VALUES (1, 4, '2025-07-03', 'Amazing laptop!', 5);
    INSERT INTO REVIEWS VALUES (2, 11, '2025-08-19', 'Love the iPhone.', 4);
    INSERT INTO REVIEWS VALUES (3, 2, '2025-09-10', 'Keeps things cool.', 4);
    INSERT INTO REVIEWS VALUES (3, 9, '2025-06-21', 'Good for drawing.', 4);
    INSERT INTO REVIEWS VALUES (5, 8, '2025-08-02', 'Nice monitor. But soso.', 3);
    INSERT INTO REVIEWS VALUES (6, 6, '2025-07-25', 'Powerful desktop.', 5);
    INSERT INTO REVIEWS VALUES (7, 12, '2025-07-14', 'Fast charger!', 5);
    INSERT INTO REVIEWS VALUES (8, 13, '2025-09-01', 'Works well.', 4);
    INSERT INTO REVIEWS VALUES (9, 10, '2025-07-30', 'Great phone.', 5);
    INSERT INTO REVIEWS VALUES (8, 10, '2025-12-15', 'Absolutely love it. Worth every penny!', 4);
    INSERT INTO REVIEWS VALUES (3, 15, '2025-12-25', 'Great quality but shipping was slow.', 3);
    INSERT INTO REVIEWS VALUES (9, 3, '2025-12-23', 'Very satisfied with the performance.', 5);
    INSERT INTO REVIEWS VALUES (4, 9, '2025-12-17', 'Not bad, but could be better.', 3);
    INSERT INTO REVIEWS VALUES (1, 17, '2025-11-09', 'Exceeded my expectations!', 5);
    INSERT INTO REVIEWS VALUES (0, 21, '2025-12-28', 'The design is sleek and modern.', 4);
    INSERT INTO REVIEWS VALUES (7, 6, '2025-11-19', 'Stopped working after a week...', 3);
    INSERT INTO REVIEWS VALUES (6, 13, '2025-12-01', 'Perfect for daily use!', 5);
    INSERT INTO REVIEWS VALUES (5, 19, '2025-12-26', 'Battery life is incredible.', 5);
    INSERT INTO REVIEWS VALUES (2, 4, '2025-11-08', 'Sound quality blew me away!', 5);


    INSERT INTO ORDER_ITEM_DELIVERY VALUES (0, 6, 0);   -- Order 0: LG OLED TV
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (1, 4, 1);   -- Order 1: Samsung QLED TV
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (2, 3, 4);   -- Order 2: MacBook Pro
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (3, 2, 5);   -- Order 3: LG Gram
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (4, 5, 2);   -- Order 4: LG Refrigerator
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (5, 1, 3);   -- Order 5: Samsung Washer
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (6, 0, 9);   -- Order 6: iPad Air
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (7, 7, 11);  -- Order 7: iPhone 15
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (8, 9, 12);  -- Order 8: USB-C Charger
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (9, 8, 10);  -- Order 9: Galaxy S24
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (10, 10, 15); -- Samsung Washer
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (11, 11, 19); -- MSI Gaming Laptop
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (12, 12, 16); -- LG Dryer
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (13, 13, 17); -- Bose Headphones
    INSERT INTO ORDER_ITEM_DELIVERY VALUES (14, 14, 18); -- Anker Cable

--SELECT QUERY
  --MY ORDERS
    SELECT O.OrderNo, O.OrderDate, I.ItemName, O.PriceAtOrder, O.Quantity
    FROM USERS U, ORDERS O, ORDER_ITEM_DELIVERY OID, ITEMS I
    WHERE U.UserNo = O.UserNo
      AND O.OrderNo = OID.OrderNo
      AND OID.ItemNo = I.ItemNo
      AND U.UserName = '(userName)';
    
    SELECT O.OrderNo, O.OrderDate, I.ItemName, O.PriceAtOrder, O.Quantity
    FROM USERS U, ORDERS O, ORDER_ITEM_DELIVERY OID, ITEMS I
    WHERE U.UserNo = O.UserNo
      AND O.OrderNo = OID.OrderNo
      AND OID.ItemNo = I.ItemNo
      AND U.UserName = '(userName)'
      AND O.OrderDate LIKE '(dateStr)%';
  
  --MY DELIVERIES
    SELECT OID.OrderNo, I.ItemName, D.DeliveryNo, D.Zipcode, D.DeliveryStatus, D.Carrier
    FROM DELIVERIES D, ORDER_ITEM_DELIVERY OID, Items I
    WHERE OID.OrderNo = '(orderNo)'
      AND OID.DeliveryNo = D.DeliveryNo
      AND I.ItemNo = OID.ItemNo;

  --ITEMS
    SELECT CategoryName 
    FROM CATEGORIES 
    ORDER BY CategoryNo;

    SELECT CategoryNo 
    FROM CATEGORIES 
    WHERE CategoryName = '(selectedCategory)';

    SELECT ItemNo, ItemName, ItemStock, ItemStatus, CategoryNo, ItemPrice 
    FROM ITEMS 
    WHERE CategoryNo IN '(inClause)';

  --REVIEWS
    SELECT CategoryName 
    FROM CATEGORIES 
    ORDER BY CategoryName;

    SELECT CategoryNo 
    FROM CATEGORIES 
    WHERE CategoryName = '(categoryName)';

    SELECT ItemName 
    FROM ITEMS 
    WHERE CategoryNo IN '(inClause)';

    SELECT U.UserName, I.ItemName, R.ReviewDate, R.Content, R.Rating 
    FROM USERS U, ITEMS I, REVIEWS R 
    WHERE R.UserNo = U.UserNo 
      AND R.ItemNo = I.ItemNo 
      AND I.ItemName = '(itemName)';

  --USER INFO
    SELECT * 
    FROM USERS 
    WHERE UserName = '(userName)';

  --LOW STOCK ITEMS
    SELECT * 
    FROM ITEMS 
    WHERE ItemStock <= '(threshold) '
    ORDER BY ItemStock DESC;

--INSERT QUERY
  --WRITE REVIEW
    SELECT I.ItemName
    FROM ORDERS O, ORDER_ITEM_DELIVERY OID, ITEMS I
    WHERE O.OrderNo = OID.OrderNo
      AND OID.ItemNo = I.ItemNo
      AND O.OrderNo = '(orderNo)';

    SELECT O.UserNo, OID.ItemNo
    FROM ORDERS O, ORDER_ITEM_DELIVERY OID
    WHERE O.OrderNo = OID.OrderNo
      AND O.OrderNo = '(orderNo)';

    INSERT INTO REVIEWS (UserNo, ItemNo, ReviewDate, Content, Rating)
    VALUES ('(userNo)', '(itemNo)', '(dateStr)', '(content)', '(rating)');

  --REGISTER PRODUCT
    SELECT CategoryNo, CategoryName
    FROM CATEGORIES
    ORDER BY CategoryNo;

    SELECT ISNULL(MAX(ItemNo), 0) + 1
    FROM ITEMS;

    INSERT INTO ITEMS (ItemNo, ItemName, ItemStock, ItemStatus, CategoryNo, ItemPrice)
    VALUES ('(newItemNo)', '(name)', '(stock)', '(status)', '(categoryNo)', '(price)');

  --SIGN UP
    SELECT ID 
    FROM USERS 
    WHERE ID = '(id)';

    SELECT ISNULL(MIN(UserNo + 1), 0) 
    FROM USERS 
    WHERE (UserNo + 1) NOT IN (SELECT UserNo FROM USERS);

    INSERT INTO USERS (UserNo, UserName, PhoneNo, Balance, ID, PW) 
    VALUES ((userNo), '(userName)', '(phone)', 0, '(id)', '(pw)');

  --PLACE ORDER
    SELECT ItemStock, ItemStatus 
    FROM ITEMS 
    WHERE ItemNo = '(itemNo)';

    SELECT ItemPrice 
    FROM ITEMS 
    WHERE ItemNo = '(itemNo)';

    SELECT Balance 
    FROM USERS 
    WHERE UserNo = '(userNo)';

    SELECT ISNULL(MIN(OrderNo + 1), 0) 
    FROM ORDERS 
    WHERE (OrderNo + 1) NOT IN (SELECT OrderNo FROM ORDERS);

    INSERT INTO ORDERS 
    VALUES ('(orderNo)', '(orderDate)', '(price)', '(quantity)', '(userNo)');

    SELECT ISNULL(MIN(DeliveryNo + 1), 0) 
    FROM DELIVERIES 
    WHERE (DeliveryNo + 1) NOT IN (SELECT DeliveryNo FROM DELIVERIES);

    INSERT INTO DELIVERIES 
    VALUES ('(deliveryNo)', '(zipcode)', 0, NULL);

    INSERT INTO ORDER_ITEM_DELIVERY 
    VALUES ('(orderNo)', '(deliveryNo)', '(itemNo)');

    UPDATE USERS 
    SET Balance = Balance - '(totalPrice) '
    WHERE UserNo = '(userNo)';

    UPDATE ITEMS 
    SET ItemStock = ItemStock - '(quantity) '
    WHERE ItemNo = '(itemNo)';

--DELETE QUERY
  --DELETE ACCOUNT
    DELETE 
    FROM USERS
    WHERE UserNo = '(UserNo)';

  --DELETE REVIEW
    SELECT U.UserName, I.ItemName, R.ReviewDate, R.Content, R.Rating
    FROM REVIEWS R, USERS U, ITEMS I
    WHERE R.UserNo = U.UserNo AND R.ItemNo = I.ItemNo AND R.ItemNo = '(itemNo)';

    DELETE FROM REVIEWS
    WHERE UserNo = (SELECT UserNo FROM USERS WHERE UserName = '(userName)')
      AND ItemNo = (SELECT ItemNo FROM ITEMS WHERE ItemName = '(itemName)')
      AND ReviewDate = '(date)'
      AND UserNo = '(userNo)';

  --CANCEL ORDER
    SELECT OrderDate
    FROM ORDERS
    WHERE OrderNo = '(orderNo)';

    DELETE FROM ORDERS
    WHERE OrderNo = '(orderNo)';

  --DELETE ITEM
    DELETE FROM ITEMS
    WHERE ItemNo = '(itemNo)';

--UPDATE QUERY
  --RECHARGE BALANCE
    SELECT Balance  
    FROM USERS  
    WHERE UserNo = '(userNo)';

    UPDATE USERS  
    SET Balance = '(newBalance)'  
    WHERE UserNo = '(userNo)';

  --CATGORY DISCOUNT
    SELECT CategoryNo, CategoryName  
    FROM CATEGORIES;

    UPDATE ITEMS  
    SET ItemPrice = CAST(ItemPrice * ((100.0 - '(discount)') / 100.0) AS INT)  
    WHERE CategoryNo IN (categoryNoList);  

  --EDIT ITEM INFO
    UPDATE ITEMS  
    SET ItemStock = '(stock)',  
        ItemStatus = '(status)',  
        ItemPrice = '(price)'  
    WHERE ItemNo = '(itemNo)';

  --EDIT REVIEW
    UPDATE ITEMS 
    SET ItemStock = '(stock)', ItemStatus = '(status)', ItemPrice = '(price)' 
    WHERE ItemNo = '(itemNo)';

    SELECT R.UserNo, I.ItemName, R.ItemNo, R.ReviewDate, R.Content, R.Rating
    FROM REVIEWS R, ITEMS I
    WHERE R.ItemNo = I.ItemNo 
      AND R.UserNo = '(userNo)';

    UPDATE REVIEWS 
    SET Content = '(content)', Rating = '(rating)' 
    WHERE UserNo = '(userNo)' 
      AND ItemNo = '(itemNo)' 
      AND ReviewDate = '(reviewDate)';
