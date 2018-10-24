select b.id_projeto, b.id_osc, regexp_replace(b.tx_nome_projeto, E'[\\n\\r\\t]+', ' ', 'g' ) as tx_nome_projeto, 
c.tx_nome_status_projeto, b.dt_data_inicio_projeto,
b.dt_data_fim_projeto, b.tx_link_projeto, b.nr_total_beneficiarios, b.nr_valor_captado_projeto,
b.nr_valor_total_projeto, d.tx_nome_abrangencia_projeto, e.tx_nome_zona_atuacao,
regexp_replace(b.tx_descricao_projeto, E'[\\n\\r\\t]+', ' ', 'g' ) as tx_descricao_projeto, 
regexp_replace(b.tx_metodologia_monitoramento, E'[\\n\\r\\t]+', ' ', 'g' ) as tx_metodologia_monitoramento, 
b.ft_identificador_projeto_externo,
b.tx_status_projeto_outro, f.edmu_nm_municipio, g.eduf_nm_uf, i.tx_nome_subarea_atuacao,
j.tx_nome_financiador, k.tx_orgao_concedente,m.tx_nome_origem_fonte_recursos_projeto,l.tx_nome_fonte_recursos_projeto,
n.tx_nome_regiao_localizacao_projeto, q.tx_nome_objetivo_projeto, p.tx_nome_meta_projeto,
r.id_osc as id_osc_parceira, s.tx_nome_publico_beneficiado, s.nr_estimativa_pessoas_atendidas,
u.tx_nome_tipo_parceria
from osc.tb_osc a
join osc.tb_projeto b on a.id_osc = b.id_osc
left join syst.dc_status_projeto c on b.cd_status_projeto = c.cd_status_projeto 
left join syst.dc_abrangencia_projeto d on b.cd_abrangencia_projeto = d.cd_abrangencia_projeto
left join syst.dc_zona_atuacao_projeto e on b.cd_zona_atuacao_projeto = e.cd_zona_atuacao_projeto
left join spat.ed_municipio f on b.cd_municipio = f.edmu_cd_municipio
left join spat.ed_uf g on b.cd_uf = g.eduf_cd_uf
left join osc.tb_area_atuacao_projeto h on b.id_projeto = h.id_projeto
left join syst.dc_subarea_atuacao i on h.cd_subarea_atuacao = i.cd_subarea_atuacao
left join osc.tb_financiador_projeto j on b.id_projeto = j.id_projeto
left join osc.tb_fonte_recursos_projeto k on b.id_projeto = k.id_projeto
left join syst.dc_fonte_recursos_projeto l on k.cd_fonte_recursos_projeto = l.cd_fonte_recursos_projeto
left join syst.dc_origem_fonte_recursos_projeto m on l.cd_origem_fonte_recursos_projeto = m.cd_origem_fonte_recursos_projeto
left join osc.tb_localizacao_projeto n on b.id_projeto = n.id_projeto
left join osc.tb_objetivo_projeto o on b.id_projeto = o.id_projeto
left join syst.dc_meta_projeto p on o.cd_meta_projeto = p.cd_meta_projeto
left join syst.dc_objetivo_projeto q on p.cd_objetivo_projeto = q.cd_objetivo_projeto
left join osc.tb_osc_parceira_projeto r on b.id_projeto = r.id_projeto
left join osc.tb_publico_beneficiado_projeto s on b.id_projeto = s.id_projeto
left join osc.tb_tipo_parceria_projeto t on b.id_projeto = t.id_projeto
left join syst.dc_tipo_parceria u on t.cd_tipo_parceria_projeto = u.cd_tipo_parceria
where a.bo_osc_ativa
and a.id_osc not in (789809,987654)
