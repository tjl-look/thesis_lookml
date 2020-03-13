view: song_audio_features {
  sql_table_name: tim_thesis.song_audio_features ;;

  dimension: Morning_Afternoon {
    type: yesno
    sql: ${kt_listening_history.hour_played} IN (7,8,9,10,11) ;;
  }
  filter: test {
    type: date
  }

  parameter: Measure_Select{
    type: string
    allowed_value: {
      label: "Acousticness"
      value: "acousticness"
    }
    allowed_value: {
      label: "Danceability"
      value: "danceability"
    }
    allowed_value: {
      label: "Energy"
      value: "energy"
    }
    allowed_value: {
      label: "Valence"
      value: "valence"
    }
    allowed_value: {
      label: "Instrumentalness"
      value: "instrumentalness"
    }
    allowed_value: {
      label: "Speechiness"
      value: "speechiness"
    }
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
    drill_fields: [song_id]
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


  dimension: dynamic_tier {
    type: tier
    style: interval
    tiers: [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
    sql: CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
              WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
              WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
              WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
              WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
              WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
    END;;
    label_from_parameter: Measure_Select
  }

  dimension: dynamic_dimension{
    type: number
    sql: CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
              WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
              WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
              WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
              WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
              WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
         END;;
    label_from_parameter: Measure_Select
    link: {
      label: "Drill to Song Information"
      url: "https://dcl.dev.looker.com/dashboards/531?Song Title={{ kt_listening_history.song_name._rendered_value }}"
    }
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: avg_danceability {
    type: average
    sql: ${danceability} ;;
  }

  measure: avg_valence {
    type: average
    sql: ${valence} ;;
  }

  measure: avg_tempo {
    type: average
    sql: ${tempo} ;;
  }

  measure: avg_energy {
    type: average
    sql: ${energy} ;;
  }
  measure: avg_instrumentalness {
    type: average
    sql:  ${instrumentalness} ;;
  }
  measure: avg_acousticness {
    type: average
    sql: ${acousticness} ;;
  }
  #######----------------------#######

  measure: dynamic_measure_average_morning{
    type: average_distinct
    sql: (CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
    WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
    WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
    WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
    WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
    WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
    END);;
    filters: {
      field: Morning_Afternoon
      value: "yes"
    }
    value_format_name: decimal_4
  }

   measure: dynamic_measure_average_afternoon{
    type: average_distinct
    sql: (CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
          WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
          WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
          WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
          WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
          WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
          END);;
    filters: {
      field: Morning_Afternoon
      value: "no"
    }

    value_format_name: decimal_4

  }
    measure: dynamic_stddev_morning {
    type:  number
    sql: 1.0 * STDDEV_POP(CASE WHEN ${Morning_Afternoon} THEN
                              CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
                                    WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
                                    WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
                                    WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
                                    WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
                                    WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
                                    END
                               ELSE NULL END) ;;
    value_format_name: decimal_4
    }
    measure: dynamic_stddev_afternoon {
      type:  number
      sql: 1.0 * STDDEV_POP(CASE WHEN NOT ${Morning_Afternoon} THEN
                              CASE WHEN  {% parameter Measure_Select  %} = 'danceability' THEN ${danceability}
                                    WHEN  {% parameter Measure_Select  %} = 'valence' THEN ${valence}
                                    WHEN  {% parameter Measure_Select  %} = 'energy' THEN ${energy}
                                    WHEN  {% parameter Measure_Select  %} = 'instrumentalness' THEN ${instrumentalness}
                                    WHEN  {% parameter Measure_Select  %} = 'acousticness' THEN ${acousticness}
                                    WHEN  {% parameter Measure_Select  %} = 'speechiness' THEN ${speechiness}
                                    END
                               ELSE NULL END) ;;
      value_format_name: decimal_4
    }

  measure: t_score {
    type: number
    sql:
      1.0 * (${dynamic_measure_average_morning} - ${dynamic_measure_average_afternoon}) /
      SQRT(
      (POWER(${dynamic_stddev_morning},2) / ${kt_listening_history.count_m}) + (POWER(${dynamic_stddev_afternoon},2) / ${kt_listening_history.count_a})
      ) ;;
    value_format_name: decimal_2
  }
  measure: significance {
    sql:
      CASE
       WHEN (ABS(${t_score}) > 3.291) THEN '(7) .0005 sig. level'
       WHEN (ABS(${t_score}) > 3.091) THEN '(6) .001 sig. level'
       WHEN (ABS(${t_score}) > 2.576) THEN '(5) .005 sig. level'
       WHEN (ABS(${t_score}) > 2.326) THEN '(4) .01 sig. level'
       WHEN (ABS(${t_score}) > 1.960) THEN '(3) .025 sig. level'
       WHEN (ABS(${t_score}) > 1.645) THEN '(2) .05 sig. level'
       WHEN (ABS(${t_score}) > 1.282) THEN '(1) .1 sig. level'
       ELSE '(0) Insignificant'
      END ;;
  }

  dimension: randomizer {
    sql: RAND() ;;
    type: number
  }

 #variance measures
  measure: Morning_Variance_Danceability{
    sql: POWER(STDDEV_POP(CASE WHEN ${Morning_Afternoon} THEN ${danceability} ELSE NULL END),2);;
    type: number
  }
  measure: Afternoon_Variance_Danceability{
    sql: POWER(STDDEV_POP(CASE WHEN NOT ${Morning_Afternoon} THEN ${danceability} ELSE NULL END),2);;
    type: number
  }
  measure: Morning_Variance_Valence{
    sql: POWER(STDDEV_POP(CASE WHEN ${Morning_Afternoon} THEN ${valence} ELSE NULL END),2);;
    type: number
  }
  measure: Afternoon_Variance_Valence{
    sql: POWER(STDDEV_POP(CASE WHEN NOT ${Morning_Afternoon} THEN ${valence} ELSE NULL END),2);;
    type: number
  }
  measure: Morning_Variance_Energy{
    sql: POWER(STDDEV_POP(CASE WHEN ${Morning_Afternoon} THEN ${energy} ELSE NULL END),2);;
    type: number
  }
  measure: Afternoon_Variance_Energy{
    sql: POWER(STDDEV_POP(CASE WHEN NOT ${Morning_Afternoon} THEN ${energy} ELSE NULL END),2);;
    type: number
  }
  measure: Morning_Variance_Instrumentalness{
    sql: POWER(STDDEV_POP(CASE WHEN ${Morning_Afternoon} THEN ${instrumentalness} ELSE NULL END),2);;
    type: number
  }
  measure: Afternoon_Variance_Instrumentalness{
    sql: POWER(STDDEV_POP(CASE WHEN NOT ${Morning_Afternoon} THEN ${instrumentalness} ELSE NULL END),2);;
    type: number
  }




}
