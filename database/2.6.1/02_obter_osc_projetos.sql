DROP FUNCTION IF EXISTS portal.obter_osc_projetos(TEXT, INTEGER);

CREATE OR REPLACE FUNCTION portal.obter_osc_projetos(param TEXT, tipo INTEGER) RETURNS TABLE (
	resultado JSONB,
	mensagem TEXT,
	flag BOOLEAN
) AS $$ 

DECLARE
	tb_osc RECORD;

BEGIN 
	SELECT INTO tb_osc * FROM osc.tb_osc WHERE id_osc::TEXT = param OR tx_apelido_osc = param;
	
	IF tb_osc.bo_nao_possui_projeto IS NOT true THEN 
		IF tipo = 1 THEN 
			resultado := (
				jsonb_build_object(
					'bo_nao_possui_projeto', tb_osc.bo_nao_possui_projeto, 
					'ft_nao_possui_projeto', tb_osc.ft_nao_possui_projeto, 
					'projetos', (
						SELECT 
							jsonb_agg(
								jsonb_build_object(
									'id_projeto', tb_projeto.id_projeto, 
									'tx_identificador_projeto_externo', tb_projeto.tx_identificador_projeto_externo, 
									'ft_identificador_projeto_externo', tb_projeto.ft_identificador_projeto_externo, 
									'tx_nome_projeto', tb_projeto.tx_nome_projeto, 
									'ft_nome_projeto', tb_projeto.ft_nome_projeto, 
									'cd_status_projeto', tb_projeto.cd_status_projeto, 
									'tx_nome_status_projeto', dc_status_projeto.tx_nome_status_projeto, 
									'tx_status_projeto_outro', tb_projeto.tx_status_projeto_outro, 
									'ft_status_projeto', tb_projeto.ft_status_projeto, 
									'dt_data_inicio_projeto', TO_CHAR(tb_projeto.dt_data_inicio_projeto, 'DD-MM-YYYY'), 
									'ft_data_inicio_projeto', tb_projeto.ft_data_inicio_projeto, 
									'dt_data_fim_projeto', TO_CHAR(tb_projeto.dt_data_fim_projeto, 'DD-MM-YYYY'), 
									'ft_data_fim_projeto', tb_projeto.ft_data_fim_projeto, 
									'tx_link_projeto', tb_projeto.tx_link_projeto, 
									'ft_link_projeto', tb_projeto.ft_link_projeto, 
									'nr_total_beneficiarios', tb_projeto.nr_total_beneficiarios, 
									'ft_total_beneficiarios', tb_projeto.ft_total_beneficiarios, 
									'nr_valor_total_projeto', tb_projeto.nr_valor_total_projeto, 
									'ft_valor_total_projeto', tb_projeto.ft_valor_total_projeto, 
									'nr_valor_captado_projeto', tb_projeto.nr_valor_captado_projeto, 
									'ft_valor_captado_projeto', tb_projeto.ft_valor_captado_projeto, 
									'tx_metodologia_monitoramento', tb_projeto.tx_metodologia_monitoramento, 
									'ft_metodologia_monitoramento', tb_projeto.ft_metodologia_monitoramento, 
									'tx_descricao_projeto', tb_projeto.tx_descricao_projeto, 
									'ft_descricao_projeto', tb_projeto.ft_descricao_projeto, 
									'cd_abrangencia_projeto', tb_projeto.cd_abrangencia_projeto, 
									'tx_nome_abrangencia_projeto', dc_abrangencia_projeto.tx_nome_abrangencia_projeto, 
									'ft_abrangencia_projeto', tb_projeto.ft_abrangencia_projeto, 
									'cd_zona_atuacao_projeto', tb_projeto.cd_zona_atuacao_projeto, 
									'tx_nome_zona_atuacao', dc_zona_atuacao_projeto.tx_nome_zona_atuacao, 
									'ft_zona_atuacao_projeto', tb_projeto.ft_zona_atuacao_projeto, 
									'cd_municipio', tb_projeto.cd_municipio, 
									'tx_nome_municipio', ed_municipio.edmu_nm_municipio, 
									'ft_municipio', tb_projeto.ft_municipio, 
									'cd_uf', tb_projeto.cd_uf, 
									'tx_nome_uf', ed_uf.eduf_nm_uf, 
									'ft_uf', tb_projeto.ft_uf,
									'publico_beneficiado', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_publico_beneficiado', tb_publico_beneficiado_projeto.id_publico_beneficiado, 
													'tx_nome_publico_beneficiado', tb_publico_beneficiado.tx_nome_publico_beneficiado, 
													'nr_estimativa_pessoas_atendidas', tb_publico_beneficiado_projeto.nr_estimativa_pessoas_atendidas, 
													'ft_publico_beneficiado_projeto', tb_publico_beneficiado_projeto.ft_publico_beneficiado_projeto
												)
											)
										FROM 
											osc.tb_publico_beneficiado_projeto 
										LEFT JOIN 
											osc.tb_publico_beneficiado 
										ON 
											tb_publico_beneficiado_projeto.id_publico_beneficiado = tb_publico_beneficiado.id_publico_beneficiado 
										WHERE 
											tb_publico_beneficiado_projeto.id_projeto = tb_projeto.id_projeto 
									),
									'fonte_recursos', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_fonte_recursos_projeto', tb_fonte_recursos_projeto.id_fonte_recursos_projeto, 
													'cd_origem_fonte_recursos_projeto', tb_fonte_recursos_projeto.cd_origem_fonte_recursos_projeto, 
													'tx_nome_origem_fonte_recursos_projeto', dc_origem_fonte_recursos_projeto.tx_nome_origem_fonte_recursos_projeto, 
													'ft_fonte_recursos_projeto', tb_fonte_recursos_projeto.ft_fonte_recursos_projeto
												)
											)
										FROM 
											osc.tb_fonte_recursos_projeto 
										LEFT JOIN 
											syst.dc_origem_fonte_recursos_projeto 
										ON 
											tb_fonte_recursos_projeto.cd_origem_fonte_recursos_projeto = dc_origem_fonte_recursos_projeto.cd_origem_fonte_recursos_projeto 
										WHERE 
											tb_fonte_recursos_projeto.id_projeto = tb_projeto.id_projeto 
									), 
									'financiador_projeto', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_financiador_projeto', tb_financiador_projeto.id_financiador_projeto, 
													'tx_nome_financiador', tb_financiador_projeto.tx_nome_financiador, 
													'ft_nome_financiador', tb_financiador_projeto.ft_nome_financiador
												)
											)
										FROM 
											osc.tb_financiador_projeto 
										WHERE 
											tb_financiador_projeto.id_projeto = tb_projeto.id_projeto
									),
									'localizacao', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_localizacao_projeto', tb_localizacao_projeto.id_localizacao_projeto, 
													'id_regiao_localizacao_projeto', tb_localizacao_projeto.id_regiao_localizacao_projeto, 
													'tx_nome_regiao_localizacao_projeto', tb_localizacao_projeto.tx_nome_regiao_localizacao_projeto, 
													'ft_nome_regiao_localizacao_projeto', tb_localizacao_projeto.ft_nome_regiao_localizacao_projeto, 
													'bo_localizacao_prioritaria', tb_localizacao_projeto.bo_localizacao_prioritaria, 
													'ft_localizacao_prioritaria', tb_localizacao_projeto.ft_localizacao_prioritaria
												)
											)
										FROM 
											osc.tb_localizacao_projeto 
										WHERE 
											tb_localizacao_projeto.id_projeto = tb_projeto.id_projeto
									),
									'osc_parceira', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_osc', tb_osc_parceira_projeto.id_osc, 
													'tx_nome_osc_parceira_projeto', COALESCE(tb_dados_gerais.tx_nome_fantasia_osc, tb_dados_gerais.tx_razao_social_osc), 
													'ft_osc_parceira_projeto', tb_osc_parceira_projeto.ft_osc_parceira_projeto
												)
											)
										FROM 
											osc.tb_osc_parceira_projeto 
										LEFT JOIN 
											osc.tb_dados_gerais 
										ON 
											tb_osc_parceira_projeto.id_osc = tb_dados_gerais.id_osc 
										WHERE 
											tb_osc_parceira_projeto.id_projeto = tb_projeto.id_projeto
									), 
									'objetivo_meta', (
										SELECT 
											jsonb_agg(
												jsonb_build_object(
													'id_objetivo_projeto', tb_objetivo_projeto.id_objetivo_projeto, 
													'cd_objetivo_projeto', dc_meta_projeto.cd_objetivo_projeto, 
													'tx_nome_objetivo_projeto', dc_objetivo_projeto.tx_nome_objetivo_projeto, 
													'cd_meta_projeto', tb_objetivo_projeto.cd_meta_projeto, 
													'tx_nome_meta_projeto', dc_meta_projeto.tx_nome_meta_projeto, 
													'ft_objetivo_projeto', tb_objetivo_projeto.ft_objetivo_projeto
												)
											)
										FROM 
											osc.tb_objetivo_projeto 
										LEFT JOIN 
											syst.dc_meta_projeto 
										ON 
											tb_objetivo_projeto.cd_meta_projeto = dc_meta_projeto.cd_meta_projeto 
										LEFT JOIN 
											syst.dc_objetivo_projeto 
										ON 
											dc_meta_projeto.cd_objetivo_projeto = dc_objetivo_projeto.cd_objetivo_projeto 
										WHERE 
											tb_objetivo_projeto.id_projeto = tb_projeto.id_projeto
									)
								)
							)
						FROM 
							osc.tb_projeto 
						LEFT JOIN 
							syst.dc_status_projeto 
						ON 
							tb_projeto.cd_status_projeto = dc_status_projeto.cd_status_projeto 
						LEFT JOIN 	
							syst.dc_abrangencia_projeto 
						ON 
							tb_projeto.cd_abrangencia_projeto = dc_abrangencia_projeto.cd_abrangencia_projeto 
						LEFT JOIN 	
							syst.dc_zona_atuacao_projeto 
						ON 
							tb_projeto.cd_zona_atuacao_projeto = dc_zona_atuacao_projeto.cd_zona_atuacao_projeto 
						LEFT JOIN 	
							spat.ed_municipio 
						ON 
							tb_projeto.cd_municipio = ed_municipio.edmu_cd_municipio 
						LEFT JOIN 	
							spat.ed_uf 
						ON 
							tb_projeto.cd_uf = ed_uf.eduf_cd_uf 
						WHERE 
							tb_projeto.id_osc::TEXT = param 
						OR 
							tb_osc.tx_apelido_osc = param
					)
				)
			);
			
		ELSIF tipo = 2 THEN 
			resultado := (
				jsonb_build_object(
					'bo_nao_possui_projeto', true, 
					'ft_nao_possui_projeto', tb_osc.ft_nao_possui_projeto, 
					'projetos', (
							SELECT 
								jsonb_agg(
									jsonb_build_object(
										'id_projeto', tb_projeto.id_projeto, 
										'tx_nome_projeto', tb_projeto.tx_nome_projeto
									)
								)
							FROM 
								osc.tb_projeto 
							WHERE 
								tb_projeto.id_osc::TEXT = param 
							OR 
								tb_osc.tx_apelido_osc = param
					)
				)
			);
			
		ELSE 
			RAISE EXCEPTION 'tipo_obter_projeto_invalido';
			
		END IF;
		
	ELSE 
		resultado := jsonb_build_object(
			'bo_nao_possui_projeto', true, 
			'ft_nao_possui_projeto', tb_osc.ft_nao_possui_projeto, 
			'projetos', null
		);
	
	END IF;
	
	flag := false;
	mensagem := 'Projetos retornados.';
	
	RETURN NEXT;

EXCEPTION
	WHEN others THEN 
		flag := false;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro(SQLSTATE, SQLERRM, null, null, null, false, null) AS a;
		RETURN NEXT;
END;
$$ LANGUAGE 'plpgsql';
