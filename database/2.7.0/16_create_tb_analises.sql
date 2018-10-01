CREATE TABLE portal.tb_analise(
	id_analise INTEGER NOT NULL,
	configuracao TEXT[], 
	tipo_grafico INTEGER, 
	titulo TEXT, 
	legenda TEXT,
	titulo_colunas TEXT[], 
	legenda_x TEXT, 
	legenda_y TEXT,  
	parametros JSONB, 
	series_1 JSONB, 
	series_2 JSONB, 
	fontes TEXT[], 
	inverter_eixo BOOLEAN, 
	slug TEXT, 
	ativo BOOLEAN, 
	CONSTRAINT pk_tb_analise PRIMARY KEY (id_analise), 
    CONSTRAINT fk_tipo_grafico FOREIGN KEY (tipo_grafico) REFERENCES syst.tb_tipo_grafico (id_grafico)
);