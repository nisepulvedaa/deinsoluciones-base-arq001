curl -X POST https://us-east4-deinsoluciones-serverless.cloudfunctions.net/fn-insert-data \
  -H "Authorization: bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type: application/json" \
  -d '{
  "process_name": "process-dotacion-empleados",
  "process_fn_name": "fn-insert-data",
  "arquetype_name": "workflow-arquetipo-ingesta-connect-to-oracle"
}'

curl -X POST https://us-east4-deinsoluciones-serverless.cloudfunctions.net/fn-generate-params-dataflow \
  -H "Authorization: bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type: application/json" \
  -d '{
  "process_name": "process-dotacion-empleados",
  "process_fn_name": "fn-generate-params-dataflow",
  "arquetype_name": "workflow-arquetipo-ingesta-connect-to-oracle"
}'


gcloud dataflow flex-template run "oracle-to-parquet-job-dim-employee-2025-06-20" \
  --template-file-gcs-location="gs://dev-deinsoluciones-templates-dataflow/templates/oracle_to_parquet" \
  --region="us-east4" \
  --service-account-email="77134593518-compute@developer.gserviceaccount.com" \
  --staging-location="gs://dev-deinsoluciones-templates-dataflow/staging" \
  --temp-location="gs://dev-deinsoluciones-templates-dataflow/temp" \
  --parameters="params_file=gs://deinsoluciones-ingestas/jobs-params/dim-employee.json,connection_file=gs://deinsoluciones-global-config/db-connections/db-oracle-01.json" \
  --max-workers=10 \
  --num-workers=3 \
  --worker-machine-type=n2-standard-4 \
  --autoscaling-algorithm=THROUGHPUT_BASED

curl -X POST https://us-east4-deinsoluciones-serverless.cloudfunctions.net/fn-validacion-de-archivo-gcs \
  -H "Authorization: bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type: application/json" \
  -d '{
  "process_name": "process-dotacion-empleados",
  "process_fn_name": "fn-validacion-de-archivo-gcs",
  "arquetype_name": "workflow-arquetipo-ingesta-connect-to-oracle"
}'


curl -X POST https://us-east4-deinsoluciones-serverless.cloudfunctions.net/fn-send-email \
  -H "Authorization: bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type: application/json" \
  -d '{
  "process_name": "process-dotacion-empleados",
  "zone_name": "ORIGIN",
  "estado": "OK"
}'

curl -X POST https://us-east4-deinsoluciones-serverless.cloudfunctions.net/fn-send-email \
  -H "Authorization: bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type: application/json" \
  -d '{
  "process_name": "process-dotacion-empleados",
  "zone_name": "ORIGIN",
  "estado": "ERROR"
}'

