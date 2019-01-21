--DROP MATERIALIZED VIEW IF EXISTS analysis.vw_perfil_localidade CASCADE;
--CREATE MATERIALIZED VIEW analysis.vw_perfil_localidade AS 

SELECT
	a.localidade AS id_localidade,
	a.nome_localidade AS tx_localidade,
	a.tipo_localidade AS tx_tipo_localidade,
	(
		SELECT row_to_json(a)
		FROM (
			SELECT
				quantidade_oscs,
				quantidade_trabalhadores,
				quantidade_recursos,
				quantidade_projetos,
				fontes
			FROM analysis.vw_perfil_localidade_caracteristicas
			WHERE localidade = a.localidade
		) AS a
	) AS caracteristicas,
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				fundacao,
				quantidade_oscs,
				fontes
			FROM analysis.vw_perfil_localidade_evolucao_anual
			WHERE localidade = a.localidade
		) AS a
	) AS evolucao_anual,
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				quantidade_oscs,
				natureza_juridica,
				quantidade_oscs,
				fontes
			FROM analysis.vw_perfil_localidade_natureza_juridica
			WHERE localidade = a.localidade
		) AS a
	) AS natureza_juridica,
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				fonte_recursos,
				ano,
				valor_recursos,
				fontes
			FROM analysis.vw_perfil_localidade_repasse_recursos
			WHERE localidade = a.localidade
		) AS a
	) AS repasse_recursos,
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				area_atuacao,
				quantidade_oscs,
				fontes
			FROM analysis.vw_perfil_localidade_area_atuacao
			WHERE localidade = a.localidade
		) AS a
	) AS area_atuacao,
	/*
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				b.area_atuacao AS tx_porcentagem_maior,
				b.porcertagem_maior AS nr_porcentagem_maior,
				a.area_atuacao,
				a.quantidade_oscs,
				a.fontes
			FROM analysis.vw_perfil_localidade_area_atuacao AS a
			INNER JOIN analysis.vw_perfil_localidade_maior_area_atuacao AS b
			ON a.localidade = b.localidade
			WHERE localidade = a.localidade
		) AS a
	) AS area_atuacao,
	*/
	(
		SELECT json_agg(row_to_json(a))
		FROM (
			SELECT
				vinculos,
				deficiencia,
				voluntarios,
				total,
				fontes
			FROM analysis.vw_perfil_localidade_trabalhadores
			WHERE localidade = a.localidade
		) AS a
	) AS trabalhadores
FROM analysis.vw_perfil_localidade_caracteristicas AS a
LIMIT 10;