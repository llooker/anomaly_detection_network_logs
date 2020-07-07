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
    value_format_name: decimal_0
  }

  dimension: avg_tx_bytes {
    type: number
    sql: ${TABLE}.avg_tx_bytes ;;
    value_format_name: decimal_0
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
    html: <body style="font-size:11px"><p>Most recent <br>anomaly occurred on<br><span style="color:DarkRed;font-weight:bold"> {{rendered_value | date: "%b %d, %Y" }}</span> <br>at <span style="color:DarkRed;font-weight:bold">{{rendered_value | date: "%T" }}</span>  </p></body> ;;
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
    type: count
    drill_fields: [transaction_time_second, normalized_centroid_data.centroid_id, dst_subnet, avg_rx_bytes, normalized_centroid_data.avg_rx_bytes, avg_tx_bytes, normalized_centroid_data.avg_tx_bytes, actions]
  }
}
