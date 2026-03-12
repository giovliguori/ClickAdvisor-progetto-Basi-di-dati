prompt --application/pages/page_00005
begin
--   Manifest
--     PAGE: 00005
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
 p_id=>5
,p_name=>'Recensioni'
,p_alias=>'RECENSIONI'
,p_step_title=>'Recensioni'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_imp.id(10429030507221142)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
,p_last_updated_by=>'MODERATORE'
,p_last_upd_yyyymmddhh24miss=>'20260309120711'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10650767142221768)
,p_plug_name=>'Search Results'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(10459597811221196)
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    A."Nome" AS TITOLO_ATTIVITA,',
'    R."Stelle" AS SOTTOTITOLO,',
'    R."Testo" AS CORPO_RECENSIONE,',
'    R."Data" AS DATA_RECENSIONE,',
'    R."Num_cool",',
'    R."Num_funny",',
'    R."Num_useful",',
'    R."ID_Recensione",',
'    U."Nome"',
'FROM "RECENSIONE" R',
'JOIN "ATTIVITA" A ON R."ID_Attivita" = A."ID_Attivita"',
'JOIN "UTENTE" U ON R."ID_Utente" = U."ID_Utente";'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>'{"orderBys":[{"key":"Recenti","expr":"DATA_RECENSIONE desc"},{"key":"Stelle","expr":"SOTTOTITOLO desc"},{"key":"TITOLO_ATTIVITA","expr":"TITOLO_ATTIVITA asc"}],"itemName":"P5_ORDER_BY"}'
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows_type=>'SCROLL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_show_total_row_count=>false
,p_pagination_display_position=>'BOTTOM_RIGHT'
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(10655034454221790)
,p_region_id=>wwv_flow_imp.id(10650767142221768)
,p_layout_type=>'GRID'
,p_title_adv_formatting=>false
,p_title_column_name=>'TITOLO_ATTIVITA'
,p_sub_title_adv_formatting=>true
,p_sub_title_html_expr=>'&"Nome"., &DATA_RECENSIONE.'
,p_body_adv_formatting=>false
,p_body_column_name=>'CORPO_RECENSIONE'
,p_second_body_adv_formatting=>true
,p_second_body_html_expr=>'Cool: &"Num_cool"., Funny: &"Num_funny"., Useful: &"Num_useful".'
,p_icon_source_type=>'INITIALS'
,p_icon_class_column_name=>'SOTTOTITOLO'
,p_icon_position=>'START'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'ID_Recensione'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10650803072221768)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(10518441582221296)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(10650767142221768)
,p_landmark_label=>'Filters'
,p_attribute_01=>'N'
,p_attribute_06=>'E'
,p_attribute_08=>'#active_facets'
,p_attribute_09=>'Y'
,p_attribute_12=>'10000'
,p_attribute_13=>'Y'
,p_attribute_15=>'10'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10653840352221781)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(10455286737221190)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>'<div id="active_facets"></div>'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10655979299221792)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(10654360387221784)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(10653840352221781)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(10591484816221443)
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:RR,5::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10651315205221768)
,p_name=>'P5_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(10650803072221768)
,p_prompt=>'Search'
,p_source=>'ID_Recensione,Testo,ID_Utente,ID_Attivita'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attribute_01=>'ROW'
,p_attribute_02=>'FACET'
,p_attribute_04=>'N'
,p_fc_collapsible=>false
,p_fc_initial_collapsed=>false
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10651726114221771)
,p_name=>'P5_STELLE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(10650803072221768)
,p_prompt=>'Stelle'
,p_source=>'SOTTOTITOLO'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10652146341221771)
,p_name=>'P5_NUM_COOL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(10650803072221768)
,p_prompt=>'Numero Cool'
,p_source=>'Num_cool'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10652572653221773)
,p_name=>'P5_NUM_FUNNY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(10650803072221768)
,p_prompt=>'Numero Funny'
,p_source=>'Num_funny'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10652966742221775)
,p_name=>'P5_NUM_USEFUL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(10650803072221768)
,p_prompt=>'Numero Useful'
,p_source=>'Num_useful'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>7
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10655547552221792)
,p_name=>'P5_ORDER_BY'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(10650767142221768)
,p_item_display_point=>'ORDER_BY_ITEM'
,p_item_default=>'Recenti'
,p_prompt=>'Order By'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Recenti;Recenti,Stelle;Stelle,Nome Attivit\00E0;TITOLO_ATTIVITA')
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(10588835721221434)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp.component_end;
end;
/
