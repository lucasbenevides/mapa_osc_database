﻿DROP FUNCTION IF EXISTS portal.atualizar_participacao_social_conselho(integer, integer, integer, text, text, text, date, text, date, text);

CREATE OR REPLACE FUNCTION portal.atualizar_participacao_social_conselho(id_osc_req INTEGER, cdconselho INTEGER, cdtipoparticipacao INTEGER, fttipoparticipacao TEXT, cdperiodicidadereuniaoconselho INTEGER, ftperiodicidadereuniao TEXT, dtinicioconselho DATE, ftdtinicioconselho TEXT, dtfimconselho DATE, ftdtfimconselho TEXT)
 RETURNS TABLE(
	mensagem TEXT
)AS $$

BEGIN 

	UPDATE 
		osc.tb_participacao_social_conselho 
	SET 
		cd_tipo_participacao = cdtipoparticipacao, 
		ft_tipo_participacao = fttipoparticipacao, 
		cd_periodicidade_reuniao_conselho = cdperiodicidadereuniaoconselho, 
		ft_periodicidade_reuniao = ftperiodicidadereuniao, 
		dt_data_inicio_conselho = dtinicioconselho, 
		ft_data_inicio_conselho = ftdtinicioconselho, 
		dt_data_fim_conselho = dtfimconselho, 
		ft_data_fim_conselho = ftdtfimconselho

	WHERE 
		id_osc = id_osc_req AND
		cd_conselho = cdconselho;

	mensagem := 'Participação Social Conselho atualizada';
	RETURN NEXT;
END; 
$$ LANGUAGE 'plpgsql';
