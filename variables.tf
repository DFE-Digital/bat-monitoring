variable paas_user {}

variable paas_password {}

variable paas_sso_code {}

variable paas_exporter_username {}

variable paas_exporter_password {}

variable grafana_admin_password {}

variable grafana_google_client_id {}

variable grafana_google_client_secret {}

variable monitoring_env {}

locals {
  paas_api_url        = "https://api.london.cloud.service.gov.uk"
  monitoring_org_name = "bat"
  space_name = {
    qa         = "qa"
    production = "prod"
    prod       = "prod"
  }
  monitoring_space_name = "bat-${local.space_name[var.monitoring_env]}"
}
