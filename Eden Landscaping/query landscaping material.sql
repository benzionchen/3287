SELECT
    Type AS MaterialCategory,
    ItemSKU,
    Name AS Description,
    UnitOfMeasure,
    QtyAvailable
FROM InventoryItem
WHERE Type IN ('Mulch', 'Gravel', 'Topsoil', 'Stone', 'Paver', 'Timber', 'Sand');