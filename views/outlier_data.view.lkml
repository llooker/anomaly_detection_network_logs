view: outlier_data {
  sql_table_name: `anomaly_detection.outlier_data`
    ;;

  dimension: avg_duration {
    type: number
    sql: ${TABLE}.avg_duration ;;
  }

  dimension: avg_rx_bytes {
    type: number
    sql: ${TABLE}.avg_rx_bytes ;;
  }

  dimension: avg_tx_bytes {
    type: number
    sql: ${TABLE}.avg_tx_bytes ;;
  }

  dimension: centroid_id {
    type: number
    sql: ${TABLE}.centroid_id ;;
  }

  dimension: dst_subnet {
    type: string
    sql: ${TABLE}.dst_subnet ;;
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

  dimension: number_of_records {
    type: number
    sql: ${TABLE}.number_of_records ;;
  }

  dimension: number_of_unique_ips {
    type: number
    sql: ${TABLE}.number_of_unique_ips ;;
  }

  dimension: number_of_unique_ports {
    type: number
    sql: ${TABLE}.number_of_unique_ports ;;
  }

  dimension: subscriber_id {
    type: string
    sql: ${TABLE}.subscriber_id ;;
  }

  dimension_group: transaction_time {
    type: time
    timeframes: [
      raw,
      second,
      minute,
      hour,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year,
      time_of_day,
      time
    ]
    sql: CAST(${TABLE}.transaction_time AS TIMESTAMP) ;;
    convert_tz: no
  }

#   measure: most_recent_outlier_time {
#     type: date_second
#     sql: MAX(${transaction_time_raw}) ;;
#   }

  measure: most_recent_outlier_date {
    type: date_second
    sql: MAX(${transaction_time_raw}) ;;
    convert_tz: no
    html: <body style="font-size:12px"><p>Your most recent <br>outlier occurred on<br><span style="color:DarkRed;font-weight:bold"> {{rendered_value | date: "%b %d, %Y" }}</span> <br>at <span style="color:DarkRed;font-weight:bold">{{rendered_value | date: "%T" }}</span>  </p></body> ;;
  }

  dimension: avg_rx_bytes_diff {
    label: "Rx Differece from Centroid Avg"
    type: number
    sql: ${avg_rx_bytes} - ${normalized_centroid_data.avg_rx_bytes} ;;
  }

  dimension: avg_tx_bytes_diff {
    label: "Tx Difference from Centroid Avg"
    type: number
    sql: ${avg_tx_bytes} - ${normalized_centroid_data.avg_tx_bytes} ;;
  }

  dimension: update_actions {
    group_label: "Actions"
    description: "Various actions you can take on outliers"
    sql: "Actions..." ;;
    action: {
      label: "Created Jira Ticket"
      icon_url: "https://cdn.worldvectorlogo.com/logos/jira-1.svg"
      url: "https://36eb5f27-30ab-4245-a28b-b08945733c96.trayapp.io"
    }
  }

  measure: count {
    type: count
    drill_fields: [transaction_time_second, normalized_centroid_data.centroid_id, dst_subnet, avg_rx_bytes, normalized_centroid_data.avg_rx_bytes, avg_tx_bytes, normalized_centroid_data.avg_tx_bytes, update_actions]
  }
}
