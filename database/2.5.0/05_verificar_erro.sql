DROP FUNCTION IF EXISTS portal.verificar_erro(codigoerro TEXT, mensagemerro TEXT, operacao TEXT, fonte TEXT, osc INTEGER, dataoperacao TIMESTAMP, errolog BOOLEAN, idcarga INTEGER);

CREATE OR REPLACE FUNCTION portal.verificar_erro(codigoerro TEXT, mensagemerro TEXT, operacao TEXT, fonte TEXT, osc INTEGER, dataoperacao TIMESTAMP, errolog BOOLEAN, idcarga INTEGER) RETURNS TABLE(
	mensagem TEXT
) AS $$

DECLARE 
	identificador_osc NUMERIC;
	mensagem_log TEXT;
	
BEGIN 
	IF codigoerro = 'P0001' THEN 
		IF mensagemerro = 'fonte_invalida' THEN 
			mensagem := 'Fonte de dados inválida.';
			mensagem_log := 'Fonte de dados inválida.';
			
		ELSIF mensagemerro = 'permissao_negada_usuario' THEN 
			mensagem := 'Usuário não tem permissão para acessar o conteúdo informado.';
			mensagem_log := 'Usuário não tem permissão para acessar o conteúdo informado.';
			
		ELSIF mensagemerro = 'dado_invalido' THEN 
			mensagem := 'Dado inválido.';
			mensagem_log := 'Dado inválido.';
			
		ELSIF mensagemerro = 'osc_nao_confere' THEN 
			mensagem := 'ID de OSC informado não confere com os dados enviados.';
			mensagem_log := 'ID de OSC informado não confere com os dados enviados.';
			
		END IF;
	
	ELSE 
		mensagem_log := mensagemerro;
		
		IF codigoerro = '23502' THEN -- not_null_violation
			mensagem := 'Dado(s) obrigatório(s) não enviado(s).';
			
		ELSIF codigoerro = '23505' THEN -- unique_violation
			mensagem := 'Dado(s) único(s) violado(s).';
			
		ELSIF codigoerro = '23503' THEN -- foreign_key_violation
			mensagem := 'Dado(s) com chave(s) estrangeira(s) violada(s).';
			
		ELSE 
			mensagem := 'Ocorreu um erro.';
			
		END IF;
	END IF;
	
	SELECT INTO identificador_osc cd_identificador_osc FROM osc.tb_osc WHERE cd_identificador_osc = osc OR id_osc::NUMERIC = osc;
	
	IF errolog AND identificador_osc IS NOT null THEN 
		INSERT INTO log.tb_log_erro_carga (cd_identificador_osc, tx_fonte_dados, cd_status, tx_mensagem, dt_carregamento_dados, id_carga) 
		VALUES (identificador_osc, fonte, 2, mensagem_log || ' Operação: ' || operacao, dataoperacao, idcarga);
	END IF;
	
	RETURN NEXT;
	
END;
$$ LANGUAGE 'plpgsql';
