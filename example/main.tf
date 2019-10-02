provider "google" {
  #Add json file for authentication
  #credentials = "${file("~/gcloud-service-key.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "odp_google_monitoring" {
  source = "github.com/GSA/odp_tf_google_monitoring" 
  notification_email = "${var.notification_email}" 
  log_monitoring = [    
    {  # Alert on firewall changes
       name  = "firewall-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:\"google.appengine.v1.Firewall.\""
       resource_type = "gae_app"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nfirewall-change triggered."
    },
    {  # Alert on container analysis vulnerabilities NOT low
       name  = "container-vulnerabilitiescontainer-vulnerabilities"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName: projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access AND protoPayload.serviceName: containeranalysis.googleapis.com AND protoPayload.methodName: grafeas.v1beta1.GrafeasV1Beta1.CreateOccurrence AND NOT protoPayload.response.vulnerability.severity: INFO AND NOT protoPayload.response.vulnerability.severity: LOW"
       resource_type = "audited_resource"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - Container vunerabilities found!\n\n# Error message:\n\nVunerabilities found > than LOW in one of your containers."
    },  
    {  #CIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes
       name  = "cis2-4-project_owner-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND (protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\") AND (ProjectOwnership OR projectOwnerInvitee) OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"REMOVE\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\") OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"ADD\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\")"
       resource_type = "global"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes triggered."
    },     
    {  #CIS 2.5 Ensure log metric filter and alerts exists for Audit Configuration 
       name  = "cis2-5-audit-config-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.serviceData.policyDelta.auditConfigDeltas:*"
       resource_type = "global"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.5 Ensure log metric filter and alerts exists for Audit Configuration - has triggered."
    },   
    {  #CIS 2.6 Ensure log metric filter and alerts exists for Custom Role changes 
       name  = "cis2-6-custom-role-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"iam_role\" AND protoPayload.methodName =  \"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\""
       resource_type = "global"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.6 Ensure log metric filter and alerts exists for Custom Role changes has triggered."
    },   
    {  #CIS 2.10 - Ensure log metric filter and alerts exists for Cloud Storage IAM permission changes
       name  = "cis2-10-storage-iam-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""
       resource_type = "gcs_bucket"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.10 - Ensure log metric filter and alerts exists for Cloud Storage IAM permission changes - has triggered."
    },   
    {  #CIS 2.11 - Ensure log metric filter and alerts exists for SQL instance configuration changes
       name  = "cis2-11-sql-instance-change"
       metric_kind = "DELTA"
       value_type = "INT64"
       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName=\"cloudsql.instances.update\""
       resource_type = "cloudsql_database"
       alignment_period  = "60s"
       per_series_aligner = "ALIGN_SUM"
       duration = "60s"
       threshold_value = 0
       trigger_count = 1
       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.11 - Ensure log metric filter and alerts exists for SQL instance configuration changes - has triggered."
    }    
  ]
}