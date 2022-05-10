#connection: "security_logs_next2020"
 connection: "looker-private-demo"
# "ds-demo-anomaly-detection"
# include all the views
include: "/views/**/*.view"
include: "/dashboards/*.dashboard"


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

explore: netflow_log_raw_data {
  persist_with: real_time
  always_filter: {
    filters: [netflow_log_raw_data.partition_date: "last 7 days"]
  }

  # for BigSearch filter - the below syntax applies the correct BQ syntax, but only if the filter is being used in the query
  sql_always_where:
    {% if netflow_log_raw_data.big_search_filter._in_query %}
    SEARCH(netflow_log_raw_data,"`{% parameter netflow_log_raw_data.big_search_filter %}`")
    {% else %}
    1=1
    {% endif %} ;;
}






























## Caching Data Groups

datagroup: static {
  max_cache_age: "350 hours"
  sql_trigger: select 1 ;;
}

persist_with: static

datagroup: real_time {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "8 hours"
}
