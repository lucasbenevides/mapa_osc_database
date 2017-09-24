﻿DROP FUNCTION IF EXISTS portal.obter_osc_atualizadas_recentemente();

CREATE OR REPLACE FUNCTION portal.obter_osc_atualizadas_recentemente() RETURNS TABLE(
	id_osc INTEGER, 
	tx_nome_osc TEXT
)AS $$

BEGIN 
	RETURN QUERY 
		SELECT tb_log_alteracao.id_osc, vw_busca_resultado.tx_nome_osc 
		FROM 
			(
				SELECT tb_log_alteracao.id_osc, MAX(dt_alteracao) AS dt_alteracao 
				FROM log.tb_log_alteracao 
				GROUP BY tb_log_alteracao.id_osc
			) AS tb_log_alteracao INNER JOIN 
			osc.vw_busca_resultado ON tb_log_alteracao.id_osc = vw_busca_resultado.id_osc 
			ORDER BY tb_log_alteracao.dt_alteracao DESC 
			LIMIT 10;
	
END;
$$ LANGUAGE 'plpgsql';
