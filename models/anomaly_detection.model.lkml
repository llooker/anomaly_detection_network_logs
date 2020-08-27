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

#   join: source_geolite_city_bq_b2b {
#     view_label: "IP Info - Source"
#     from: geolite_city_bq_b2b
#     type: left_outer
#     relationship: many_to_one
#     # TO-DO is that relationship/join logic right?
#     sql_on: ${source_geolite_city_bq_b2b.class_b} = ${network.source_class_b}
#       AND ${network.source_client_ip_num} BETWEEN ${source_geolite_city_bq_b2b.start_ip_num} and ${source_geolite_city_bq_b2b.end_ip_num};;
#   }
#   join: destination_geolite_city_bq_b2b {
#     view_label: "IP Info - Destination"
#     from: geolite_city_bq_b2b
#     type: left_outer
#     relationship: many_to_one
#     # TO-DO is that relationship/join logic right?
#     sql_on: ${destination_geolite_city_bq_b2b.class_b} = ${network.destination_class_b}
#       AND ${network.destination_client_ip_num} BETWEEN ${destination_geolite_city_bq_b2b.start_ip_num} and ${destination_geolite_city_bq_b2b.end_ip_num};;
#   }

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

explore: netflow_log_raw_data {

#  join: src_ip_geo {
#   from: ip_to_geography_lookup
#     sql_on:
#     NET.IPV4_TO_INT64(NET.SAFE_IP_FROM_STRING(${netflow_log_raw_data.src_ip}))
#     BETWEEN ${src_ip_geo.start_ipv4_to_int64} AND  ${src_ip_geo.end_ipv4_int64};;
#     relationship: many_to_one
#     type: inner
#   }
}


datagroup: ip_lookup {
  max_cache_age: "350 hours"
  sql_trigger: select 1 ;;
}
