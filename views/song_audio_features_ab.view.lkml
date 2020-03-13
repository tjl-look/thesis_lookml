view: song_audio_features_ab {
  sql_table_name: tim_thesis.song_audio_features ;;

  parameter: artist_name_selector {
    type: string
  }

  dimension: Artist_Cohort_Yesno {
    type: yesno
    sql: ${song_list.artist_name} =  {% parameter artist_name_selector %};;
    hidden: yes
  }


  dimension: acousticness {
    type: number
    sql: ${TABLE}.acousticness ;;
    description: "A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic. "
  }

  dimension: danceability {
    type: number
    sql: ${TABLE}.danceability ;;
    description: "Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable. "
  }

  dimension: energy {
    type: number
    sql: ${TABLE}.energy ;;
    description: "Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. "
  }

  dimension: instrumentalness {
    type: number
    sql: ${TABLE}.instrumentalness ;;
    description: "Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0."
  }

  dimension: key {
    type: number
    sql: ${TABLE}.key ;;

  }

  dimension: song_id {
    type: string
    sql: ${TABLE}.song_id ;;
    primary_key: yes

  }

  dimension: speechiness {
    type: number
    sql: ${TABLE}.speechiness ;;
    description: "float Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks. "
  }

  dimension: tempo {
    type: number
    sql: ${TABLE}.tempo ;;
    value_format: "0"
  }

  dimension: valence {
    type: number
    sql: ${TABLE}.valence ;;
    description: "A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry). "
  }

  ### THESE MEASURES ARE FOR COHORT ANALYSIS TEST ###
measure: Selected_artist_avg_danceability {
  type: average
  sql: ${danceability} ;;
  filters: {
    field: Artist_Cohort_Yesno
    value: "yes"
  }
  label: "{% parameter artist_name_selector %}s Danceability"
}
  measure: other_artist_avg_danceability {
    type: average
    sql: ${danceability} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Danceability"
  }

  measure: Selected_artist_avg_valence {
    type: average
    sql: ${valence} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "yes"
    }
    label: "{% parameter artist_name_selector %}s Valence"
  }
  measure: other_artist_avg_valence {
    type: average
    sql: ${valence} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Valence"
  }

  measure: Selected_artist_avg_acousticness {
    type: average
    sql: ${acousticness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "yes"
    }
    label: "{% parameter artist_name_selector %}s Acousticness"
  }
  measure: other_artist_avg_acousticness {
    type: average
    sql: ${acousticness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Acousticness"
  }
  measure: Selected_artist_avg_energy{
    type: average
    sql: ${energy} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "yes"
    }
    label: "{% parameter artist_name_selector %}s Energy"
  }
  measure: other_artist_avg_energy{
    type: average
    sql: ${energy} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Energy"
  }

  measure: Selected_artist_avg_instrumentalness {
    type: average
    sql: ${instrumentalness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "yes"
    }
    label: "{% parameter artist_name_selector %}s Instrumentalness"
  }
  measure: other_artist_avg_instrumentalness {
    type: average
    sql: ${instrumentalness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Instrumentalness"
  }
  measure: Selected_artist_avg_speechiness {
    type: average
    sql: ${speechiness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "yes"
    }
    label: "{% parameter artist_name_selector %}s Speechiness"
  }
  measure: other_artist_avg_speechiness {
    type: average
    sql: ${speechiness} ;;
    filters: {
      field: Artist_Cohort_Yesno
      value: "no"
    }
    label: "Other Artists' Speechiness"
  }


 }
