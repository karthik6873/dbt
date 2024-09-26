SELECT 
    c.CUSTOMER_ID,
    c.CUSTOMER_NAME,
    c.SEGMENT, 
    o.ORDER_ID,
    o.CUSTOMER_ID,
    o.ORDER_COST_PRICE, 
    o.ORDER_SELLING_PRICE
FROM 
    RAW.GLOBALMART.CUSTOMER c
JOIN 
    RAW.GLOBALMART.ORDERS o 
ON 
    c.CUSTOMER_ID = o.CUSTOMER_ID;

