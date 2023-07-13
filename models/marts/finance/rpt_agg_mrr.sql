--- models/finance/agg_mrr.sql
{% set import_revenue = unit_testing_select_table(ref('rpt_mrr'), ref('unit_test_input_mrr')) %} -- This calls the macro we just wrote above, and returns our original source table, or our mock dataset, depending on the value of the unit_testing variable during dbt run


SELECT
    date_month,
    SUM(mrr_amount) AS mrr,
    {{ dbt_utils.generate_surrogate_key(['date_month', 'mrr']) }} AS surrogate_key
FROM
    {{ import_revenue }} -- We add the Jinja variable here to replace the ref function
GROUP BY 1
