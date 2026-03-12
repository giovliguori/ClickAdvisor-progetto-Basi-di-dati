prompt --application/pages/page_00007
begin
--   Manifest
--     PAGE: 00007
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.0'
,p_default_workspace_id=>9000669391213301
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'AMMINISTRATORE_DB'
);
wwv_flow_imp_page.create_page(
 p_id=>7
,p_name=>'Dashboard'
,p_alias=>'DASHBOARD'
,p_step_title=>'Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'04'
,p_last_updated_by=>'MODERATORE'
,p_last_upd_yyyymmddhh24miss=>'20260310003925'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10663654289221828)
,p_plug_name=>'Numero iscritti cumulativi per mese'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(10518441582221296)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'UTENTE'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(10664067411221828)
,p_region_id=>wwv_flow_imp.id(10663654289221828)
,p_chart_type=>'area'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(10665760230221839)
,p_chart_id=>wwv_flow_imp.id(10664067411221828)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    TRUNC("Data_iscrizione", ''MM'') AS MESE, ',
'    COUNT(*) AS NUOVI_ISCRITTI,',
'    SUM(COUNT(*)) OVER (ORDER BY TRUNC("Data_iscrizione", ''MM'')) AS TOTALE_CUMULATIVO',
'FROM "UTENTE"',
'GROUP BY TRUNC("Data_iscrizione", ''MM'')',
'ORDER BY MESE;'))
,p_max_row_count=>500
,p_items_value_column_name=>'TOTALE_CUMULATIVO'
,p_items_label_column_name=>'MESE'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10665109799221837)
,p_chart_id=>wwv_flow_imp.id(10664067411221828)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Numero iscritti'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10664543834221832)
,p_chart_id=>wwv_flow_imp.id(10664067411221828)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Mesi'
,p_format_type=>'date-short'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10666313192221843)
,p_plug_name=>'Distribuzione etichette nelle foto'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(10518441582221296)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_query_type=>'TABLE'
,p_query_table=>'FOTO'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(10666752918221843)
,p_region_id=>wwv_flow_imp.id(10666313192221843)
,p_chart_type=>'pie'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'auto'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_title=>'Legenda'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(10667289457221846)
,p_chart_id=>wwv_flow_imp.id(10666752918221843)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    "Etichetta", ',
'    COUNT(*) AS QUANTITA',
'FROM "FOTO"',
'GROUP BY "Etichetta"',
'ORDER BY QUANTITA DESC;'))
,p_max_row_count=>20
,p_items_value_column_name=>'QUANTITA'
,p_items_label_column_name=>'Etichetta'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10667871041221848)
,p_plug_name=>'Andamento check-in durante la giornata'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(10518441582221296)
,p_plug_display_sequence=>30
,p_query_type=>'TABLE'
,p_query_table=>'CHECKIN'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(10668263249221850)
,p_region_id=>wwv_flow_imp.id(10667871041221848)
,p_chart_type=>'line'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_show_row=>true
,p_show_start=>true
,p_show_end=>true
,p_show_progress=>true
,p_show_baseline=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>true
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(10669911851221854)
,p_chart_id=>wwv_flow_imp.id(10668263249221850)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    TO_CHAR("Timestamp", ''HH24'') AS FASCIA_ORARIA, ',
'    COUNT(*) AS NUMERO_CHECKIN',
'FROM "CHECKIN"',
'GROUP BY TO_CHAR("Timestamp", ''HH24'')',
'ORDER BY FASCIA_ORARIA;'))
,p_max_row_count=>24
,p_items_value_column_name=>'NUMERO_CHECKIN'
,p_items_label_column_name=>'FASCIA_ORARIA'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10668788649221851)
,p_chart_id=>wwv_flow_imp.id(10668263249221850)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Fasce orarie'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10669304141221853)
,p_chart_id=>wwv_flow_imp.id(10668263249221850)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Numero check-in'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10670544419221856)
,p_plug_name=>'Valutazione media per categoria'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(10518441582221296)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_query_type=>'TABLE'
,p_query_table=>'CATEGORIA'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(10670918998221856)
,p_region_id=>wwv_flow_imp.id(10670544419221856)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'delayedScrollOnly'
,p_initial_zooming=>'none'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_overview_rendered=>'on'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(10672696525221860)
,p_chart_id=>wwv_flow_imp.id(10670918998221856)
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    C."Nome" AS CATEGORIA, ',
'    ROUND(AVG(A."Stelle"), 2) AS VALUTAZIONE_MEDIA',
'FROM "CATEGORIA" C',
'JOIN "APPARTIENE_A" AA ON C."ID_Categoria" = AA."ID_Categoria"',
'JOIN "ATTIVITA" A ON AA."ID_Attivita" = A."ID_Attivita"',
'GROUP BY C."Nome"',
'ORDER BY CATEGORIA ASC;'))
,p_max_row_count=>100
,p_items_value_column_name=>'VALUTAZIONE_MEDIA'
,p_items_label_column_name=>'CATEGORIA'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10671498214221857)
,p_chart_id=>wwv_flow_imp.id(10670918998221856)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_title=>'Categorie'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(10672066831221857)
,p_chart_id=>wwv_flow_imp.id(10670918998221856)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_title=>'Valutazione media'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10673351604221862)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(10530814931221318)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(10415783613221084)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(10592954292221446)
);
wwv_flow_imp.component_end;
end;
/
