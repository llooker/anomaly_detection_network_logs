- dashboard: bigsearch
  title: BigSearch
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Log Search
    name: Log Search
    model: anomaly_detection
    explore: big_search
    type: looker_grid
    fields: [big_search.end_time_time, big_search.protocol_name, big_search.src_ip,
      big_search.src_port, big_search.dst_ip, big_search.dst_port, big_search.bytes_transferred]
    filters:
      big_search.partition_date: 2020/09/01 to 2020/09/30
    sorts: [big_search.end_time_time desc]
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
    series_cell_visualizations:
      big_search.bytes_transferred:
        is_active: false
        value_display: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#29bff3",
        font_color: !!null '', color_application: {collection_id: create-a-color-collection,
          palette_id: create-a-color-collection-sequential-0}, bold: false, italic: false,
        strikethrough: false, fields: [big_search.bytes_transferred]}]
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
    listen:
      Big Search Filter: big_search.big_search_filter
    row: 0
    col: 0
    width: 24
    height: 8
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
    explore: big_search
    listens_to_filters: []
    field: big_search.big_search_filter
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
