prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
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
 p_id=>2
,p_name=>'Mappa'
,p_alias=>'MAPPA'
,p_step_title=>'Mappa'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'19'
,p_last_updated_by=>'MODERATORE'
,p_last_upd_yyyymmddhh24miss=>'20260309114351'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10633670115221673)
,p_plug_name=>'Mappa'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(10453809613221187)
,p_plug_display_sequence=>10
,p_lazy_loading=>true
,p_plug_source_type=>'NATIVE_MAP_REGION'
);
wwv_flow_imp_page.create_map_region(
 p_id=>wwv_flow_imp.id(10634089461221673)
,p_region_id=>wwv_flow_imp.id(10633670115221673)
,p_height=>600
,p_navigation_bar_type=>'FULL'
,p_navigation_bar_position=>'END'
,p_init_position_zoom_type=>'STATIC'
,p_init_position_lon_static=>'-100'
,p_init_position_lat_static=>'45'
,p_init_zoomlevel_static=>'3'
,p_layer_messages_position=>'BELOW'
,p_legend_position=>'END'
,p_features=>'SCALE_BAR:INFINITE_MAP:RECTANGLE_ZOOM'
);
wwv_flow_imp_page.create_map_region_layer(
 p_id=>wwv_flow_imp.id(10634514821221681)
,p_map_region_id=>wwv_flow_imp.id(10634089461221673)
,p_name=>'Mappa'
,p_layer_type=>'POINT'
,p_display_sequence=>10
,p_location=>'LOCAL'
,p_query_type=>'TABLE'
,p_table_name=>'VISTA_ATTIVITA_COORDINATE'
,p_include_rowid_column=>false
,p_has_spatial_index=>false
,p_geometry_column_data_type=>'LONLAT_COLUMNS'
,p_longitude_column=>'Longitudine_Numeric'
,p_latitude_column=>'Latitudine_Numeric'
,p_point_display_type=>'SVG'
,p_point_svg_shape=>'Default'
,p_feature_clustering=>true
,p_cluster_threshold_pixels=>50
,p_cluster_point_svg_shape=>'Pin Square'
,p_tooltip_adv_formatting=>true
,p_tooltip_html_expr=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="font-weight: bold; font-size: 14px;">&"Nome".</div>',
'<div>&"Indirizzo"., &"CAP".</div>',
'<div>&"Citta"., &"Stato".</div>'))
,p_info_window_adv_formatting=>false
,p_allow_hide=>true
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10635142873221700)
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
