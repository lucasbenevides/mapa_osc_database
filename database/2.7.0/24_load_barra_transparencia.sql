SELECT 
	(SELECT * FROM portal.atualizar_barra_transparencia(id_osc))
FROM 
	osc.tb_osc;