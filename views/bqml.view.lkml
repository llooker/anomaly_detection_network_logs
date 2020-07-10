view: k_means_inputs {
  derived_table: {
    explore_source: cluster_model_data {
      column: avg_duration {}
      column: avg_rx_bytes {}
      column: avg_tx_bytes {}
      column: max_duration {}
      column: max_rx_bytes {}
      column: max_tx_bytes {}
      column: min_duration {}
      column: min_rx_bytes {}
      column: min_tx_bytes {}
      column: number_of_records {}
    }
  }
}

view: k_means_cluster {
  derived_table: {
    datagroup_trigger: once_weekly
    sql_create:
      CREATE OR REPLACE MODEL `looker-private-demo.anomaly_detection.log_cluster`
      OPTIONS(model_type='kmeans',num_clusters=4, standardize_features = true) AS
      SELECT *
      FROM k_means_inputs ;;
  }
}
