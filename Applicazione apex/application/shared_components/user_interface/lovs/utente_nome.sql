prompt --application/shared_components/user_interface/lovs/utente_nome
begin
--   Manifest
--     UTENTE.NOME
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2022.10.07'
,p_release=>'22.2.0'
,p_default_workspace_id=>9000669391213301
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'AMMINISTRATORE_DB'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(10659101562221806)
,p_lov_name=>'UTENTE.NOME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'UTENTE'
,p_return_column_name=>'ID_Utente'
,p_display_column_name=>'Nome'
,p_default_sort_column_name=>'Nome'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
