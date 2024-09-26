{{ config(materialized='table') }}

SELECT *
FROM {{ ref('card_details') }}
WHERE _fivetran_deleted = false