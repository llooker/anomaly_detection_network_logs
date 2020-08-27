view: ip_to_geography_lookup {
    derived_table: {
      datagroup_trigger: ip_lookup
      sql: SELECT
              NET.IPV4_TO_INT64(NET.SAFE_IP_FROM_STRING(substr(network, 1, strpos(network, '/') - 1))) AS start_ipv4_to_int64
              ,NET.IPV4_TO_INT64(NET.SAFE_IP_FROM_STRING(substr(network, 1, strpos(network, '/') - 1))) + POW(2, 32 - cast(substr(network, strpos(network, '/') + 1) as INT64)) - 2 end_ipv4_int64
              , * except(center_point)
              FROM `bigquery-public-data.geolite2.ipv4_city_blocks`
              JOIN `bigquery-public-data.geolite2.ipv4_city_locations`
              USING(geoname_id)
              order by 1 asc
               ;;
    }



    dimension: start_ipv4_to_int64 {
      type: number
      sql: ${TABLE}.start_ipv4_to_int64 ;;
    }

    dimension: end_ipv4_int64 {
      type: number
      sql: ${TABLE}.end_ipv4_int64 ;;
    }

    dimension: geoname_id {
      type: string
      sql: ${TABLE}.geoname_id ;;
    }

    dimension: network {
      type: string
      sql: ${TABLE}.network ;;
    }

    dimension: registered_country_geoname_id {
      type: string
      sql: ${TABLE}.registered_country_geoname_id ;;
    }

    dimension: represented_country_geoname_id {
      type: string
      sql: ${TABLE}.represented_country_geoname_id ;;
    }

    dimension: is_anonymous_proxy {
      type: string
      sql: ${TABLE}.is_anonymous_proxy ;;
    }

    dimension: is_satellite_provider {
      type: string
      sql: ${TABLE}.is_satellite_provider ;;
    }

    dimension: postal_code {
      type: string
      sql: ${TABLE}.postal_code ;;
    }

    dimension: latitude {
      type: number
      sql: ${TABLE}.latitude ;;
    }

    dimension: longitude {
      type: number
      sql: ${TABLE}.longitude ;;
    }

    dimension: accuracy_radius {
      type: number
      sql: ${TABLE}.accuracy_radius ;;
    }

    dimension: locale_code {
      type: string
      sql: ${TABLE}.locale_code ;;
    }

    dimension: continent_code {
      type: string
      sql: ${TABLE}.continent_code ;;
    }

    dimension: continent_name {
      type: string
      sql: ${TABLE}.continent_name ;;
    }

    dimension: country_iso_code {
      type: string
      sql: ${TABLE}.country_iso_code ;;
    }

    dimension: country_name {
      type: string
      sql: ${TABLE}.country_name ;;
    }

    dimension: subdivision_1_iso_code {
      type: string
      sql: ${TABLE}.subdivision_1_iso_code ;;
    }

    dimension: subdivision_1_name {
      type: string
      sql: ${TABLE}.subdivision_1_name ;;
    }

    dimension: subdivision_2_iso_code {
      type: string
      sql: ${TABLE}.subdivision_2_iso_code ;;
    }

    dimension: subdivision_2_name {
      type: string
      sql: ${TABLE}.subdivision_2_name ;;
    }

    dimension: city_name {
      type: string
      sql: ${TABLE}.city_name ;;
    }

    dimension: metro_code {
      type: string
      sql: ${TABLE}.metro_code ;;
    }

    dimension: time_zone {
      type: string
      sql: ${TABLE}.time_zone ;;
    }

    dimension: is_in_european_union {
      type: string
      sql: ${TABLE}.is_in_european_union ;;
    }

    dimension: location {
      type: location
      sql_latitude: ${TABLE}.latitude ;;
      sql_longitude: ${TABLE}.longitude ;;
    }

    set: detail {
      fields: [
        start_ipv4_to_int64,
        end_ipv4_int64,
        geoname_id,
        network,
        registered_country_geoname_id,
        represented_country_geoname_id,
        is_anonymous_proxy,
        is_satellite_provider,
        postal_code,
        latitude,
        longitude,
        accuracy_radius,
        locale_code,
        continent_code,
        continent_name,
        country_iso_code,
        country_name,
        subdivision_1_iso_code,
        subdivision_1_name,
        subdivision_2_iso_code,
        subdivision_2_name,
        city_name,
        metro_code,
        time_zone,
        is_in_european_union,
        location
      ]
    }
  }
