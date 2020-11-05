view: cluster_model_data {
  sql_table_name: `network_logs.cluster_model_data`    ;;
  # `anomaly_detection.cluster_model_data`

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
#     link: {
#       label: "{{ value }} Lookup"
#       icon_url: "https://www.looker.com/favicon.ico"
#       url: "/dashboards/606?Subnet={{ value | encode_uri }}"
#     }
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
      time,
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

  dimension: is_nefarious_subscriber_id {
    group_label: "Risk Factors"
    hidden: yes
    type: yesno
    sql: ${subscriber_id} in ('IMSI_TOKEN(64):AcZD2U2v//QiKkGzbFCm29pv5cqVi3Db09Z6CNt5cQSevBKRQvgdDfacPQIRY1dc',
                              'IMSI_TOKEN(48):AWyeZR8BCphFmlZ1Ht1Y5FnHRgOozmfBdfE6/Cq8u5is3g==',
                              '00000000000000000') ;;
  }

  dimension: is_not_nefarious_subscriber_id {
    group_label: "Risk Factors"
    type: yesno
    hidden: yes
    sql: ${subscriber_id} not in ('IMSI_TOKEN(64):AcZD2U2v//QiKkGzbFCm29pv5cqVi3Db09Z6CNt5cQSevBKRQvgdDfacPQIRY1dc',
                              'IMSI_TOKEN(48):AWyeZR8BCphFmlZ1Ht1Y5FnHRgOozmfBdfE6/Cq8u5is3g==',
                              '00000000000000000') ;;
  }

  dimension: is_nefarious_subnet {
    group_label: "Risk Factors"
    hidden: yes
    type: yesno
    sql: ${dst_subnet} in ('12.0.1.3/22');;
  }

  dimension: is_not_nefarious_subnet {
    hidden: yes
    group_label: "Risk Factors"
    type: yesno
    sql: ${dst_subnet} not in ('12.0.1.3/22');;
  }

  dimension: is_large_file_sent {
    group_label: "Anomaly Factors"
    type: yesno
    sql: ${avg_tx_bytes} > 100000 ;;
  }

  dimension: is_not_large_file_sent {
    group_label: "Risk Factors"
    hidden: yes
    type: yesno
    sql: ${avg_tx_bytes} <= 100000 ;;
  }

  dimension: is_large_file_received {
    group_label: "Anomaly Factors"
    type: yesno
    sql: ${avg_rx_bytes} > 30000 ;;
  }

  dimension: is_not_large_file_received {
    group_label: "Risk Factors"
    hidden: yes
    type: yesno
    sql: ${avg_rx_bytes} <= 30000 ;;
  }

  dimension: has_1_risk_factor {
    hidden: yes
    type: yesno
    sql:
         ( ${is_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_not_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_not_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_not_large_file_received} and ${is_large_file_sent} )
      ;;
  }

  measure: events_1_risk_factor  {
    hidden: yes
    type: count
    filters: [has_1_risk_factor: "yes"]
  }

  dimension: has_2_risk_factor {
    hidden: yes
    type: yesno
    sql:
         ( ${is_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_not_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_not_large_file_received} and ${is_large_file_sent} )

    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_not_large_file_received} and ${is_large_file_sent} )

    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_large_file_received} and ${is_large_file_sent} )
      ;;
  }

  measure: events_2_risk_factor  {
    hidden: yes
    type: count
    filters: [has_2_risk_factor: "yes"]
  }

  dimension: has_3_risk_factor {
    hidden: yes
    type: yesno
    sql:
         ( ${is_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_large_file_received} and ${is_not_large_file_sent} )
    OR   ( ${is_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_not_large_file_received} and ${is_large_file_sent} )
    OR   ( ${is_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_large_file_received} and ${is_large_file_sent} )
    OR   ( ${is_not_nefarious_subscriber_id} AND ${is_not_nefarious_subnet} AND ${is_large_file_received} and ${is_large_file_sent} )
      ;;
  }

  measure: events_3_risk_factor  {
    hidden: yes
    type: count
    filters: [has_3_risk_factor: "yes"]
  }

  dimension: has_4_risk_factor {
    hidden: yes
    type: yesno
    sql:
         ( ${is_nefarious_subscriber_id} AND ${is_nefarious_subnet} AND ${is_large_file_received} and ${is_large_file_sent} )      ;;
  }

  measure: events_4_risk_factor  {
    hidden: yes
    type: count
    filters: [has_4_risk_factor: "yes"]
  }

  measure: total_rx_bytes {
    type: sum
    sql: ${avg_rx_bytes} ;;
  }

  measure: rx_bytes_75 {
    hidden: yes
    type: percentile
    sql: ${avg_rx_bytes} ;;
    percentile: 75
  }

  measure: total_tx_bytes {
    type: sum
    sql: ${avg_tx_bytes} ;;
  }

  measure: tx_bytes_75 {
    hidden: yes
    type: percentile
    sql: ${avg_tx_bytes} ;;
    percentile: 75
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
