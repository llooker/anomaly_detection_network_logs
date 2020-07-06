connection: "thelook_daily_updates"

# include all the views
include: "/views/**/*.view"

datagroup: anomaly_detection_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: anomaly_detection_default_datagroup

explore: cluster_model_data {}

explore: outlier_data {
  join: normalized_centroid_data {
    type: left_outer
    relationship: many_to_one
    sql_on: ${outlier_data.centroid_id} = ${normalized_centroid_data.centroid_id} ;;
  }
}
