DROP FUNCTION IF EXISTS portal.obter_representante(id INTEGER);

CREATE OR REPLACE FUNCTION portal.obter_representante(id INTEGER) RETURNS TABLE(
	tx_email_usuario TEXT, 
	tx_nome_usuario TEXT, 
	nr_cpf_usuario NUMERIC(11, 0), 
	bo_lista_email BOOLEAN
) AS $$ 
BEGIN 
	RETURN QUERY 
		SELECT 
			tb_usuario.tx_email_usuario, 
			tb_usuario.tx_nome_usuario, 
			tb_usuario.nr_cpf_usuario, 
			tb_usuario.bo_lista_email 
		FROM 
			portal.tb_usuario 
		WHERE 
			tb_usuario.id_usuario = id
		AND 
			tb_usuario.cd_tipo_usuario = 2; 
END; 
$$ LANGUAGE 'plpgsql';
