DROP FUNCTION IF EXISTS portal.obter_perfil_localidade_repasse_recursos(INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION portal.obter_perfil_localidade_repasse_recursos(id_localidade INTEGER) RETURNS TABLE (
	dados JSONB, 
	fontes TEXT[]
) AS $$ 

BEGIN 
	RETURN QUERY 
		SELECT 
			('{"series_1": [{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG(b.dados::TEXT)::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]}')::JSONB AS dados, 
			(
				SELECT ARRAY_AGG(TRANSLATE(a::TEXT, '()\"', '')) FROM (SELECT DISTINCT UNNEST(
					TRANSLATE(ARRAY_AGG(REPLACE(REPLACE(TRIM(TRANSLATE(b.fontes::TEXT, '"\{}', ''), ','), '","', ','), ',,', ','))::TEXT, '"', '')::TEXT[]
				)) AS a
			) AS fontes 
		FROM (
			SELECT 
				('{"key": "' || a.tx_nome_fonte_recursos_osc || '", "values": ' || '[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG('{"x": "' || a.dt_ano_recursos::TEXT || '", "y": ' || a.nr_valor_recursos::TEXT || '}')::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]}')::JSONB AS dados, 
				(
					SELECT ARRAY_AGG(TRANSLATE(a::TEXT, '()\"', '')) FROM (SELECT DISTINCT UNNEST(
						TRANSLATE(ARRAY_AGG(REPLACE(REPLACE(TRIM(TRANSLATE(a.fontes::TEXT, '"\{}', ''), ','), '","', ','), ',,', ','))::TEXT, '"', '')::TEXT[]
					)) AS a
				) AS fontes 
			FROM (
				SELECT 
					COALESCE(DATE_PART('year', tb_recursos_osc.dt_ano_recursos_osc)::TEXT, 'Sem informação') AS dt_ano_recursos,
					COALESCE(dc_fonte_recursos_osc.tx_nome_fonte_recursos_osc, 'Sem informação') AS tx_nome_fonte_recursos_osc,
					SUM(COALESCE(tb_recursos_osc.nr_valor_recursos_osc, 0)) AS nr_valor_recursos,
					(
						SELECT ARRAY_AGG(TRANSLATE(a::TEXT, '()', '')) FROM (SELECT DISTINCT UNNEST(
								ARRAY_CAT(
									ARRAY_CAT(
										ARRAY_AGG(DISTINCT COALESCE(tb_osc.ft_osc_ativa, '')), 
										ARRAY_AGG(DISTINCT COALESCE(tb_localizacao.ft_municipio, ''))
									),
									ARRAY_AGG(DISTINCT COALESCE(tb_recursos_osc.ft_valor_recursos_osc, ''))
								)
							)
						) AS a
					) AS fontes
				FROM osc.tb_osc
				LEFT JOIN osc.tb_recursos_osc
				ON tb_osc.id_osc = tb_recursos_osc.id_osc
				LEFT JOIN syst.dc_fonte_recursos_osc
				ON tb_recursos_osc.cd_fonte_recursos_osc = dc_fonte_recursos_osc.cd_fonte_recursos_osc
				LEFT JOIN osc.tb_localizacao
				ON tb_osc.id_osc = tb_localizacao.id_osc
				LEFT JOIN spat.ed_regiao
				ON (SELECT SUBSTR(tb_localizacao.cd_municipio::TEXT, 1, 1))::NUMERIC(1, 0) = ed_regiao.edre_cd_regiao
				WHERE tb_osc.bo_osc_ativa
				AND tb_osc.id_osc <> 789809
				AND (
					SUBSTR(tb_localizacao.cd_municipio::TEXT, 1, 1) = id_localidade::TEXT
					OR
					SUBSTR(tb_localizacao.cd_municipio::TEXT, 1, 2) = id_localidade::TEXT
					OR
					tb_localizacao.cd_municipio = id_localidade
				)
				GROUP BY dt_ano_recursos, tx_nome_fonte_recursos_osc
			) AS a 
			GROUP BY a.tx_nome_fonte_recursos_osc
		) AS b;
END;

$$ LANGUAGE 'plpgsql';

SELECT * FROM portal.obter_perfil_localidade_repasse_recursos(35);
