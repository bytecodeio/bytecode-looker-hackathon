view: looks {
  sql_table_name: LOOKER.LOOKS ;;
  drill_fields: [detail*]

  dimension: id {
    group_label: "Keys/IDs"
    label: "Look ID"
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

  dimension: content_metadata_id {
    group_label: "Keys/IDs"
    label: "Content Metadata ID"
    type: string
    sql: ${TABLE}.CONTENT_METADATA_ID ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: deleted {
    label: "Is Deleted"
    type: yesno
    sql: ${TABLE}.DELETED ;;
  }

  dimension: description {
    label: "Look Description"
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: embed_url {
    group_label: "URLs"
    label: "Embed URL"
    type: string
    sql: ${TABLE}.EMBED_URL ;;
  }

  dimension: excel_file_url {
    group_label: "URLs"
    label: "Excel File URL"
    type: string
    sql: ${TABLE}.EXCEL_FILE_URL ;;
  }

  dimension: explore_link {
    type: string
    sql: ${id} ;;
    html: <a style="color:#49719a;font-size:12px" href="/embed/looks/{{ value }}/explore">Explore From Here</a> ;;
  }

  dimension: favorite_count {
    label: "Favorite Count"
    type: number
    sql: ${TABLE}.FAVORITE_COUNT ;;
  }

  dimension: folder {
    label: "Folder JSON"
    type: string
    sql: ${TABLE}.FOLDER ;;
    hidden: yes
  }

  dimension: folder_id {
    group_label: "Keys/IDs"
    label: "Folder ID"
    type: string
    sql: ${folder}:id ;;
  }

  dimension: google_spreadsheet_formula {
    label: "Google Spreadsheet Formula"
    type: string
    sql: ${TABLE}.GOOGLE_SPREADSHEET_FORMULA ;;
  }

  dimension: image_embed_url {
    group_label: "URLs"
    label: "Image Embed URL"
    type: string
    sql: ${TABLE}.IMAGE_EMBED_URL ;;
  }

  dimension: is_run_on_load {
    label: "Is Run on Load"
    type: yesno
    sql: ${TABLE}.IS_RUN_ON_LOAD ;;
  }

  dimension_group: last_accessed {
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
    sql: ${TABLE}.LAST_ACCESSED_AT ;;
  }

  dimension: last_updater_id {
    group_label: "Keys/IDs"
    label: "Last Updater ID"
    type: string
    sql: ${TABLE}.LAST_UPDATER_ID ;;
  }

  dimension_group: last_viewed {
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
    sql: ${TABLE}.LAST_VIEWED_AT ;;
  }

  dimension: model {
    label: "Model JSON"
    type: string
    sql: ${TABLE}.MODEL ;;
    hidden: yes
  }

  dimension: model_id {
    label: "Model ID"
    type: string
    sql: ${model}:id ;;
  }

  dimension: model_label {
    label: "Model Label"
    type: string
    sql: TRIM(REPLACE(${model}:label,'"')) ;;
  }

  dimension: public {
    label: "Is Public"
    type: yesno
    sql: ${TABLE}.PUBLIC ;;
  }

  dimension: public_slug {
    group_label: "Keys/IDs"
    label: "Public Slug"
    type: string
    sql: ${TABLE}.PUBLIC_SLUG ;;
  }

  dimension: public_url {
    group_label: "URLs"
    label: "Public URL"
    type: string
    sql: ${TABLE}.PUBLIC_URL ;;
  }

  dimension: query_id {
    group_label: "Keys/IDs"
    label: "Query ID"
    type: string
    sql: ${TABLE}.QUERY_ID ;;
  }

  dimension: short_url {
    group_label: "URLs"
    label: "Short URL"
    type: string
    sql: ${TABLE}.SHORT_URL ;;
    hidden: yes
  }

  dimension: short_url_2 {
    label: "Short URL"
    type: string
    sql: '/dashboards/' || ${id} ;;
    hidden: no
  }

  dimension: space {
    label: "Space"
    type: string
    sql: ${TABLE}.SPACE ;;
  }

  dimension: space_id {
    group_label: "Keys/IDs"
    label: "Space ID"
    type: string
    sql: ${TABLE}.SPACE_ID ;;
  }

  dimension: space_name {
    label: "Space Name"
    type: string
    sql: ${space}:name ;;
  }

  dimension: list_title {
    label: "List Title Block"
    type: string
    sql: ${title} ;;
    html: <div>
      <div><a style="color: #1c2027;font-size: 14px;" href="/embed/looks/{{ looks.id._value }}">{{value}}</a></div>
    <div><a style="color: #7f7977;font-size: 12px;" href="/embed/looks/{{ looks.id._value }}">{{ looks.description._value }}</a></div>
    <div><a style="color: #7f7977;font-size: 12px;" href="/embed/looks/{{ looks.id._value }}">
    {{ content_views.total_views._rendered_value }} Views
    {% if content_views.total_favorites._value > 0 %}
      , {{ content_views.total_favorites._value }} Favorite
      {% endif %}
    , Created by {{ create_user.display_name._value }}
    </a></div>
    </div>;;
  }

  dimension: thumbnail {
    label: "Look Thumbnail"
    type: string
    sql: ${id} ;;
    html: <a href="/looks/{{ value }}">
      <img style="width:83px;height:55px;" src="https://bytecode.looker.com/api/internal/vector_thumbnail/look/{{value}}" />
      </a><br /><br />;;
  }

  dimension: title {
    label: "Look Title"
    type: string
    sql: ${TABLE}.TITLE ;;
    link: {
      label: "Open Look"
      url: "{{ short_url_2._value }}"
    }
  }

  dimension_group: updated {
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
    sql: ${TABLE}.UPDATED_AT ;;
  }

  dimension_group: last_updated {
    type: duration
    sql_start: ${updated_time} ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }

  dimension: last_updated_ago {
    type: string
    sql: CASE
      WHEN ${months_last_updated} >= 1 THEN CONCAT(${months_last_updated}, ' months ago')
      WHEN ${days_last_updated} >= 1 THEN CONCAT(${days_last_updated}, ' days ago')
      ELSE CONCAT(${hours_last_updated}, ' hours ago')
      END
    ;;
    html: <span style="color:#1C2027;font-size:12px;font-family:'Open Sans','Noto Sans JP','Noto Sans','Noto Sans CJK KR',Helvetica,Arial,sans-serif;">{{value}}</span> ;;
  }

  dimension: user {
    label: "User JSON"
    type: string
    sql: ${TABLE}.USER ;;
    hidden: yes
  }

  dimension: user_id {
    group_label: "Keys/IDs"
    label: "User ID"
    type: string
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: view_count {
    group_label: "Numerical Dimensions"
    label: "View Count"
    type: number
    sql: ${TABLE}.VIEW_COUNT ;;
  }

  measure: count {
    label: "Number of Looks"
    type: count
    drill_fields: [detail*]
  }

  measure: total_favorites {
    label: "Total Favorites"
    type: sum
    sql: ${favorite_count} ;;
  }

  measure: total_views {
    label: "Total Views"
    type: sum
    sql: ${view_count} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      content_metadata.id,
      content_metadata.name,
      spaces.id,
      spaces.name,
      users.display_name,
      users.first_name,
      users.id,
      users.last_name,
      content_metadata.count,
      dashboard_elements.count
    ]
  }
}
