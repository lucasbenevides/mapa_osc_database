DROP FUNCTION IF EXISTS portal.atualizar_contato(fonte TEXT, cnpj INTEGER, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, errolog BOOLEAN, id_carga INTEGER);

DROP FUNCTION IF EXISTS portal.atualizar_contato(fonte TEXT, identificador NUMERIC, tipo_identificador TEXT, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, errolog BOOLEAN, id_carga INTEGER);

CREATE OR REPLACE FUNCTION portal.atualizar_contato(fonte TEXT, identificador NUMERIC, tipo_identificador TEXT, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, errolog BOOLEAN, id_carga INTEGER) RETURNS TABLE(
	mensagem TEXT,
	flag BOOLEAN
)AS $$

DECLARE
	nome_tabela TEXT;
	operacao TEXT;
	fonte_dados RECORD;
	objeto RECORD;
	dado_anterior RECORD;
	dado_posterior RECORD;
	flag_update BOOLEAN;
	osc NUMERIC;

BEGIN
	nome_tabela := 'osc.atualizar_contato';
	tipo_identificador := lower(tipo_identificador);
	operacao := 'portal.atualizar_contato(' || fonte::TEXT || ', ' || cnpj::TEXT || ', ' || dataatualizacao::TEXT || ', ' || json::TEXT || ', ' || nullvalido::TEXT || ', ' || errolog::TEXT || ', ' || id_carga::TEXT || ')';

	SELECT INTO fonte_dados * FROM portal.verificar_fonte(fonte);

	IF fonte_dados IS null THEN
		RAISE EXCEPTION 'fonte_invalida';
	ELSIF osc != ALL(fonte_dados.representacao) THEN
		RAISE EXCEPTION 'permissao_negada_usuario';
	ELSIF tipo_identificador != 'cnpj' OR tipo_identificador != 'id_osc' THEN
		RAISE EXCEPTION 'tipo_identificador';
	END IF;

	SELECT INTO objeto * FROM json_populate_record(null::osc.tb_osc, json::JSON);

	IF tipo_identificador = 'cnpj' THEN
		SELECT id_osc INTO osc FROM osc.tb_osc WHERE cd_identificador_osc = identificador;
	ELSE
		osc:=identificador;
	END IF;

	SELECT INTO dado_anterior * FROM osc.tb_contato WHERE id_osc = osc;

	IF COUNT(dado_anterior) = 0 THEN
	INSERT INTO osc.tb_contato(
		id_osc,
		tx_telefone,
		ft_telefone,
		tx_email,
		ft_email,
		nm_representante,
		ft_representante,
		tx_site,
		ft_site,
		tx_facebook,
		ft_facebook,
		tx_google,
		ft_google,
		tx_linkedin,
		ft_linkedin,
		tx_twitter,
		ft_twitter
	)
	 VALUES (
		 	osc,
			objeto.tx_telefone,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_email,
	 		fonte_dados.nome_fonte,
	 		objeto.nm_representante,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_site,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_facebook,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_google,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_linkedin,
	 		fonte_dados.nome_fonte,
	 		objeto.tx_twitter,
	 		fonte_dados.nome_fonte
		) RETURNING * INTO dado_posterior;

		INSERT INTO log.tb_log_alteracao(tx_nome_tabela, id_osc, id_usuario, dt_alteracao, tx_dado_anterior, tx_dado_posterior)
		VALUES (nome_tabela, osc, fonte::INTEGER, dataatualizacao, null, row_to_json(dado_posterior));

	ELSE
		dado_posterior := dado_anterior;
		flag_update := false;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_telefone::TEXT, dado_anterior.ft_telefone, objeto.tx_telefone::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_telefone := objeto.tx_telefone;
			dado_posterior.ft_telefone := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_email::TEXT, dado_anterior.ft_email, objeto.tx_email::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_email := objeto.tx_email;
			dado_posterior.ft_email := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.nm_representante::TEXT, dado_anterior.ft_representante, objeto.nm_representante::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.nm_representante := objeto.nm_representante;
			dado_posterior.ft_representante := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_site::TEXT, dado_anterior.ft_site, objeto.tx_site::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_site := objeto.tx_site;
			dado_posterior.ft_site := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_facebook::TEXT, dado_anterior.ft_facebook, objeto.tx_facebook::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_facebook := objeto.tx_facebook;
			dado_posterior.ft_facebook := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_google::TEXT, dado_anterior.ft_google, objeto.tx_google::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_google := objeto.tx_google;
			dado_posterior.ft_google := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_linkedin::TEXT, dado_anterior.ft_linkedin, objeto.tx_linkedin::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_linkedin := objeto.tx_linkedin;
			dado_posterior.ft_linkedin := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_twitter::TEXT, dado_anterior.ft_twitter, objeto.tx_twitter::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
			dado_posterior.tx_twitter := objeto.tx_twitter;
			dado_posterior.ft_twitter := fonte_dados.nome_fonte;
			flag_update := true;
		END IF;

		IF flag_update THEN
			UPDATE osc.tb_contato SET
			tx_telefone = dado_posterior.tx_telefone,
			ft_telefone = dado_posterior.ft_telefone,
			tx_email = dado_posterior.tx_email,
			ft_email = dado_posterior.ft_email,
			nm_representante = dado_posterior.nm_representante,
			ft_representante = dado_posterior.ft_representante,
			tx_site = dado_posterior.tx_site,
			ft_site = dado_posterior.ft_site,
			tx_facebook = dado_posterior.tx_facebook,
			ft_facebook = dado_posterior.ft_facebook,
			tx_google = dado_posterior.tx_google,
			ft_google = dado_posterior.ft_google,
			tx_linkedin = dado_posterior.tx_linkedin,
			ft_linkedin = dado_posterior.ft_linkedin,
			tx_twitter = dado_posterior.tx_twitter,
			ft_twitter = dado_posterior.ft_twitter
			WHERE id_osc = osc;

			INSERT INTO log.tb_log_alteracao(tx_nome_tabela, id_osc, id_usuario, dt_alteracao, tx_dado_anterior, tx_dado_posterior)
			VALUES (nome_tabela, osc, fonte::INTEGER, dataatualizacao, row_to_json(dado_anterior), row_to_json(dado_posterior));

		END IF;
	END IF;

	flag := true;
	mensagem := 'Contato atualizado.';

	RETURN NEXT;

	EXCEPTION
		WHEN others THEN
			flag := false;
			SELECT INTO mensagem a.mensagem FROM portal.verificar_erro(SQLSTATE, SQLERRM, fonte, osc, dataatualizacao::TIMESTAMP, errolog, id_carga) AS a;
			RETURN NEXT;

END;
$$ LANGUAGE 'plpgsql';
