view: content_metadata {
  view_label: "Content Metadata"
  sql_table_name: LOOKER.CONTENT_METADATA ;;
  drill_fields: [detail*]

  dimension: id {
    group_label: "Keys/IDs"
    label: "Content Metadata ID"
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension_group: _sdc_batched {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_BATCHED_AT ;;
    hidden: yes
  }

  dimension_group: _sdc_extracted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_EXTRACTED_AT ;;
    hidden: yes
  }

  dimension_group: _sdc_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_RECEIVED_AT ;;
    hidden: yes
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._SDC_SEQUENCE ;;
    hidden: yes
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._SDC_TABLE_VERSION ;;
    hidden: yes
  }

  dimension: content_type {
    label: "Content Type"
    type: string
    sql: ${TABLE}.CONTENT_TYPE ;;
  }

  dimension: dashboard_id {
    group_label: "Keys/IDs"
    label: "Dashboard ID"
    type: string
    sql: ${TABLE}.DASHBOARD_ID ;;
  }

  dimension: inheriting_id {
    group_label: "Keys/IDs"
    label: "Inheriting ID"
    type: string
    sql: ${TABLE}.INHERITING_ID ;;
  }

  dimension: inherits {
    label: "Inherits"
    type: yesno
    sql: ${TABLE}.INHERITS ;;
  }

  dimension: look_id {
    group_label: "Keys/IDs"
    label: "Look ID"
    type: string
    sql: ${TABLE}.LOOK_ID ;;
  }

  dimension: name {
    label: "Content Name"
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: parent_id {
    group_label: "Keys/IDs"
    label: "Parent ID"
    type: string
    sql: ${TABLE}.PARENT_ID ;;
  }

  dimension: slug {
    group_label: "Keys/IDs"
    label: "Slug"
    type: string
    sql: ${TABLE}.SLUG ;;
  }

  dimension: space_id {
    group_label: "Keys/IDs"
    label: "Space ID"
    type: string
    # hidden: yes
    sql: ${TABLE}.SPACE_ID ;;
  }

  measure: count {
    label: "Number of Contents"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      content_type,
      spaces.name,
      folders.name,
      content_metadata_access.count,
      dashboards.count,
      folders.count,
      homepages.count,
      looks.count,
      spaces.count
    ]
  }
}
