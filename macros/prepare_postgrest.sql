{% macro prepare_postgrest() %}
    run_query("create role web_anon nologin;")
    run_query("create role web_user nologin;")
    run_query("grant usage on schema gold to web_anon;")
    run_query("grant usage on schema gold to web_user;")
    run_query("grant usage on schema eduassist to web_anon;")
    run_query("grant usage on schema eduassist to web_user;")
    run_query("create role authenticator noinherit login password 'python.2024';")
    run_query("grant web_anon to authenticator;")
    run_query("grant web_user to authenticator;")
   -- grant all on all tables in schema gold to web_user;
{% endmacro %}