view: kt_listening_history {
  sql_table_name: tim_thesis.Kt_listening_history ;;

  set: drill_set {
    fields: [album_name,artist_name,song_name,song_audio_features.valence]
  }

  dimension: album_id {
    type: string
    sql: ${TABLE}.album_id ;;
  }
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${played_time}, ' ', ${song_id}) ;;
  }

  dimension: album_name {
    type: string
    sql: ${TABLE}.album_name ;;
  }

  dimension: artist_id {
    type: string
    sql: ${TABLE}.artist_id ;;
  }

  dimension: artist_name {
    type: string
    sql: ${TABLE}.artist_name ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension_group: played {
    type: time
    timeframes: [
      raw,
      minute,
      hour,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.played_at ;;
  }

  dimension_group: played_viz {
    type: time
    timeframes: [minute]
    sql: ${TABLE}.played_at ;;
    html:
    Played at: {{ rendered_value }} <br>
    Song name: {{ song_name._rendered_value }} <br>
    Artist name: {{ artist_name._rendered_value }}
    ;;
  }

  dimension: hour_played {
    type: number
    sql: EXTRACT(hour from (TIMESTAMP(FORMAT_TIMESTAMP('%F %T', ${played_raw} , 'America/Los_Angeles'))));;
  }

  dimension: Morning_Afternoon {
    type: yesno
    sql: ${hour_played} IN (7,8,9,10,11) ;;
  }

  dimension: song_id {
    type: string
    sql: ${TABLE}.song_id ;;
  }

  dimension: song_name {
    type: string
    sql: ${TABLE}.song_name ;;
    link: {
      label: "Drill to Song Information"
      url: "https://dcl.dev.looker.com/dashboards/531?Song Title={{ rendered_value }}"
    }
  }

  measure: count {
    type: count
    label: "Play Count"
    drill_fields: [drill_set*]
  }

  measure: count_m {
    type: count
    label: "Morning Play Count"
    filters: {
      field: Morning_Afternoon
      value: "yes"
    }
  }

  measure: count_a {
    type: count
    label: "Afternoon Play Count"
    filters: {
      field: Morning_Afternoon
      value: "no"
    }
  }
}
