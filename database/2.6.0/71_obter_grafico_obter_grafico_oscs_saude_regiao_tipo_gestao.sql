DROP FUNCTION IF EXISTS portal.obter_grafico_oscs_saude_regiao_tipo_gestao() CASCADE;

CREATE OR REPLACE FUNCTION portal.obter_grafico_oscs_saude_regiao_tipo_gestao() RETURNS TABLE (
	titulo TEXT, 
	tipo TEXT, 
	dados JSONB, 
	fontes TEXT[]	
) AS $$ 

BEGIN 
	RETURN QUERY 
		SELECT 
			'Distribuição de OSCs de saúde por região e tipo de gestão'::TEXT as titulo, 
			'barras'::TEXT as tipo, 
			c.dados::JSONB AS dados, 
			c.fontes::TEXT[] AS fontes 
		FROM (
			SELECT 
				('[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG(b.dados)::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]') AS dados, 
				(SELECT ARRAY(SELECT DISTINCT UNNEST(('{' || BTRIM(REPLACE(REPLACE(RTRIM(LTRIM(TRANSLATE(ARRAY_AGG(b.fontes::TEXT)::TEXT, '"\', ''), '{'), '}'), '},{', ','), ',,', ','), ',') || '}')::TEXT[]))) AS fontes
			FROM (
				SELECT 
					('{"rotulo": "' || a.rotulo_1 || '", "valor": ' || '[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG('{"rotulo": "' || a.rotulo_2::TEXT || '", "valor": ' || a.valor::TEXT || '}')::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]}') AS dados, 
					(SELECT ARRAY(SELECT DISTINCT UNNEST(('{' || BTRIM(REPLACE(REPLACE(RTRIM(LTRIM(TRANSLATE(ARRAY_AGG(a.fontes::TEXT)::TEXT, '"\', ''), '{'), '}'), '},{', ','), ',,', ','), ',') || '}')::TEXT[]))) AS fontes
				FROM (
					SELECT 
						ed_regiao.edre_nm_regiao AS rotulo_1, 
						tb_cnes.ds_esfera_administrativa  AS rotulo_2, 
						count(*) AS valor, 
						ARRAY_AGG(DISTINCT(COALESCE(tb_dados_gerais.ft_classe_atividade_economica_osc, '') || ',' || COALESCE(tb_localizacao.ft_municipio, ''))) AS fontes 
					FROM osc.tb_dados_gerais 
					INNER JOIN graph.tb_cnes 
					ON tb_dados_gerais.cd_identificador_osc = tb_cnes.nu_cnpj_requerente 
					LEFT JOIN osc.tb_localizacao 
					ON tb_dados_gerais.id_osc = tb_localizacao.id_osc 
					LEFT JOIN spat.ed_regiao 
					ON ed_regiao.edre_cd_regiao::TEXT = SUBSTR(tb_localizacao.cd_municipio::TEXT, 1, 1) 
					GROUP BY rotulo_1, rotulo_2 
					ORDER BY rotulo_1, rotulo_2 
				) AS a 
				GROUP BY regiao
			) AS b
		) AS c;
END;

$$ LANGUAGE 'plpgsql';

SELECT * FROM portal.obter_grafico_osc_natureza_juridica_regiao();