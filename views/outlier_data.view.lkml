view: outlier_data {
  sql_table_name: `looker-private-demo.anomaly_detection.outlier_data` ;;
  #sql_table_name: `network_logs.outlier_data_new`;;
  #sql_table_name: `demoanalyticsds.outlier_data` ;;

  dimension: avg_duration {
    type: number
    sql: ${TABLE}.avg_duration ;;
  }

  dimension: avg_duration_diff {
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${avg_duration} - ${normalized_centroid_data.avg_duration} ;;
  }

  dimension: avg_duration_diff_pct {
    hidden: yes
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: abs((${avg_duration} - ${normalized_centroid_data.avg_duration}) / nullif(${normalized_centroid_data.avg_duration},0)) ;;
   }

  dimension: duration_anomaly {
    group_label: "Is Anomaly?"
    type: yesno
    sql: abs(${avg_duration_diff_pct}) >= 1.0  ;;
    # for demo purpose we've hard coded this
    # arbitrary threshold, but in reality this
    # would be based off of STDDEV
    html:  {% if value == 'No' %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ value }}</p>
    {% else %}
     <p style="color: white; background-color: red; font-size:100%; text-align:center">Duration</p>
    {% endif %};;
  }

  dimension: avg_rx_bytes {
    type: number
    sql: ${TABLE}.avg_rx_bytes ;;
    value_format_name: decimal_0
  }

  dimension: avg_rx_bytes_diff {
    label: "Rx Differece from Centroid Avg"
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${avg_rx_bytes} - ${normalized_centroid_data.avg_rx_bytes} ;;
  }

  dimension: avg_rx_bytes_diff_pct {
    hidden: yes
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: abs((${avg_rx_bytes} - ${normalized_centroid_data.avg_rx_bytes}) / nullif(${normalized_centroid_data.avg_rx_bytes},0)) ;;
  }

  dimension: rx_bytes_anomaly {
    group_label: "Is Anomaly?"
    type: yesno
    sql: abs(${avg_rx_bytes_diff_pct}) > 50.0  ;;
    # for demo purpose we've hard coded this
    # arbitrary threshold, but in reality this
    # would be based off of STDDEV
    html:  {% if value == 'No' %}
          <div style="color: white; background-color: green; font-size:100%; text-align:center">{{ value }}</div>
          {% else %}
           <div style="color: white; background-color: red; font-size:100%; text-align:center">Bytes Rx</div>
          {% endif %};;
  }


  dimension: avg_tx_bytes {
    type: number
    sql: ${TABLE}.avg_tx_bytes ;;
    value_format_name: decimal_0
  }

  dimension: avg_tx_bytes_diff {
    label: "Tx Difference from Centroid Avg"
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${avg_tx_bytes} - ${normalized_centroid_data.avg_tx_bytes} ;;
  }

  dimension: avg_tx_bytes_diff_pct {
    hidden: yes
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: (${avg_tx_bytes} - ${normalized_centroid_data.avg_tx_bytes}) / ${normalized_centroid_data.avg_tx_bytes} ;;
  }

  dimension: tx_bytes_anomaly {
    group_label: "Is Anomaly?"
    type: yesno
    sql: abs(${avg_tx_bytes_diff_pct}) > 50.0  ;;
    # for demo purpose we've hard coded this
    # arbitrary threshold, but in reality this
    # would be based off of STDDEV
    html:  {% if value == 'No' %}
    <div style="color: white; background-color: green; font-size:100%; text-align:center">{{ value }}</div>
    {% else %}
    <div style="color: white; background-color: red; font-size:100%; text-align:center">Bytes Tx</div>
    {% endif %};;
  }

  dimension: centroid_id {
    type: number
    sql: ${TABLE}.centroid_id ;;
  }

  dimension: dst_subnet {
    label: "Source Subnet"
    type: string
    # logic to simulate traffic coming from Russia for demo purposes only
    sql: CASE WHEN ${TABLE}.dst_subnet like '12.0.%'
         THEN REPLACE( ${TABLE}.dst_subnet , '12.0.', '109.107.')
          ELSE ${TABLE}.dst_subnet END  ;;
    link: {
      label: "Subnet Lookup"
      icon_url: "https://www.looker.com/favicon.ico"
      url: "/dashboards-next/747?Subnet={{ value | encode_uri }}"
    }

  }


  dimension: max_duration {
    type: number
    sql: ${TABLE}.max_duration ;;
  }

  dimension: max_duration_diff {
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${max_duration} - ${normalized_centroid_data.max_duration} ;;
  }


  dimension: max_rx_bytes {
    type: number
    sql: ${TABLE}.max_rx_bytes ;;
  }

  dimension: max_rx_bytes_diff {
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${max_rx_bytes} - ${normalized_centroid_data.max_rx_bytes} ;;
  }

  dimension: max_tx_bytes {
    type: number
    sql: ${TABLE}.max_tx_bytes ;;
  }

  dimension: max_tx_bytes_diff {
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${max_tx_bytes} - ${normalized_centroid_data.max_tx_bytes} ;;
  }

  dimension: min_duration {
    type: number
    sql: ${TABLE}.min_duration ;;
  }

  dimension: min_duration_diff {
    group_label: "Differences from Normal (Centroid)"
    type: number
    sql: ${min_duration} - ${normalized_centroid_data.min_duration} ;;
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
    label: "Event"
    type: time
    timeframes: [
      raw,
      second,
      minute,
      minute10,
      minute15,
      minute30,
      hour,
      hour6,
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
  }

  dimension: timestamp_string {
    hidden: yes
    type: string
    sql: SUBSTR(CAST(${transaction_time_time} AS STRING), STRPOS(CAST(${transaction_time_time} AS STRING), ' '), 9);;
    html: {{ outlier_data.transaction_time_date._value }}<br>{{ value }} ;;
  }

  measure: most_recent_outlier_date {
    type: date_second
    sql: MAX(${transaction_time_raw}) ;;
    convert_tz: no
    html: <body style="font-size:11px"><p>Most recent <br>anomaly occurred on<br><span style="color:DarkRed;font-weight:bold"> {{rendered_value | date: "%b %d, %Y" }}</span> <br>at <span style="color:DarkRed;font-weight:bold">{{rendered_value | date: "%T" }}</span>  </p></body> ;;
  }


dimension: source_country {
  # logic to simulate traffic coming from Russia for demo purposes only
  sql: CASE WHEN ${TABLE}.dst_subnet like '12.0.%' THEN 'Russia' ELSE 'United States' END  ;;
}

  dimension: source_lat {
    type: number
    hidden: yes
    # logic to simulate traffic coming from Russia for demo purposes only
    sql: CASE WHEN ${TABLE}.dst_subnet like '12.0.%' THEN 56.0 ELSE 39.0 END  ;;
  }

  dimension: source_lng {
    type: number
    hidden: yes
    # logic to simulate traffic coming from Russia for demo purposes only
    sql: CASE WHEN ${TABLE}.dst_subnet like '12.0.%' THEN 38.0 ELSE -77.0 END  ;;
  }

  dimension: source_location {
    type: location
    sql_latitude: ${source_lat} ;;
    sql_longitude: ${source_lng} ;;
  }

  dimension: is_risky_country {
    type: yesno
    sql: ${source_country} IN ('Russia', 'China', 'North Korea', 'Iran') ;;
  }

  dimension: actions {
    group_label: "Actions"
    description: "Various actions you can take on anomalies"
    sql: "Actions..." ;;
    action: {
      label: "Create Jira Ticket"
      icon_url: "https://cdn.worldvectorlogo.com/logos/jira-1.svg"
      url: "https://36eb5f27-30ab-4245-a28b-b08945733c96.trayapp.io"
      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out this anomaly. It occurred at {{ transaction_time_second._rendered_value | date: \"%T\" }} on {{ transaction_time_second._rendered_value | date: \"%b %d, %Y\" }}.
        Subnet: {{ dst_subnet._value }}
        Received Bytes: {{ outlier_data.avg_rx_bytes._rendered_value }}  vs. Average Received Bytes for Cluster: {{ normalized_centroid_data.avg_rx_bytes._rendered_value }}
        Sent Bytes: {{ outlier_data.avg_tx_bytes._rendered_value }} vs. Average Sent Bytes for Cluster: {{ normalized_centroid_data.avg_tx_bytes._rendered_value }}
"
      }
    }
    action: {
      label: "Text Security Consultant on Call"
      url: "https://hooks.zapier.com/hooks/catch/1662138/tvc3zj/"
      icon_url: "https://twilio-cms-prod.s3.amazonaws.com/original_images/twilio-mark-red.png"
      param: {
        name: "user_dash_link"
        value: "https://googlecloud.looker.com/dashboards/559"
      }
      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out this anomaly. It occurred at {{ transaction_time_second._rendered_value | date: \"%T\" }} on {{ transaction_time_second._rendered_value | date: \"%b %d, %Y\" }}.
        Subnet: {{ dst_subnet._value }}
        Received Bytes: {{ outlier_data.avg_rx_bytes._rendered_value }}  vs. Average Received Bytes for Cluster: {{ normalized_centroid_data.avg_rx_bytes._rendered_value }}
        Sent Bytes: {{ outlier_data.avg_tx_bytes._rendered_value }} vs. Average Sent Bytes for Cluster: {{ normalized_centroid_data.avg_tx_bytes._rendered_value }}
        "
        }
      }
    action: {
      label: "Email Security Team"
      url: "https://hooks.zapier.com/hooks/catch/1662138/tvc3zj/"
      icon_url: "http://www.google.com/s2/favicons?domain=www.gmail.com"
      param: {
        name: "user_dash_link"
        value: "https://googlecloud.looker.com/dashboards/559"
      }
      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out this anomaly. It occurred at {{ transaction_time_second._rendered_value | date: \"%T\" }} on {{ transaction_time_second._rendered_value | date: \"%b %d, %Y\" }}.
        Subnet: {{ dst_subnet._value }}
        Received Bytes: {{ outlier_data.avg_rx_bytes._rendered_value }}  vs. Average Received Bytes for Cluster: {{ normalized_centroid_data.avg_rx_bytes._rendered_value }}
        Sent Bytes: {{ outlier_data.avg_tx_bytes._rendered_value }} vs. Average Sent Bytes for Cluster: {{ normalized_centroid_data.avg_tx_bytes._rendered_value }}
        "
      }
      form_param: {
        name: "Recipient"
        type: select
        default: "cody"
        option: {
          name: "cody"
          label: "Cody"
        }
        option: {
          name: "masud"
          label: "Masud"
        }
        option: {
          name: "google_security"
          label: "Google Security Group"
        }
      }
    }
  }


  measure: count {
    hidden: yes
    type: count
    drill_fields: [transaction_time_second, normalized_centroid_data.centroid_id, dst_subnet, avg_rx_bytes, normalized_centroid_data.avg_rx_bytes, avg_tx_bytes, normalized_centroid_data.avg_tx_bytes, actions]
  }

  measure: anomaly_count {
    type: number
    sql: ${count} ;;
    # for demo purposes, we are making the
    # count much smaller than the data that
    # is being generated
    drill_fields: [transaction_time_second, dst_subnet, duration_anomaly, rx_bytes_anomaly, tx_bytes_anomaly, actions]
  }
}
