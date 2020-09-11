view: netflow_log_raw_data_new {
  sql_table_name: `next-demo-2020.network_logs.netflow_log_raw_data_new`
    ;;

  dimension: dst_ip {
    type: string
    sql: ${TABLE}.dstIP ;;
  }

  dimension: dst_port {
    type: number
    sql: ${TABLE}.dstPort ;;
  }

  dimension: end_time {
    type: number
    sql: ${TABLE}.endTime ;;
  }

  dimension: geo_city {
    type: string
    sql: ${TABLE}.geoCity ;;
  }

  dimension: geo_country {
    type: string
    sql: ${TABLE}.geoCountry ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: protocol_name {
    type: string
    sql: ${TABLE}.protocolName ;;
  }

  dimension: protocol_number {
    type: number
    sql: ${TABLE}.protocolNumber ;;
  }

  dimension: rx_bytes {
    type: number
    sql: ${TABLE}.rxBytes ;;
  }

  dimension: src_ip {
    type: string
    sql: ${TABLE}.srcIP ;;
  }

  dimension: src_port {
    type: number
    sql: ${TABLE}.srcPort ;;
  }

  dimension: start_time {
    type: number
    sql: ${TABLE}.startTime ;;
  }

  dimension: subscriber_id {
    type: string
    sql: ${TABLE}.subscriberId ;;
  }

  dimension: tcp_flag {
    type: number
    sql: ${TABLE}.tcpFlag ;;
  }

  dimension: tx_bytes {
    type: number
    sql: ${TABLE}.txBytes ;;
  }

  measure: count {
    type: count
    drill_fields: [protocol_name]
  }
}
