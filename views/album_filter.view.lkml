view: album_filter {
  filter: song_name_filter {
    type: string
  }
derived_table: {
  sql: SELECT album_id, song_name, track_id
  FROM tim_thesis.song_list
  WHERE album_id IN (SELECT album_id
            FROM tim_thesis.song_list
            WHERE {% condition song_name_filter %} song_name {% endcondition %}

  );;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${song_name}, ' ', ${album_id) ;;
  }

  dimension:song_name{
  sql: ${TABLE}.song_name ;;
  type: string
  html: <a href="/dashboards/531?Song Title={{ value }}">{{ value }}</a> ;;
  }

  dimension: album_id {
    sql: ${TABLE}.album_id ;;
    type: string
  }

  dimension: song_id {
    sql: ${TABLE}.track_id;;
    type: string
  }
}
