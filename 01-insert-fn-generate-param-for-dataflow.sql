--SFTP
INSERT INTO `dev_config_zone.process_params` (
    process_name,
    process_fn_name,
    params,
    arquetype_name,
    active
) VALUES (
    'process-{{nombre_proceso}}',
    'fn-generate-param-for-dataflow',
    JSON '''
    [
        {"query": "SELECT  EMPLOYEENATIONALIDALTERNATEKEY AS identificador ,UPPER(FIRSTNAME) AS nombre ,UPPER(LASTNAME)  AS apellido ,UPPER(TITLE)     AS cargo ,EMAILADDRESS  AS email ,LOGINID   AS cuenta_organizacional,PHONE AS telefono ,GENDER  AS genero ,UPPER(DEPARTMENTNAME)  AS departament FROM ADVENTUREWORKS.DIM_EMPLOYEE ORDER BY FIRSTNAME ASC","output_path": "gs://dev-deinsoluciones-ingestas/origin-files/dotacion-empleados.parquet"}
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