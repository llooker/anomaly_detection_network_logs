connection: "thelook_daily_updates"

# include all the views
include: "/views/**/*.view"

datagroup: anomaly_detection_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: anomaly_detection_default_datagroup

explore: cluster_model_data {
  label: "Netflow Events"
  view_label: "Netflow Events"
}

explore: outlier_data {
  view_label: "Netflow Anomalies"
  label: "Netflow Anomalies"
  join: normalized_centroid_data {
    type: left_outer
    relationship: many_to_one
    sql_on: ${outlier_data.centroid_id} = ${normalized_centroid_data.centroid_id} ;;
  }
}

explore: netflow_log_raw_data {}
