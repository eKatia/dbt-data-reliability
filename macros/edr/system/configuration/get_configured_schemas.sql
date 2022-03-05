{% macro get_configured_schemas() %}

    {% set configured_schemas_query %}

        with monitoring_configuration as (
            select {{ elementary.full_schema_name() }} as full_schema_name
            from {{ elementary.get_source_path('table_monitors_config') }}
            where database_name is not null and schema_name is not null
            group by 1
        )
        select full_schema_name
        from monitoring_configuration

    {% endset %}

    {% set configured_schemas = elementary.result_column_to_list(configured_schemas_query) %}
    {{ return(configured_schemas | list) }}

{% endmacro %}