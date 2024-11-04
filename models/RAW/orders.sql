{{
    config(
        materialized='table'
    )
}}

SELECT 
    *
FROM
    {{ source('globalmarts', 'orders') }}