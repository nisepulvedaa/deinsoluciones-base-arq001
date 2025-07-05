nombre_proceso="dotacion-empleados" #nombre-proceso
periodicidad="diario"# diario|mensual|esporadico
buckets_path_name="gs://dev-deinsoluciones-ingestas/origin-files/" # 
buckets_file_name="dotacion-empleados.parquet" 
query="SELECT  EMPLOYEENATIONALIDALTERNATEKEY AS identificador ,UPPER(FIRSTNAME) AS nombre ,UPPER(LASTNAME)  AS apellido ,UPPER(TITLE)     AS cargo ,EMAILADDRESS  AS email ,LOGINID   AS cuenta_organizacional,PHONE AS telefono ,GENDER  AS genero ,UPPER(DEPARTMENTNAME)  AS departament FROM ADVENTUREWORKS.DIM_EMPLOYEE ORDER BY FIRSTNAME ASC"
correos_destinatarios="ni.sepulvedaa@gmail.com"
file_json_name="dotacion-empleados.json"