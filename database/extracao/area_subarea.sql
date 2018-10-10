﻿select distinct a.id_osc,-- cd_identificador_osc,
tx_razao_social_osc, tx_nome_fantasia_osc, 
dt_fundacao_osc, 
tx_nome_classe_atividade_economica,
tx_email,
tx_bairro, 
edmu_nm_municipio, 
eduf_sg_uf,
l.*,m.*
from osc.tb_osc a 
left join osc.tb_area_atuacao b on a.id_osc = b.id_osc
join osc.tb_dados_gerais c on a.id_osc = c.id_osc
left join osc.tb_contato f on a.id_osc = f.id_osc
join osc.tb_localizacao g on a.id_osc = g.id_osc
left join spat.ed_municipio h on g.cd_municipio = h.edmu_cd_municipio
left join spat.ed_uf i on h.eduf_cd_uf = i.eduf_cd_uf
left join syst.dc_classe_atividade_economica j on c.cd_classe_atividade_economica_osc = j.cd_classe_atividade_economica
left join (
select * from crosstab(
	$$ select id_osc, cd_area_atuacao, 1 from osc.tb_area_atuacao order by 1 $$,
	$$ select m from generate_series(1,11) m $$
	--$$ select cd_area_atuacao, tx_nome_area_atuacao from syst.dc_area_atuacao $$
	) AS (
		id_osc int, "Habitação" int, "Saúde" int, "Cultura e recreação" int, "Educação e pesquisa" int, "Assistência social" int, "Religião" int,
		"Associações patronais, profissionais e de produtores rurais" int, "Meio ambiente e proteção animal" int, "Desenvolvimento e defesa de direitos" int, "Outros" int, 
		"Outras atividades associativas" int
	)) l on a.id_osc = l.id_osc
--01:21
left join (
select * from crosstab(
	$$ select id_osc, cd_subarea_atuacao, 1 from osc.tb_area_atuacao order by 1 $$,
	$$ select m from generate_series(1,44) m $$
	--$$ select cd_area_atuacao, tx_nome_area_atuacao from syst.dc_area_atuacao $$
	) AS (
		id_osc int, 
"Hab sub Habitação" int,
"Hab sub Outros" int,
"Saude sub Hospitais" int,
"Saude sub Outros serviços de saúde" int,
"Saude sub Outros" int,
"Cultura sub Cultura e arte" int,
"Cultura sub Esporte e recreação" int,
"Cultura sub Outros" int,
"Educacao sub Educação infantil" int,
"Educacao sub Ensino fundamental" int,
"Educacao sub Ensino médio" int,
"Educacao sub Educação superior" int,
"Educacao sub Estudos e pesquisas" int,
"Educacao sub Educação profissional" int,
"Educacao sub Outras formas de educação/ensino" int,
"Educacao sub Outros" int,
"Educacao sub Atividades de apoio à educação" int,
"Ass Social sub Assistência social" int,
"Ass Social sub Outros" int,
"Religiao sub Religião" int,
"Religiao sub Outros" int,
"Ass Patronais sub Associações empresariais e patronais" int,
"Ass Patronais sub Associações profissionais" int,
"Ass Patronais sub Associações de produtores rurais" int,
"Ass Patronais sub Cooperativas sociais" int,
"Ass Patronais sub Outros" int,
"Meio Amb sub Meio ambiente" int,
"Meio Amb sub Proteção animal" int,
"Meio Amb sub Outros" int,
"Desenv e Def sub Associações de moradores" int,
"Desenv e Def sub Centros e associações comunitárias" int,
"Desenv e Def sub Desenvolvimento rural" int,
"Desenv e Def sub Emprego e treinamento" int,
"Desenv e Def sub Defesa de direitos de grupos e minorias" int,
"Desenv e Def sub Outros" int,
"Desenv e Def sub Associações de pais, professores, alunos e afins" int,
"Desenv e Def sub Associações patronais e profissionais" int,
"Desenv e Def sub Cultura e recreação" int,
"Desenv e Def sub Defesa de direitos e interesses - múltiplas áreas" int,
"Desenv e Def sub Meio ambiente e proteção animal" int,
"Desenv e Def sub Outras formas de desenvolvimento e defesa de direitos e interesses" int,
"Desenv e Def sub Religião" int,
"Desenv e Def sub Saúde, assistência social e educação" int,
"Outras sub Associações de atividades não especificadas anteriormente" int)
) m on a.id_osc = m.id_osc 
--04:37
where a.bo_osc_ativa
and a.id_osc not in (789809,987654)
