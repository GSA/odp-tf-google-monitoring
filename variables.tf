

variable "notification_email" {
  type = "string"
}


variable "log_monitoring" {
  description = "Configures log monitoring"
  default = [    
#Example configuration    
#    {  #CIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes
#       name  = "cis2-4-project_owner-change"
#       metric_kind = "DELTA"
#       value_type = "INT64"
#       metric_filter = "logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND (protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\") AND (ProjectOwnership OR projectOwnerInvitee) OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"REMOVE\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\") OR (protoPayload.serviceData.policyDelta.bindingDeltas.action=\"ADD\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\")"
#       resource_type = "global"
#       aligment_period = "60s"
#       per_series_aligner = "ALIGN_SUM"
#       duration = "60s"
#       threshold_value = 0
#       trigger_count = 1
#       content = "# Warning - CIS Alert Triggered\n\n# Error message:\n\nCIS 2.4 Ensure log metric filter and alerts exists for Project Ownership assignments/changes triggered."
#    } 
  ]
}
