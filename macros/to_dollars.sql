{% macro to_dollars(column_name, decimal_places=2) %}
    {# 
        Reusable currency macro:
        1. COALESCE protects against NULLs
        2. Casts to DECIMAL(18, 4) for financial precision
        3. Rounds to the desired decimal places (defaults to 2)
    #}
    ROUND(CAST(COALESCE({{ column_name }}, 0) AS DECIMAL(18, 4)), {{ decimal_places }})
{% endmacro %}

  