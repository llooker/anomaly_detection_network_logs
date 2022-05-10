- dashboard: bigsearch
  title: BigSearch
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Log Search
    name: Log Search
    model: anomaly_detection
    explore: netflow_log_raw_data
    type: looker_grid
    fields: [netflow_log_raw_data.end_time_time, netflow_log_raw_data.protocol_name,
      netflow_log_raw_data.src_ip, netflow_log_raw_data.src_port, netflow_log_raw_data.dst_ip,
      netflow_log_raw_data.dst_port, netflow_log_raw_data.bytes_transferred]
    filters:
      netflow_log_raw_data.big_search_filter: 12.0.0.5
    sorts: [netflow_log_raw_data.end_time_time desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    defaults_version: 1
    listen:
      Partition Date: netflow_log_raw_data.partition_date
    row: 0
    col: 0
    width: 24
    height: 9
  filters:
  - name: Big Search Filter
    title: Big Search Filter
    type: field_filter
    default_value: 12.0.0.5
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: anomaly_detection
    explore: netflow_log_raw_data
    listens_to_filters: []
    field: netflow_log_raw_data.big_search_filter
  - name: Partition Date
    title: Partition Date
    type: field_filter
    default_value: 2020/09/21 to 2020/10/01
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: anomaly_detection
    explore: netflow_log_raw_data
    listens_to_filters: []
    field: netflow_log_raw_data.partition_date
