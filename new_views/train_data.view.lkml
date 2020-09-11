view: train_data {
  sql_table_name: `next-demo-2020.network_logs.train_data`
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

  dimension: transaction_time {
    type: string
    sql: ${TABLE}.transaction_time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
