- dashboard: security_analytics_and_anomaly_detection
  title: Security Analytics & Anomaly Detection
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: "<b>How do we make sense of this data and ensure our org is safe?</b>"
    type: text
    title_text: "<b>How do we make sense of this data and ensure our org is safe?</b>"
    subtitle_text: ''
    body_text: |-
      - First we can look for **"known" behavior that may pose a risk**
      - By configuring and weighting different parameters that we consider to be risky or suspicious
    row: 11
    col: 0
    width: 24
    height: 3
  - name: "<b>But what about new and unknown threats? </b>"
    type: text
    title_text: "<b>But what about new and unknown threats? </b>"
    subtitle_text: ''
    body_text: "- Can use Machine Learning to flag anomalous behavior"
    row: 35
    col: 0
    width: 24
    height: 3
  - title: Anomalies Today
    name: Anomalies Today
    model: anomaly_detection
    explore: outlier_data
    type: single_value
    fields: [outlier_data.transaction_time_date, outlier_data.anomaly_count]
    filters:
      outlier_data.transaction_time_date: 4 days
      outlier_data.count: NOT NULL
    sorts: [outlier_data.transaction_time_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: vs_yesterday, label: vs. Yesterday, expression: "(${outlier_data.anomaly_count}-offset(${outlier_data.anomaly_count},1))\
          \ / offset(${outlier_data.anomaly_count},1)", value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#B32F37"
    comparison_label: ''
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#B32F37", color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 38
    col: 0
    width: 9
    height: 6
  - name: "<b>Network traffic logs can generate extremely large data volumes</b>"
    type: text
    title_text: "<b>Network traffic logs can generate extremely large data volumes</b>"
    subtitle_text: ''
    body_text: "- Data volumes that BigQuery was built to support"
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Total Network Traffic Events
    name: Total Network Traffic Events
    model: anomaly_detection
    explore: netflow_log_raw_data
    type: single_value
    fields: [netflow_log_raw_data.count]
    filters:
      netflow_log_raw_data.partition_date: 7 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 3
    col: 0
    width: 24
    height: 3
  - title: Latest Events
    name: Latest Events
    model: anomaly_detection
    explore: netflow_log_raw_data
    type: looker_grid
    fields: [netflow_log_raw_data.end_time_time, netflow_log_raw_data.protocol_name,
      netflow_log_raw_data.src_ip, netflow_log_raw_data.src_port, netflow_log_raw_data.dst_ip,
      netflow_log_raw_data.dst_port, netflow_log_raw_data.bytes_transferred]
    filters:
      netflow_log_raw_data.partition_date: 2 days
      netflow_log_raw_data.end_time_time: 5 minutes
    sorts: [netflow_log_raw_data.end_time_time desc]
    limit: 7
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
    series_cell_visualizations:
      netflow_log_raw_data.bytes_transferred:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 5
  - title: Unexpected Traffic
    name: Unexpected Traffic
    model: anomaly_detection
    explore: netflow_log_raw_data
    type: looker_map
    fields: [netflow_log_raw_data.geo_country, netflow_log_raw_data.count, netflow_log_raw_data.geo_location]
    filters:
      netflow_log_raw_data.partition_date: 3 days
      netflow_log_raw_data.is_risky_country: 'Yes'
    sorts: [netflow_log_raw_data.count desc]
    limit: 20
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: dark
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 49.84019666664545
    map_longitude: 82.63229370117189
    map_zoom: 3
    map_marker_radius_min: 50000
    map_marker_radius_max: 500000
    defaults_version: 1
    listen: {}
    row: 14
    col: 9
    width: 15
    height: 10
  - name: Events and Anomalies
    title: Events and Anomalies
    merged_queries:
    - model: anomaly_detection
      explore: outlier_data
      type: table
      fields: [outlier_data.transaction_time_hour6, outlier_data.anomaly_count]
      fill_fields: [outlier_data.transaction_time_hour6]
      filters:
        outlier_data.transaction_time_date: 14 days
      sorts: [outlier_data.transaction_time_hour6 desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields: []
    - model: anomaly_detection
      explore: netflow_log_raw_data
      type: looker_area
      fields: [netflow_log_raw_data.count, netflow_log_raw_data.start_time_hour6]
      fill_fields: [netflow_log_raw_data.start_time_hour6]
      filters:
        netflow_log_raw_data.partition_date: 14 days
      sorts: [netflow_log_raw_data.start_time_hour6 desc]
      limit: 500
      query_timezone: America/Los_Angeles
      x_axis_gridlines: false
      y_axis_gridlines: true
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
      interpolation: monotone
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}
      series_colors:
        netflow_log_raw_data.count: "#34A853"
      defaults_version: 1
      join_fields:
      - field_name: netflow_log_raw_data.start_time_hour6
        source_field_name: outlier_data.transaction_time_hour6
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: Total Connections, orientation: left, series: [{axisId: netflow_log_raw_data.count,
            id: netflow_log_raw_data.count, name: Netflow Connections}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: outlier_data.anomaly_count,
            id: outlier_data.anomaly_count, name: Anomaly Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: outlier_data.anomaly_count
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types:
      outlier_data.count: scatter
      outlier_data.anomaly_count: scatter
    point_style: none
    series_colors:
      outlier_data.count: "#EA4335"
      netflow_log_raw_data.count: "#185ABC"
      outlier_data.anomaly_count: "#EA4335"
    series_labels:
      netflow_log_raw_data.count: Netflow Connections
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_area
    row: 44
    col: 0
    width: 24
    height: 8
  - title: Normal Traffic
    name: Normal Traffic
    model: anomaly_detection
    explore: netflow_log_raw_data
    type: looker_map
    fields: [netflow_log_raw_data.geo_country, netflow_log_raw_data.count, netflow_log_raw_data.geo_location]
    filters:
      netflow_log_raw_data.partition_date: 3 days
      netflow_log_raw_data.geo_country: United States
      netflow_log_raw_data.longitude: not -97.822
    sorts: [netflow_log_raw_data.count desc]
    limit: 20
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: dark
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 49.84019666664545
    map_longitude: 82.63229370117189
    map_zoom: 3
    map_marker_radius_min: 50000
    map_marker_radius_max: 500000
    map_marker_color: [green]
    defaults_version: 1
    listen: {}
    row: 14
    col: 0
    width: 9
    height: 10
  - title: Anomaly Details
    name: Anomaly Details
    model: anomaly_detection
    explore: outlier_data
    type: looker_grid
    fields: [outlier_data.transaction_time_second, outlier_data.dst_subnet, outlier_data.duration_anomaly,
      outlier_data.rx_bytes_anomaly, outlier_data.tx_bytes_anomaly, outlier_data.actions]
    filters:
      outlier_data.transaction_time_date: 1 days
    sorts: [outlier_data.transaction_time_second desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
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
    series_labels:
      outlier_data.duration_anomaly: Duration Anomaly?
      outlier_data.rx_bytes_anomaly: Bytes Rx Anomaly?
      outlier_data.tx_bytes_anomaly: Bytes Tx Anomaly?
      outlier_data.number_of_unique_ips: Number of Unique IPs
    series_column_widths:
      outlier_data.dst_subnet: 138
      outlier_data.transaction_time_second: 140
      outlier_data.duration_anomaly: 152
      outlier_data.rx_bytes_anomaly: 153
    series_cell_visualizations:
      outlier_data.avg_rx_bytes:
        is_active: true
        palette:
          palette_id: c7bfb268-656e-7213-33db-67222b2e44fb
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - "#f9fa30"
          - "#FBB555"
          - "#E57947"
      outlier_data.avg_tx_bytes:
        is_active: true
        palette:
          palette_id: 719915e8-375d-8591-9a28-d1b98dcf6041
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
          custom_colors:
          - "#f9fa30"
          - "#FBB555"
          - "#E57947"
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: []
    series_types: {}
    listen: {}
    row: 38
    col: 9
    width: 15
    height: 6
