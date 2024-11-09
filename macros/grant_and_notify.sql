{% macro grant_and_notify(table_name) %}
      grant select on {{table_name}} to web_anon; 
      grant all on {{table_name}} to web_user; 
      NOTIFY pgrst, 'reload schema';
{% endmacro%}