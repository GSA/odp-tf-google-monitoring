# Configure monitoring notification channel for email.

resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  type = "email"
  labels = {
    email_address = "${var.notification_email}"
  }
}

#Configure the log metric
resource "google_logging_metric" "log_metrics" {
  count = "${length(var.log_monitoring)}"
  name = "${lookup(var.log_monitoring[count.index], "name")}"
  filter = "${lookup(var.log_monitoring[count.index], "metric_filter")}"
  metric_descriptor {
    metric_kind = "${lookup(var.log_monitoring[count.index], "metric_kind")}"
    value_type = "${lookup(var.log_monitoring[count.index], "value_type")}"
  }
}

#Configure the alert policy for the log metric
resource "google_monitoring_alert_policy" "alert_policies"{
  count = "${length(var.log_monitoring)}"
  display_name = "${lookup(var.log_monitoring[count.index], "name")}"
  combiner= "OR"
  conditions {
      display_name = "${lookup(var.log_monitoring[count.index], "name")}"
      condition_threshold {
        aggregations {
          alignment_period = "${lookup(var.log_monitoring[count.index], "alignment_period")}"
          per_series_aligner = "${lookup(var.log_monitoring[count.index], "per_series_aligner")}"
        }
        comparison = "COMPARISON_GT"
        duration = "${lookup(var.log_monitoring[count.index], "duration")}"
        filter = "metric.type=\"logging.googleapis.com/user/${element(google_logging_metric.log_metrics.*.name, count.index) }\" AND resource.type=\"${lookup(var.log_monitoring[count.index], "resource_type")}\""
        threshold_value = "${lookup(var.log_monitoring[count.index], "threshold_value")}"
        trigger {
          count = "${lookup(var.log_monitoring[count.index], "trigger_count")}"
        }
      }
  }
  notification_channels = [ "${google_monitoring_notification_channel.email.name}" ]  
  documentation {
    content = "${lookup(var.log_monitoring[count.index], "content")}"
    mime_type = "text/markdown"
  }
}

