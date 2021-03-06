view: spaces {
  view_label: "Spaces"
  sql_table_name: LOOKER.SPACES ;;
  drill_fields: [detail*]

  dimension: id {
    group_label: "Keys/IDs"
    label: "Space ID"
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

  dimension: child_count {
    label: "Child Count"
    type: number
    sql: ${TABLE}.CHILD_COUNT ;;
  }

  dimension: content_metadata_id {
    group_label: "Keys/IDs"
    label: "Content Metadata ID"
    type: string
    sql: ${TABLE}.CONTENT_METADATA_ID ;;
  }

  dimension: creator_id {
    group_label: "Keys/IDs"
    label: "Creator ID"
    type: string
    sql: ${TABLE}.CREATOR_ID ;;
  }

  dimension: is_embed {
    group_label: "Indicators"
    label: "Is Embed"
    type: yesno
    sql: ${TABLE}.IS_EMBED ;;
  }

  dimension: is_embed_shared_root {
    group_label: "Indicators"
    label: "Is Embed Shared Root"
    type: yesno
    sql: ${TABLE}.IS_EMBED_SHARED_ROOT ;;
  }

  dimension: is_embed_users_root {
    group_label: "Indicators"
    label: "Is Embed Users Root"
    type: yesno
    sql: ${TABLE}.IS_EMBED_USERS_ROOT ;;
  }

  dimension: is_personal {
    group_label: "Indicators"
    label: "Is Personal"
    type: yesno
    sql: ${TABLE}.IS_PERSONAL ;;
  }

  dimension: is_personal_descendant {
    group_label: "Indicators"
    label: "Is Personal Descendant"
    type: yesno
    sql: ${TABLE}.IS_PERSONAL_DESCENDANT ;;
  }

  dimension: is_shared_root {
    group_label: "Indicators"
    label: "Is Shared Root"
    type: yesno
    sql: ${TABLE}.IS_SHARED_ROOT ;;
  }

  dimension: is_users_root {
    group_label: "Indicators"
    label: "Is Users Root"
    type: yesno
    sql: ${TABLE}.IS_USERS_ROOT ;;
  }

  dimension: name {
    label: "Space Name"
    type: string
    sql: ${TABLE}.NAME ;;
    link: {
      label: "Open in Looker"
      url: "{{ short_url._value }}"
    }
  }

  dimension: name_breadcrumb {
    type: string
    sql: ${name} ;;
    html: {% if parent_space.name._value | strip != "" %}<a style="color:#49719a;font-size:21px;" href="/embed/dashboards/71?Parent%20Space={{ spaces.parent_id._rendered_value }}">{{ parent_space.name._value }}</a> <span style="font-size:21px;color:#d3d3d3;">></span> {% endif %}<span style="font-size:21px;color:#1c2027">{{ value }}</span> ;;
  }

  dimension: name_button {
      sql: ${name} ;;
      html: <a style="display:block;width:200px;height:40px;font-size:14px;font-weight:400;box-shadow: rgba(0, 0, 0, 0.08) 0px 1px 8px, rgba(0, 0, 0, 0.05) 0px 1px 1px;border:1px solid rgb(222, 225, 229);color: rgb(38, 45, 51);background-color:#ffffff;border-radius:4px;text-align:left;padding-left:15px;" href="/embed/dashboards/71?Parent%20Space={{ spaces.id._value }}">{{rendered_value}}</a> ;;
  }

  dimension: parent_id {
    group_label: "Keys/IDs"
    label: "Parent Space ID"
    type: string
    sql: COALESCE(${TABLE}."PARENT_ID",'0') ;;
  }

  dimension: short_url {
    label: "Short URL"
    type: string
    sql: '/spaces/' || ${id} ;;
  }

  measure: count {
    label: "Number of Spaces"
    type: count
    drill_fields: [detail*]
  }

  measure: number_of_children {
    type: sum
    sql: ${child_count} ;;
  }


  # ----- Sets of fields for drilling ------

  set: detail {
    fields: [
      id,
      name,
      parent.name
    ]
  }
}
