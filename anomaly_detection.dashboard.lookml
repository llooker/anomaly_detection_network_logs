- dashboard: security_analytics__anomaly_detection
  title: Security Analytics & Anomaly Detection
  layout: newspaper
  elements:
  - name: "<b>How do we make sense of this data and ensure our org is safe?</b>"
    type: text
    title_text: "<b>How do we make sense of this data and ensure our org is safe?</b>"
    subtitle_text: ''
    body_text: |-
      - First we can look for **"known" behavior that may pose a risk**
      - By configuring and weighting different parameters that we consider to be risky or suspicious
    row: 13
    col: 0
    width: 24
    height: 3
  - name: "<b>But what about new and unknown threats? </b>"
    type: text
    title_text: "<b>But what about new and unknown threats? </b>"
    subtitle_text: ''
    body_text: "- Can use Machine Learning to flag anomalous behavior"
    row: 25
    col: 0
    width: 24
    height: 3
  - title: Anomalies Today
    name: Anomalies Today
    model: anomaly_detection
    explore: outlier_data
    type: single_value
    fields: [outlier_data.count, outlier_data.transaction_time_date]
    fill_fields: [outlier_data.transaction_time_date]
    filters:
      outlier_data.transaction_time_date: 2020/04/26 to 2020/04/28
    sorts: [outlier_data.transaction_time_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: vs_yesterday, label: vs. Yesterday, expression: "${outlier_data.count}-offset(${outlier_data.count},1)",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
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
    row: 28
    col: 0
    width: 9
    height: 6
  - title: Anomaly Details
    name: Anomaly Details
    model: anomaly_detection
    explore: outlier_data
    type: looker_grid
    fields: [outlier_data.transaction_time_second, outlier_data.dst_subnet, outlier_data.avg_rx_bytes,
      outlier_data.avg_tx_bytes, outlier_data.actions, normalized_centroid_data.avg_rx_bytes,
      normalized_centroid_data.avg_tx_bytes]
    filters:
      outlier_data.transaction_time_date: 2020/04/27
    sorts: [outlier_data.transaction_time_second desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    series_column_widths:
      outlier_data.dst_subnet: 110
      outlier_data.transaction_time_second: 183
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
    defaults_version: 1
    hidden_fields: [normalized_centroid_data.avg_rx_bytes, normalized_centroid_data.avg_tx_bytes]
    listen: {}
    row: 28
    col: 9
    width: 15
    height: 6
  - title: Total Network Traffic Events
    name: Total Network Traffic Events
    model: anomaly_detection
    explore: cluster_model_data
    type: single_value
    fields: [cluster_model_data.count]
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
    row: 3
    col: 0
    width: 24
    height: 5
  - name: "<b>Network traffic logs can generate extremely large data volumes</b>"
    type: text
    title_text: "<b>Network traffic logs can generate extremely large data volumes</b>"
    body_text: "- Data volumes that BigQuery was built to support"
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Network Traffic
    name: Network Traffic
    model: project_concorde
    explore: network_summary
    type: looker_map
    fields: [network_summary.source_location_0, network_summary.source_country, network_summary.sum_count]
    filters:
      network_summary.timestamp_date: 7 days
      network_summary.source_country_label: ''
      network_summary.weight_country: '2'
      network_summary.weight_malicious_file: '4'
      network_summary.weight_large_file: '1'
      network_summary.source_country: CN,RU
    sorts: [network_summary.sum_count desc]
    limit: 20
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: value
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 51.88284911979613
    map_longitude: 81.48696899414064
    map_zoom: 3
    map_marker_radius_fixed: 1
    map_marker_radius_min: 15
    map_marker_radius_max: 40
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Yesterday
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
    hidden_fields: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 16
    col: 0
    width: 9
    height: 9
  - title: Risk Score
    name: Risk Score
    model: project_concorde
    explore: network_summary
    type: single_value
    fields: [network_summary.timestamp_date, network_summary.risk_score, network_summary.percent_connections_large_files,
      network_summary.percent_connections_over_malicious_file, network_summary.percent_connections_made_from_adversarial_country]
    filters:
      network_summary.timestamp_date: 7 days
      network_summary.risk_score: NOT NULL
      network_summary.source_country_label: ''
      network_summary.weight_country: '2'
      network_summary.weight_malicious_file: '4'
      network_summary.weight_large_file: '1'
    sorts: [network_summary.timestamp_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: yesterday, expression: 'offset(${network_summary.risk_score},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: "% vs. Yesterday",
        expression: "(${network_summary.risk_score} - ${yesterday})/${yesterday}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Day Prior
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
    hidden_fields: [network_summary.percent_connections_large_files, network_summary.percent_connections_over_malicious_file,
      network_summary.percent_connections_made_from_adversarial_country, yesterday]
    listen: {}
    row: 16
    col: 19
    width: 5
    height: 9
  - title: Potentially Suspicious Connections
    name: Potentially Suspicious Connections
    model: project_concorde
    explore: network_summary
    type: looker_line
    fields: [network_summary.timestamp_date, network_summary.sum_count, network_summary.connections_large_files,
      network_summary.connections_over_malicious_file, network_summary.connections_made_from_nefarious_country]
    filters:
      network_summary.timestamp_date: 7 days
      network_summary.risk_score: NOT NULL
      network_summary.source_country_label: ''
      network_summary.weight_country: '2'
      network_summary.weight_malicious_file: '4'
      network_summary.weight_large_file: '1'
    sorts: [network_summary.timestamp_date desc]
    limit: 500
    column_limit: 50
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: red_black
      palette_id: red_black-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: network_summary.sum_count,
            id: network_summary.sum_count, name: Total Connections}, {axisId: network_summary.connections_large_files,
            id: network_summary.connections_large_files, name: "# Connections - Large\
              \ File"}, {axisId: network_summary.connections_over_malicious_file,
            id: network_summary.connections_over_malicious_file, name: "# Connections\
              \ - Malicious File"}, {axisId: network_summary.connections_made_from_nefarious_country,
            id: network_summary.connections_made_from_nefarious_country, name: "#\
              \ Connections - Nefarious Country"}], showLabels: true, showValues: false,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: [network_summary.risk_score]
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: vs. Yesterday
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 16
    col: 9
    width: 10
    height: 9
  - title: Raw Network Traffic
    name: Raw Network Traffic
    model: project_concorde
    explore: network
    type: looker_grid
    fields: [network.timestamp_time, network.protocol, network.source_ip, network.source_port,
      network.destination_ip, network.destination_port, network.bytes_sent]
    filters:
      network.timestamp_date: 5 minutes
    sorts: [network.timestamp_time desc]
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
      network.bytes_sent:
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
    row: 8
    col: 0
    width: 24
    height: 5
  - name: Events and Anomalies
    title: Events and Anomalies
    merged_queries:
    - model: anomaly_detection
      explore: outlier_data
      type: looker_scatter
      fields: [outlier_data.count, outlier_data.transaction_time_date]
      fill_fields: [outlier_data.transaction_time_date]
      sorts: [outlier_data.transaction_time_date desc]
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
      point_style: circle
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      y_axes: [{label: '', orientation: left, series: [{axisId: outlier_data.count,
              id: outlier_data.count, name: Netflow Anomalies}], showLabels: true,
          showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
          type: log}]
      size_by_field: outlier_data.count
      series_types: {}
      interpolation: linear
      defaults_version: 1
    - model: project_concorde
      explore: network_summary
      type: table
      fields: [network_summary.timestamp_date, network_summary.sum_count]
      fill_fields: [network_summary.timestamp_date]
      filters:
        network_summary.timestamp_date: 365 days
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: network_summary.timestamp_date
        source_field_name: outlier_data.transaction_time_date
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: network_summary.sum_count,
            id: network_summary.sum_count, name: Total Connections}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{axisId: outlier_data.count,
            id: outlier_data.count, name: Netflow Anomalies}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    size_by_field: outlier_data.count
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types:
      outlier_data.count: scatter
      network_summary.sum_count: area
    point_style: none
    series_colors:
      outlier_data.count: "#B32F37"
      network_summary.sum_count: "#72D16D"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    type: looker_line
    row: 34
    col: 0
    width: 24
    height: 7
