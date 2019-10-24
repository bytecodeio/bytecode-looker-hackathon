view: models__explores__joins__views {
  view_label: "Joins"
  derived_table: {
    sql: SELECT
      A.GIT_OWNER,
      A.GIT_REPOSITORY,
      A.MODEL_PATH,
      A.MODEL_KEY,
      A.EXPLORE_NAME,
      A.EXPLORE_KEY,
      A.VIEW_NAME,
      A.JOIN_NAME,
      A.JOIN_JSON,
      A.JOIN_VIEW_TYPE,
      COALESCE(B.REQUIRED, FALSE) AS JOIN_REQUIRED
      FROM
      (
      -- BASE VIEWS
      SELECT
        models.GIT_OWNER,
        models.GIT_REPOSITORY,
        models.PATH AS MODEL_PATH,
        ex.value:name::varchar  AS EXPLORE_NAME,
        COALESCE((ex.value:from::varchar), (ex.value:view_name::varchar), (ex.value:name::varchar))  AS VIEW_NAME,
        NULL AS JOIN_NAME,
        NULL AS JOIN_JSON,
        'BASE VIEW' AS JOIN_VIEW_TYPE,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH) AS MODEL_KEY,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH  || '-' || ex.value:name::varchar) AS EXPLORE_KEY
      FROM LOOKML.MODEL_FILES  AS model_files
      LEFT JOIN LOOKML.MODELS  AS models ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      GROUP BY 1,2,3,4,5,6,7,8,9,10
      UNION
      -- JOINED VIEWS
      SELECT
        models.GIT_OWNER,
        models.GIT_REPOSITORY,
        models.PATH  AS MODEL_PATH,
        ex.value:name::varchar  AS EXPLORE_NAME,
        COALESCE((j.value:from::varchar), (j.value:name::varchar))  AS VIEW_NAME,
        j.value:name::varchar AS JOIN_NAME,
        j.value::variant AS JOIN_JSON,
        'JOINED VIEW' AS JOIN_VIEW_TYPE,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH) AS MODEL_KEY,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH  || '-' || ex.value:name::varchar) AS EXPLORE_KEY
      FROM LOOKML.MODEL_FILES  AS model_files
      LEFT JOIN LOOKML.MODELS  AS models ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      , lateral flatten(input => ex.value:joins) j
      GROUP BY 1,2,3,4,5,6,7,8,9,10) A
      LEFT JOIN
      (
      SELECT
        models.GIT_OWNER,
        models.GIT_REPOSITORY,
        models.PATH  AS MODEL_PATH,
        ex.value:name::varchar  AS EXPLORE_NAME,
        jrj.value::varchar  AS VIEW_NAME,
        TRUE AS REQUIRED
      FROM LOOKML.MODEL_FILES  AS model_files
      LEFT JOIN LOOKML.MODELS  AS models ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      , lateral flatten(input => ex.value:joins) j
      , lateral flatten(input => j.value:required_joins) jrj
      GROUP BY 1,2,3,4,5
      ) B
      ON A.GIT_OWNER = B.GIT_OWNER
      AND A.GIT_REPOSITORY = B.GIT_REPOSITORY
      AND A.MODEL_PATH = B.MODEL_PATH
      AND A.EXPLORE_NAME = B.EXPLORE_NAME
      AND A.VIEW_NAME = B.VIEW_NAME
       ;;
  }

  dimension: explore_join_view_pk {
    label: "Explore Join View PK"
    type: string
    primary_key: yes
    hidden: yes
    sql: ${join_key} || '-' || ${view_name} ;;
  }

  dimension: model_key {
    label: "Model Key"
    type: string
    hidden: yes
    sql: ${TABLE}.MODEL_KEY ;;
  }

  dimension: explore_key {
    label: "Explore Key"
    type: string
    hidden: yes
    sql: ${TABLE}.EXPLORE_KEY  ;;
  }

  dimension: join_key {
    label: "Join Key"
    type: string
    hidden: yes
    sql: CASE WHEN ${join_name} IS NOT NULL THEN ${explore_key} || '-' || ${join_name}
          ELSE NULL END ;;
  }

  dimension: view_key {
    label: "View Key"
    type: string
    hidden: yes
    sql: ${git_owner} || '-' || ${git_repository} || '-' || ${view_name} ;;
  }

  dimension: explore_name {
    label: "Explore Name"
    type: string
    sql: ${TABLE}.EXPLORE_NAME ;;
    hidden: yes
  }

  dimension: git_owner {
    group_label: "Git"
    label: "Git Owner"
    type: string
    sql: ${TABLE}.GIT_OWNER ;;
  }

  dimension: git_repository {
    label: "Git Repository"
    type: string
    sql: ${TABLE}.GIT_REPOSITORY ;;
  }

  dimension: join_json {
    label: "Join JSON"
    type: string
    sql: ${TABLE}.JOIN_JSON ;;
    hidden: yes
  }

  dimension: join_name {
    label: "Join Name"
    type: string
    sql: ${TABLE}.JOIN_NAME ;;
  }

  dimension: join_required {
    label: "Join Required"
    type: string
    sql: ${TABLE}.JOIN_REQUIRED ;;
  }

  dimension: join_view_type {
    label: "Join View Type"
    type: string
    sql: ${TABLE}.JOIN_VIEW_TYPE ;;
  }

  dimension: model_path {
    group_label: "Git"
    label: "Model Path"
    type: string
    sql: ${TABLE}.MODEL_PATH ;;
  }

  dimension: view_name {
    label: "View Name"
    type: string
    sql: ${TABLE}.VIEW_NAME ;;
    hidden: yes
  }



  dimension: fields {
    group_label: "Fields"
    label: "Fields JSON"
    type: string
    sql: ${join_json}:fields::variant ;;
    hidden: yes
  }

  dimension: fields_list {
    group_label: "Fields"
    label: "Fields List"
    type: string
    sql:array_to_string(parse_json(${fields}), ', ') ;;
  }

  dimension: foreign_key {
    label: "Foreign Key"
    type: string
    sql: ${join_json}:foreign_key::varchar ;;
  }

  dimension: from {
    label: "From"
    type: string
    sql: ${join_json}:"from"::varchar ;;
  }

  dimension: join_view_name {
    label: "Join View Name"
    type: string
    sql: COALESCE(${from}, ${name}) ;;
  }

  dimension: name {
    label: "Join Name"
    type: string
    sql: ${join_json}:name::varchar ;;
    hidden: yes
  }

  dimension: outer_only {
    label: "Outer Only"
    type: string
    sql: ${join_json}:outer_only::varchar ;;
  }

  dimension: outer_only_yn {
    group_label: "YesNo"
    label: "Outer Only"
    type: string
    sql: ${outer_only} = 'yes' ;;
  }

  dimension: relationship {
    label: "Relationship"
    type: string
    sql: ${join_json}:relationship::varchar ;;
  }

  dimension: required_access_grants {
    group_label: "Required Access Grants"
    label: "Required Access Grants JSON"
    type: string
    sql: ${join_json}:required_access_grants::variant ;;
    hidden: yes
  }

  dimension: required_access_grants_list {
    group_label: "Required Access Grants"
    label: "Required Access Grants List"
    type: string
    sql:array_to_string(parse_json(${required_access_grants}), ', ') ;;
  }

  dimension: required_joins {
    group_label: "Required Joins"
    label: "Required Joins"
    type: string
    sql: ${join_json}:required_joins::variant ;;
    hidden: yes
  }

  dimension: required_joins_list {
    group_label: "Required Joins"
    label: "Required Joins List"
    type: string
    sql:array_to_string(parse_json(${required_joins}), ', ') ;;
  }

  dimension: sql_foreign_key {
    group_label: "SQL"
    label: "SQL Foreign Key"
    type: string
    sql: ${join_json}:sql_foreign_key::varchar ;;
  }

  dimension: sql_on {
    group_label: "SQL"
    label: "SQL On"
    type: string
    sql: ${join_json}:sql_on::varchar ;;
  }

  dimension: sql_table_name {
    group_label: "SQL"
    label: "SQL Table Name"
    type: string
    sql: ${join_json}:sql_table_name::varchar ;;
  }

  dimension: sql_where {
    group_label: "SQL"
    label: "SQL Where"
    type: string
    sql: ${join_json}:sql_where::varchar ;;
  }

  dimension: type {
    label: "Type"
    type: string
    sql: ${join_json}:type::varchar ;;
  }

  dimension: view_label {
    label: "View Label"
    type: string
    sql: ${join_json}:view_label::varchar ;;
  }

  measure: count {
    label: "Number of Joins"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      git_owner,
      git_repository,
      model_path,
      model_files.model_name,
      explore_name,
      join_name,
      view_name,
      join_view_type,
      join_required,
      type,
      from,
      relationship,
      view_label,
      foreign_key,
      sql_table_name,
      sql_on,
      sql_foreign_key,
      sql_where
    ]
  }

}