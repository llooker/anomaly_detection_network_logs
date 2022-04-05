view: netflow_log_raw_data {
  sql_table_name: `looker-private-demo.anomaly_detection.netflow_log_raw_data` ;;
  #sql_table_name: `demoanalyticsds.netflow_log_data`;;

  parameter: big_search_filter {
    suggestable: no
    type: unquoted
  }

  # filter: big_search_filter  {
  #   suggestable: no
  #   sql: SEARCH(netflow_log_raw_data,"{% parameter big_search_filter %}")  ;;
  #   #SEARCH(netflow_log_raw_data, "12.0.9.4")
  # }

  dimension_group: partition {
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
    sql: CAST(${TABLE}._PARTITIONTIME AS TIMESTAMP) ;;
  }

  dimension: dst_ip {
    label: "Destination IP"
    type: string
    sql: ${TABLE}.dstIP ;;
    html:  {% if value == big_search_filter._parameter_value %}
    <b><p style="color: black; background-color: #FBBC04; font-size:100%">{{ value }}</b></p>
    {% else %}
    {{ value }}
    {% endif %};;
  }

  dimension: dst_port {
    label: "Destination Port"
    type: number
    sql: ${TABLE}.dstPort ;;
    value_format_name: id
    # BigSearch HTML formatting
    html:
    {% if value == big_search_filter._parameter_value %}
    <b><p style="color: black; background-color: #FBBC04; font-size:100%">{{ value }}</b></p>
    {% else %}
    {{ value }}
    {% endif %};;
  }

  dimension_group: end_time {
    label: "Connection End"
    type: time
    timeframes: [raw, date, time]
    sql: TIMESTAMP_MILLIS(cast(${TABLE}.endTime AS INT64))  ;;
  }

  dimension: protocol_name {
    label: "Protocol Type"
    type: string
    sql: UPPER(${TABLE}.protocolName) ;;
  }

  dimension: protocol_number {
    hidden: yes
    type: number
    sql: ${TABLE}.protocolNumber ;;
  }

  dimension: bytes_received {
    type: number
    sql: ${TABLE}.rxBytes ;;
  }

  dimension: src_ip {
    label: "Source IP"
    type: string
    sql: ${TABLE}.srcIP ;;
    # BigSearch HTML formatting
    html:
    {% if value == big_search_filter._parameter_value %}
    <b><p style="color: black; background-color: #FBBC04; font-size:100%">{{ value }}</b></p>
    {% else %}
    {{ value }}
    {% endif %};;
  }

  dimension: src_port {
    label: "Source Port"
    type: number
    sql: ${TABLE}.srcPort ;;
    value_format_name: id
    # BigSearch HTML formatting
    html:
    {% if value == big_search_filter._parameter_value %}
    <b><p style="color: black; background-color: #FBBC04; font-size:100%">{{ value }}</b></p>
    {% else %}
    {{ value }}
    {% endif %};;
  }

  dimension_group: start_time {
    label: "Connection Start"
    type: time
    timeframes: [raw, date, time, hour_of_day, hour, minute15, hour6]
    sql: TIMESTAMP_MILLIS(cast(${TABLE}.startTime  AS INT64))  ;;
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

  ### geography

  dimension: geo_city {
    view_label: "Geography"
    type: string
    sql: ${TABLE}.geoCity ;;
  }

  dimension: geo_country {
    view_label: "Geography"
    type: string
    sql: ${TABLE}.geoCountry ;;
  }

  dimension: is_risky_country {
    view_label: "Geography"
    type: yesno
    sql: ${geo_country} IN ('Russia', 'China', 'North Korea', 'Iran') ;;
  }

  dimension: latitude {
    # hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    # hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: geo_location_detail {
    view_label: "Geography"
    type: location
    sql_latitude: ${latitude};;
    sql_longitude: ${longitude} ;;
  }

  dimension: geo_location {
    view_label: "Geography"
    type: location
    sql_latitude: round(${latitude},0) ;;
    sql_longitude: round(${longitude},0) ;;
  }

  measure: count {
    label: "Event Count"
    type: count
    drill_fields: [partition_time, geo_country, src_ip, src_port, dst_ip, dst_port, bytes_transferred]
  }
}
