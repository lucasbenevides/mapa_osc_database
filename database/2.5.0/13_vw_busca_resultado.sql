-- object: osc.vw_busca_resultado | type: MATERIALIZED VIEW --
DROP MATERIALIZED VIEW IF EXISTS osc.vw_busca_resultado CASCADE;
CREATE MATERIALIZED VIEW osc.vw_busca_resultado AS
SELECT
	tb_osc.id_osc,
	COALESCE(NULLIF(TRIM(tb_dados_gerais.tx_nome_fantasia_osc), ''), tb_dados_gerais.tx_razao_social_osc) AS tx_nome_osc,
	LPAD(tb_osc.cd_identificador_osc::TEXT, 14, '0'::TEXT) AS cd_identificador_osc,
	(SELECT dc_natureza_juridica.tx_nome_natureza_juridica FROM syst.dc_natureza_juridica WHERE dc_natureza_juridica.cd_natureza_juridica = tb_dados_gerais.cd_natureza_juridica_osc) AS tx_natureza_juridica_osc,
	(
		RTRIM(
			REPLACE(
				COALESCE(tb_localizacao.tx_endereco::TEXT, '|') || ', ' ||
				COALESCE(tb_localizacao.nr_localizacao::TEXT, '|') || ', ' ||
				COALESCE(tb_localizacao.tx_endereco_complemento::TEXT, '|') || ', ' ||
				COALESCE(tb_localizacao.tx_bairro::TEXT, '|') || ', ' ||
				COALESCE((SELECT ed_municipio.edmu_nm_municipio AS tx_municipio FROM spat.ed_municipio WHERE ed_municipio.edmu_cd_municipio = tb_localizacao.cd_municipio)::TEXT, '|') || ', ' ||
				COALESCE((SELECT ed_uf.eduf_sg_uf AS tx_uf FROM spat.ed_uf WHERE ed_uf.eduf_cd_uf = (SUBSTR(tb_localizacao.cd_municipio::TEXT, 0, 2)::NUMERIC))::TEXT, '|') || ', ' ||
				COALESCE(tb_localizacao.nr_cep::TEXT, '|'), '|, ', ''
			), ', |'
		)
	) AS tx_endereco_osc,
	ST_Y(ST_TRANSFORM(tb_localizacao.geo_localizacao, 4674)) AS geo_lat,
	ST_X(ST_TRANSFORM(tb_localizacao.geo_localizacao, 4674)) AS geo_lng,
	(
		SELECT dc_classe_atividade_economica.tx_nome_classe_atividade_economica
        FROM syst.dc_classe_atividade_economica
        WHERE dc_classe_atividade_economica.cd_classe_atividade_economica = tb_dados_gerais.cd_classe_atividade_economica_osc
	) AS tx_nome_atividade_economica,
	tb_dados_gerais.im_logo
FROM osc.tb_osc
LEFT JOIN osc.tb_dados_gerais
ON tb_osc.id_osc = tb_dados_gerais.id_osc
LEFT JOIN osc.tb_localizacao
ON tb_osc.id_osc = tb_localizacao.id_osc
WHERE tb_osc.bo_osc_ativa = true;
-- ddl-end --
ALTER MATERIALIZED VIEW osc.vw_busca_resultado OWNER TO postgres;
-- ddl-end --

CREATE UNIQUE INDEX ix_vw_busca_resultado
    ON osc.vw_busca_resultado USING btree
    (id_osc ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE OR REPLACE FUNCTION vw_busca_resultado()
RETURNS TRIGGER AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY osc.vw_busca_resultado;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
