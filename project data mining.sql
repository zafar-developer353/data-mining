use retail_shop;
select * from online_retail;
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency,
       CASE 
           WHEN COUNT(DISTINCT InvoiceNo) >= 5 THEN 'High Frequency'
           WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 2 AND 4 THEN 'Medium Frequency'
           ELSE 'Low Frequency'
       END AS CustomerSegment
FROM online_retail
GROUP BY CustomerID
ORDER BY PurchaseFrequency DESC;
SELECT Country, AVG(Quantity * UnitPrice) AS AverageOrderValue
FROM online_retail
GROUP BY Country
ORDER BY AverageOrderValue DESC;
SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING MAX(InvoiceDate) < DATE_SUB(CURDATE(), INTERVAL 6 month);
SELECT ProductA.StockCode AS ProductA, ProductB.StockCode AS ProductB, 
       COUNT(*) AS CoPurchases
FROM online_retail AS ProductA
JOIN online_retail AS ProductB ON ProductA.InvoiceNo = ProductB.InvoiceNo
       AND ProductA.StockCode < ProductB.StockCode
GROUP BY ProductA.StockCode, ProductB.StockCode
ORDER BY CoPurchases DESC;
SELECT DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'), '%m/%Y') AS Month, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
WHERE InvoiceDate IS NOT NULL
GROUP BY DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'), '%m/%Y')
ORDER BY Month;