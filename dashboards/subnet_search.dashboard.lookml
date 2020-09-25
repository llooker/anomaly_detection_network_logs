- dashboard: subnet_search
  title: Subnet Search
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: "# Connections"
    name: "# Connections"
    model: anomaly_detection
    explore: outlier_data
    type: single_value
    fields: [outlier_data.count, outlier_data.transaction_time_date]
    filters:
      outlier_data.transaction_time_date: 3 days ago for 3 days
      outlier_data.count: NOT NULL
    sorts: [outlier_data.transaction_time_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: change, label: Change, expression: " (${outlier_data.count}\
          \  - offset(${outlier_data.count}, 1)  ) / offset(${outlier_data.count},\
          \ 1)", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Connections
    comparison_label: vs day prior
    series_types: {}
    defaults_version: 1
    listen:
      Subnet: outlier_data.dst_subnet
    row: 0
    col: 0
    width: 6
    height: 5
  - title: Traffic Over Time
    name: Traffic Over Time
    model: anomaly_detection
    explore: outlier_data
    type: looker_area
    fields: [outlier_data.count, outlier_data.transaction_time_hour]
    fill_fields: [outlier_data.transaction_time_hour]
    filters:
      outlier_data.transaction_time_date: 7 days
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_label: Connection Hour
    series_types: {}
    series_labels:
      outlier_data.count: Total Connections
    defaults_version: 1
    listen:
      Subnet: outlier_data.dst_subnet
    row: 0
    col: 6
    width: 6
    height: 5
  - title: First Event Occurred
    name: First Event Occurred
    model: anomaly_detection
    explore: outlier_data
    type: single_value
    fields: [outlier_data.timestamp_string]
    filters:
      outlier_data.transaction_time_date: 3 days
    sorts: [outlier_data.timestamp_string desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Subnet: outlier_data.dst_subnet
    row: 0
    col: 12
    width: 6
    height: 5
  - title: Last Event Occurred
    name: Last Event Occurred
    model: anomaly_detection
    explore: outlier_data
    type: single_value
    fields: [outlier_data.timestamp_string]
    filters:
      outlier_data.transaction_time_date: 3 days
    sorts: [outlier_data.timestamp_string]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Subnet: outlier_data.dst_subnet
    row: 0
    col: 18
    width: 6
    height: 5
  - title: Latest Events from Subnet
    name: Latest Events from Subnet
    model: anomaly_detection
    explore: outlier_data
    type: looker_grid
    fields: [outlier_data.transaction_time_time, outlier_data.dst_subnet, outlier_data.source_country,
      outlier_data.subscriber_id, outlier_data.number_of_unique_ips, outlier_data.number_of_unique_ports,
      outlier_data.avg_duration, outlier_data.avg_rx_bytes, outlier_data.avg_tx_bytes]
    filters: {}
    sorts: [outlier_data.transaction_time_time desc]
    limit: 10
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Subnet: outlier_data.dst_subnet
    row: 5
    col: 0
    width: 24
    height: 6
  filters:
  - name: Subnet
    title: Subnet
    type: field_filter
    default_value: 109.107.32.84/22
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: anomaly_detection
    explore: outlier_data
    listens_to_filters: []
    field: outlier_data.dst_subnet
