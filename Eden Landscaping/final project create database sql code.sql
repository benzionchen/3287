-- DROP existing tables to start fresh
DROP TABLE IF EXISTS OrderLog;
DROP TABLE IF EXISTS SaleItem;
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS InventoryItem;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee;

-- Employee table: for sales handling
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(50),
    Phone VARCHAR(15)
);

-- Supplier table: who provides inventory
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(50),
    Name VARCHAR(100),
    Address1 VARCHAR(100),
    Address2 VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(20),
    ZIP VARCHAR(10),
    PhoneOrders VARCHAR(20),
    ContactName VARCHAR(50),
    ContactPhone VARCHAR(20),
    ShippingBillingTerms TEXT,
    Notes TEXT,
    Preferred TINYINT(1)
);

-- Inventory item table: plants/materials being stocked and sold
CREATE TABLE InventoryItem (
    ItemSKU VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Type ENUM(
        'Tree', 'Shrub', 'Perennial',
        'Mulch', 'Gravel', 'Topsoil',
        'Stone', 'Paver', 'Timber', 'Sand'
    ),
    Size VARCHAR(50),
    UnitOfMeasure ENUM('Each', 'CubicYards', 'Pallet'),
    PurchasePrice DECIMAL(10,2),
    QtyAvailable INT,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address1 VARCHAR(100),
    Address2 VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(20),
    ZIP VARCHAR(10),
    Phone1 VARCHAR(15),
    Phone2 VARCHAR(15),
    ReferredBy VARCHAR(50),
    CustomerSince DATE,
    Notes TEXT,
    PrefersMowing TINYINT(1),
    PrefersLandscaping TINYINT(1),
    PrefersOther TINYINT(1)
);

-- Sale table: records of all transactions
CREATE TABLE Sale (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    SaleDate DATE,
    SoldByEmployeeID INT,
    SaleType ENUM('InStore', 'Delivery', 'Landscaping'),
    DeliveryCharge DECIMAL(10,2),
    SalesTax DECIMAL(10,2),
    LandscapingRelated TINYINT(1),
    SpecialInstructions TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SoldByEmployeeID) REFERENCES Employee(EmployeeID)
);

-- SaleItem table: details of items sold in each Sale
CREATE TABLE SaleItem (
    SaleItemID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT,
    ItemSKU VARCHAR(20),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    EmployeeID INT,
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
    FOREIGN KEY (ItemSKU) REFERENCES InventoryItem(ItemSKU),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- OrderLog table: adds inventory by recording supplier shipments
CREATE TABLE OrderLog (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    SupplierID INT,
    ConfirmationNumber VARCHAR(50),
    ItemSKU VARCHAR(20),
    Quantity INT,
    Price DECIMAL(10,2),
    ExtendedPrice DECIMAL(10,2),
    Taxes DECIMAL(10,2),
    Shipping DECIMAL(10,2),
    Total DECIMAL(10,2),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ItemSKU) REFERENCES InventoryItem(ItemSKU)
);
