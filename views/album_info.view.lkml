view: album_info {
  sql_table_name: tim_thesis.album_info ;;

  dimension: album_id {
    sql: ${TABLE}.album_id ;;
    type: string
    primary_key: yes
  }

  dimension: album_image {
    sql: ${TABLE}.album_image ;;
    type: string
    html: <img src="{{value}}" height="250" width="250"> </img> <br />
    <font size = "6">{{ album_name._rendered_value }}</font>;;
  }

  dimension: release_year {
   type: number
   sql: EXTRACT(YEAR FROM CAST(${TABLE}.album_release_date AS DATE));;
  drill_fields: [song_album_list.artist_name, album_name]
  }


  dimension: album_name {
    sql: ${TABLE}.album_name ;;
    type: string
  }

  measure: count {
    type: count
  }

}
