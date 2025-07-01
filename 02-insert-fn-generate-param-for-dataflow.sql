INSERT INTO `dev_config_zone.process_params` (
    process_name,
    process_fn_name,
    params,
    arquetype_name,
    active
) VALUES (
    'process-{{nombre_proceso}}',
    'fn-generate-params-dataflow',
    JSON '''
    [
        {"query": "{{query}}","output_path": "{{buckets_path_name}}{{buckets_file_name}}", "file_name": "{{file_json_name}}"}
    ]
    ''',
    'workflow-arquetipo-ingesta-connect-to-oracle',
    TRUE
);

----
SELECT
    process_name,
    process_fn_name, 
    params, 
    arquetype_name,
    active
FROM dev_config_zone.process_params
WHERE process_name = 'process-{{nombre_proceso}}'
AND process_fn_name = 'fn-generate-param-for-dataflow'
AND arquetype_name = 'workflow-arquetipo-ingesta-connect-to-oracl';