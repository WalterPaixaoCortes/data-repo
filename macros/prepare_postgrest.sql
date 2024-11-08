{% macro prepare_postgrest() %}
    create role web_anon nologin;
    create role web_user nologin;
    grant usage on schema gold to web_anon;
    grant usage on schema gold to web_user;
    create role authenticator noinherit login password 'python.2024';
    grant web_anon to authenticator;
    grant web_user to authenticator;
   -- grant all on all tables in schema gold to web_user;
{% endmacro %}