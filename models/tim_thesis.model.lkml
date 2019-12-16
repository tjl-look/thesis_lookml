connection: "lookerdata_standard_sql"

include: "/views/*"
datagroup: tim_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: tim_thesis_default_datagroup

explore: kt_listening_history {
  join: song_audio_features {
    type: left_outer
    sql_on: ${kt_listening_history.song_id} = ${song_audio_features.song_id} ;;
    relationship: many_to_one
  }
}

explore: song_list {
  join: song_audio_features {
    type: left_outer
    sql_on: ${song_list.track_id} = ${song_audio_features.song_id} ;;
    relationship: one_to_one
  }
  join: kt_listening_history {
    type: left_outer
    sql_on: ${song_list.track_id} = ${kt_listening_history.song_id} ;;
    relationship: one_to_many
  }
}

explore: song_list_kt {
  from: song_list
  join: kt_listening_history {
    type: left_outer
    sql_on: ${song_list_kt.track_id} = ${kt_listening_history.song_id} ;;
    relationship: one_to_many
  }
}

explore: song_album_list {
  from: song_list
  join: album_info {
    type: left_outer
    sql_on: ${song_album_list.album_id} = ${album_info.album_id} ;;
    relationship: many_to_one
  }
}

explore: album_filter {
  join: album_info {
    type: left_outer
    sql_on: ${album_filter.album_id} = ${album_info.album_id} ;;
    relationship: many_to_one
  }
  join: kt_listening_history {
    type: left_outer
    sql_on: ${album_filter.song_id}=${kt_listening_history.song_id} ;;
    relationship: one_to_many

  }
}


explore: artist_info {}

explore: song_audio_features_ab {
  join: song_list {
    type: left_outer
    sql_on: ${song_audio_features_ab.song_id} = ${song_list.track_id} ;;
    relationship: one_to_one
  }
}
