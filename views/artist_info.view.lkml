view: artist_info {
  sql_table_name: tim_thesis.artist_info ;;

  dimension: primary_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: CONCAT(${artist_id},' ',${genre}) ;;
  }
  dimension: artist_id {
    type: string
    sql: ${TABLE}.artist_id ;;
  }

  dimension: artist_image {
    type: string
    sql: ${TABLE}.artist_image ;;
    html: <img src="{{value}}" height = "250" width = "250"> </img>;;
  }

  dimension: artist_name {
    type: string
    sql: ${TABLE}.artist_name ;;
    link: {
      label: "Drill to Artist"
      url: "https://dcl.dev.looker.com/dashboards/536?Artist Name={{ rendered_value }}"
    }
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
    drill_fields: [artist_name, artist_image]
  }

  measure: count {
    type: count
    drill_fields: [artist_name]
  }
}
