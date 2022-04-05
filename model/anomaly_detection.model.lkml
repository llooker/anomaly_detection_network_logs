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
}

explore: big_search {
  from: netflow_log_raw_data
  always_filter: {
    filters: [big_search.partition_date: "last 7 days"]
    filters: [big_search.big_search_filter: ""]
  }
  sql_always_where: SEARCH(big_search,"`{% parameter big_search.big_search_filter %}`")  ;;
  #BigSearch uses the above syntax to enable searching all the columns in a table
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
