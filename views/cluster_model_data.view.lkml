view: cluster_model_data {
  sql_table_name: `anomaly_detection.cluster_model_data`
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
      year
    ]
    sql: CAST(${TABLE}.transaction_time AS TIMESTAMP) ;;
    convert_tz: no
  }

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

  dimension: is_anomaly {
    type: yesno
    sql: CASE WHEN ${dst_subnet} = '12.0.1.3/22' AND ${avg_rx_bytes} >= 40000 AND ${avg_tx_bytes} >= 150000 THEN TRUE
              WHEN ${subscriber_id} = 'IMSI_TOKEN(64):AcZD2U2v//QiKkGzbFCm29pv5cqVi3Db09Z6CNt5cQSevBKRQvgdDfacPQIRY1dc' THEN TRUE
              ELSE FALSE END ;;
  }

  measure: average_rx_bytes {
    type: average
    sql: ${avg_rx_bytes} ;;
  }

  measure: average_tx_bytes {
    type: average
    sql: ${avg_tx_bytes} ;;
  }

  measure: count {
    label: "Event Count"
    type: count
    drill_fields: []
  }

  measure: anomaly_count {
    type: count
    filters: [is_anomaly: "Yes" ]
  }



}
