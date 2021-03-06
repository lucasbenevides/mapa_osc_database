﻿DROP FUNCTION IF EXISTS portal.obter_osc_participacao_social_outra(TEXT);

CREATE OR REPLACE FUNCTION portal.obter_osc_participacao_social_outra(param TEXT) RETURNS TABLE(
	id_participacao_social_outra INTEGER, 
	tx_nome_participacao_social_outra TEXT, 
	ft_participacao_social_outra TEXT, 
	bo_nao_possui BOOLEAN
) AS $$ 
BEGIN 
	RETURN QUERY 
		SELECT 
			tb_participacao_social_outra.id_participacao_social_outra,
			tb_participacao_social_outra.tx_nome_participacao_social_outra,
			tb_participacao_social_outra.ft_participacao_social_outra,
			tb_participacao_social_outra.bo_nao_possui
		FROM 
			osc.tb_osc
		INNER JOIN 
			osc.tb_participacao_social_outra 
		ON 
			tb_osc.id_osc = tb_participacao_social_outra.id_osc
		WHERE 
			tb_osc.bo_osc_ativa
		AND (
			tb_osc.id_osc = param::INTEGER OR 
			tb_osc.tx_apelido_osc = param
		);

END;
$$ LANGUAGE 'plpgsql';

