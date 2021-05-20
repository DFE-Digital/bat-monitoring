monitoring_space_name    = "bat-prod"
monitoring_instance_name = "bat"
influxdb_service_plan    = "small-1_x"
alertmanager_app_names   = ["find-prod", "find-staging", "publish-teacher-training-prod", "publish-teacher-training-staging", "teacher-training-api-prod", "teacher-training-api-staging", "register-production", "register-staging", "apply-staging", "apply-prod"]
postgres_services        = ["apply-postgres-prod", "apply-postgres-prod-backup", "apply-postgres-sandbox", "register-postgres-production", "register-postgres-sandbox", "teacher-training-api-postgres-prod", "teacher-training-api-postgres-sandbox"]
