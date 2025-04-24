SELECT 
    I.ItemSKU, 
    I.Name AS Description, 
    I.Type AS MaterialCategory,
    I.SupplierID,
    S.Name AS SupplierName
FROM InventoryItem I
JOIN Supplier S ON I.SupplierID = S.SupplierID
WHERE I.Type IN ('Mulch', 'Gravel', 'Topsoil', 'Stone', 'Paver', 'Timber', 'Sand');