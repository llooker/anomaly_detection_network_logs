view: normalized_centroid_data {
  #sql_table_name: `network_logs.normalized_centroid_data`    ;;
  sql_table_name: `anomaly_detection.normalized_centroid_data`    ;;

  dimension: avg_duration {
    type: number
    sql: ${TABLE}.avg_duration ;;
  }

  dimension: avg_rx_bytes {
    label: "Avg Rx Bytes - Cluster"
    type: number
    sql: ${TABLE}.avg_rx_bytes ;;
  }

  dimension: avg_tx_bytes {
    label: "Avg Tx Bytes - Cluster"
    type: number
    sql: ${TABLE}.avg_tx_bytes ;;
  }

  dimension: centroid_id {
    type: number
    sql: ${TABLE}.centroid_id ;;
  }

  dimension: max_duration {
    type: number
    sql: ${TABLE}.max_duration ;;
  }

  dimension: max_rx_bytes {
    type: number
    sql: ${TABLE}.max_rx_bytes ;;
  }

  dimension: max_tx_bytes {
    type: number
    sql: ${TABLE}.max_tx_bytes ;;
  }

  dimension: min_duration {
    type: number
    sql: ${TABLE}.min_duration ;;
  }

  dimension: min_rx_bytes {
    type: number
    sql: ${TABLE}.min_rx_bytes ;;
  }

  dimension: min_tx_bytes {
    type: number
    sql: ${TABLE}.min_tx_bytes ;;
  }

  dimension: normalized_dest {
    type: number
    sql: ${TABLE}.normalized_dest ;;
  }

  dimension: number_of_records {
    type: number
    sql: ${TABLE}.number_of_records ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
