{% macro categorize_range(column_name, short_limit =2, medium_limit =5) %}

CASE
WHEN {{column_name}} is null then 'Unknown'
when {{column_name}} <= {{short_limit}} then 'Short'
when {{column_name}} <= {{medium_limit}} then 'medium'
ELSE 'Long'

END
{% endmacro %}
