view: song_list {
  sql_table_name: tim_thesis.song_list ;;

  parameter: song_title {
    type: string
  }

  parameter: artist_name_selector {
    type: string
  }


  dimension: album_id {
    type: string
    sql: ${TABLE}.album_id ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: preview_url_flag {
    type: yesno
    sql: ${preview_url} IS NULL;;
  }

  dimension: artist_name {
    type: string
    sql: ${TABLE}.artist_name ;;
    link: {
      label: "Drill to Artist"
      url: "https://dcl.dev.looker.com/dashboards/536?Artist Name={{ rendered_value }}"
    }
  }

  dimension: artist_id {
    type: string
    sql: ${TABLE}.artist_id ;;
  }

  dimension: preview_url {
    type: string
    sql: ${TABLE}.preview_url;;
    html: {% if preview_url_flag == "Yes" %}
    <b> No Preview Found :( </b>
    {% else %}
    <audio src="{{ value }}" controls> </audio>
    {% endif %}
    ;;
  }

  dimension: song_name {
    type: string
    sql: ${TABLE}.song_name ;;
    html: <a href="https://open.spotify.com/track/{{ track_id._rendered_value }}" target="_blank" >{{ rendered_value }}</a> ;;
  }

  dimension: track_id {
    type: string
    sql: ${TABLE}.track_id ;;
  }

  dimension: track_number {
    type: number
    sql: ${TABLE}.track_number ;;
  }

  measure: count {
    type: count
    drill_fields: [song_name]
  }

}
