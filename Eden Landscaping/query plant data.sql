SELECT
    Type AS Category,
    ItemSKU,
    Name AS Description,
    Size,
    QtyAvailable
FROM InventoryItem
WHERE Type IN ('Tree', 'Shrub', 'Perennial');