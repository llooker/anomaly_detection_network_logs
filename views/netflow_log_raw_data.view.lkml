view: netflow_log_raw_data {
  sql_table_name: `looker-private-demo.anomaly_detection.netflow_log_raw_data`
    ;;

  dimension_group: event {
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
      year
    ]
    sql: CAST(${TABLE}._PARTITIONTIME AS TIMESTAMP) ;;
    convert_tz: no
    # NOTE: for manually partitioned files use code below
    # sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d'))) ;;
  }

  dimension: dst_ip {
    label: "Destination IP"
    type: string
    sql: ${TABLE}.dstIP ;;
  }

  dimension: dst_port {
    label: "Destination Port"
    type: number
    sql: ${TABLE}.dstPort ;;
  }

  dimension: end_time {
    type: number
    sql: ${TABLE}.endTime ;;
  }

  dimension: protocol_name {
    type: string
    sql: ${TABLE}.protocolName ;;
  }

  dimension: protocol_number {
    type: number
    sql: ${TABLE}.protocolNumber ;;
  }

  dimension: bytes_received {
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

  dimension: bytes_transferred {
    type: number
    sql: ${TABLE}.txBytes ;;
  }

  measure: count {
    type: count
    drill_fields: [protocol_name]
  }
}
