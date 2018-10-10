﻿select b.id_osc, c.tx_nome_certificado, b.ft_certificado, b.dt_inicio_certificado,
b.dt_fim_certificado, d.edmu_nm_municipio, e.eduf_nm_uf
from osc.tb_osc a
inner join osc.tb_certificado b on a.id_osc = b.id_osc
left join syst.dc_certificado c on b.cd_certificado = c.cd_certificado
left join spat.ed_municipio d on b.cd_municipio = d.edmu_cd_municipio
left join spat.ed_uf e on b.cd_uf = e.eduf_cd_uf
where a.bo_osc_ativa
and a.id_osc not in (789809,987654)
