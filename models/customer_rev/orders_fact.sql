{{ config(materialized='table') }}
SELECT
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD,
    O.StatusDesc,
    COUNT(DISTINCT O.OrderID) AS OrderCount,
    SUM(OI.TotalPrice) AS Revenue,
    MAX(O.Updated_at) AS Last_Update_Timestamp
FROM
    {{ ref('orders_stg') }} O
JOIN
    {{ ref('orderitems_stg') }} OI ON O.OrderID = OI.OrderID
GROUP BY
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD,
    O.StatusDesc