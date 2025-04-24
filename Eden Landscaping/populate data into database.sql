-- 2 Suppliers
INSERT INTO Supplier (Category, Name, Address1, Address2, City, State, ZIP, PhoneOrders, ContactName, ContactPhone, ShippingBillingTerms, Notes, Preferred)
VALUES
('Mulch', 'A.A. "Buck" Jones & Assoc, Inc', 'N/A', '', 'Grayson', 'GA', '34217', '770-963-8227', 'N/A', '770-963-8227', 'Net 30 days', 'Fax: 770-339-0899', 1),
('Live Stock', 'Basler Tree Farm & Nursery', '2953 Yaeger Rd', '', 'Saint Louis', 'MO', '63129', '314-487-4698', 'N/A', '314-487-4698', 'Prepay', 'No Fax', 0),
('Gravel', 'Dirt Cheap Landscape', '2900 N Highway 7', '', 'Hot Springs Village', 'AR', '71909', '501-623-5099', 'N/A', '501-623-5099', 'Net 15 days', 'Fax: 501-412-3562', 0),
('Stone', 'Garick Corporation', 'N/A', '', 'Cleveland', 'OH', '59763', '216-581-0100', 'N/A', '216-581-0100', 'Prepay', 'Fax: 216-581-4712', 0);
-- I debated removing the attributes like "ContactName" from the table since we're not going to use it, but I kept it there because in the real world, it's there just in case

-- Inventory Items
INSERT INTO InventoryItem (ItemSKU, Name, Type, Size, UnitOfMeasure, PurchasePrice, QtyAvailable, SupplierID)
VALUES
-- 8 Live Plant Stock
('TREE001', 'Red Maple', 'Tree', '6\'', 'Each', 30.00, 10, 2),
('TREE002', 'American Walnut', 'Tree', '8\'', 'Each', 35.00, 8, 2),
('SHRB001', 'Azalea "Red Bells"', 'Shrub', '2\'', 'Each', 12.00, 15, 2),
('SHRB002', 'Honeysuckle "Trumpet"', 'Shrub', '3\'', 'Each', 10.00, 20, 2),
('PER001', 'Hydrangea "Masja"', 'Perennial', '2\'', 'Each', 8.00, 25, 2),
('PER002', 'Rosa "Snowcarpet"', 'Perennial', '1.5\'', 'Each', 7.50, 30, 2),
('TREE003', 'Silver Maple', 'Tree', '10\'', 'Each', 45.00, 5, 2),
('PER003', 'Hydrangea arborescens', 'Perennial', '3\'', 'Each', 10.00, 12, 2),

-- 6 Landscaping Materials
('MULCH01', 'Pine Bark, Med.', 'Mulch', NULL, 'CubicYards', 22.00, 40, 1),
('MULCH02', 'Pine Bark, Fine', 'Mulch', NULL, 'CubicYards', 21.00, 30, 1),
('GRVL01', 'Quaker Blend', 'Gravel', NULL, 'CubicYards', 32.00, 35, 3),
('GRVL02', 'Marble Chips', 'Gravel', NULL, 'CubicYards', 33.00, 25, 3),
('STONE01', 'Keystone', 'Stone', NULL, 'Pallet', 90.00, 18, 4),
('STONE02', 'Natural Limestone', 'Stone', NULL, 'Pallet', 88.00, 15, 4);

-- 4 Customers w/ made up information
INSERT INTO Customer (FirstName, LastName, Address1, Address2, City, State, ZIP, Phone1, Phone2, ReferredBy, CustomerSince, Notes, PrefersMowing, PrefersLandscaping, PrefersOther)
VALUES
('John', 'Smith', '100 Maple St', '', 'Longmont', 'MO', '63030', '314-111-2222', '314-111-3333', 'Google', '2023-01-10', '', 1, 0, 0),
('Sara', 'Johnson', '222 Oak Ave', '', 'Longmont', 'MO', '63030', '314-444-5555', '314-666-7777', 'Referral', '2023-03-05', '', 0, 1, 0),
('Emily', 'Nguyen', '300 Elm Dr', 'Apt 4', 'Longmont', 'MO', '63030', '314-888-9999', '314-000-1111', '', '2024-02-20', '', 1, 1, 0),
('Carlos', 'Martinez', '455 Pine Rd', '', 'Longmont', 'MO', '63030', '314-222-3333', '314-444-6666', 'Instagram', '2024-01-10', '', 0, 0, 1);

-- Employees related to sales (working the register)
INSERT INTO Employee (FirstName, LastName, Role, Phone)
VALUES
('Rachel', 'Marshall', 'Office Manager', '314-555-0001'),
('Tom', 'Flynn', 'Retail Manager', '314-555-0002');

-- 4 Retail Sales Tickets
INSERT INTO Sale (CustomerID, SaleDate, SoldByEmployeeID, SaleType, DeliveryCharge, SalesTax, LandscapingRelated, SpecialInstructions)
VALUES
(1, '2024-04-01', 1, 'InStore', 0.00, 2.45, 0, 'Requested smaller bags.'),
(2, '2024-04-02', 2, 'InStore', 0.00, 3.10, 0, 'Assisted by Rachel.'),
(3, '2024-04-03', 1, 'InStore', 0.00, 4.25, 0, 'Picked up in afternoon.'),
(4, '2024-04-04', 2, 'InStore', 0.00, 3.80, 0, 'Used loyalty card.');

-- Sale Items
INSERT INTO SaleItem (SaleID, ItemSKU, Quantity, UnitPrice, EmployeeID)
VALUES
-- Ticket 1
(1, 'TREE001', 1, 55.00, 1),
(1, 'SHRB001', 2, 30.00, 1),
(1, 'MULCH01', 1, 20.00, 1),
(1, 'GRVL01', 1, 30.00, 1),

-- Ticket 2
(2, 'TREE002', 1, 40.00, 2),
(2, 'GRVL01', 2, 32.00, 2),
(2, 'STONE01', 1, 90.00, 2),
(2, 'MULCH02', 1, 21.00, 2),

-- Ticket 3
(3, 'PER001', 3, 20.00, 1),
(3, 'TREE003', 1, 45.00, 2),
(3, 'MULCH01', 2, 22.00, 1),
(3, 'STONE02', 1, 88.00, 2),

-- Ticket 4
(4, 'TREE003', 1, 50.00, 2),
(4, 'PER002', 2, 25.00, 2),
(4, 'GRVL02', 1, 33.00, 2),
(4, 'STONE01', 1, 88.00, 1);
