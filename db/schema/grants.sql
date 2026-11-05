create role inspector
with
  login password 'NetoSQL2025';

grant all privileges on schema golubev_food to inspector;
grant usage on schema exts to inspector;
grant usage on schema information_schema to inspector;
grant usage on schema pg_catalog to inspector;
grant all privileges on all tables in schema golubev_food to inspector;
grant all privileges on all sequences in schema golubev_food to inspector;

grant
execute on all functions in schema golubev_food to inspector;

alter default privileges in schema golubev_food
grant all privileges on tables to inspector;

alter default privileges in schema golubev_food
grant all privileges on sequences to inspector;

alter default privileges in schema golubev_food
grant
execute on functions to inspector;