USE campeonatoPaulista

CREATE TABLE times (
codigoTime TINYINT PRIMARY KEY,
NomeTime VARCHAR(50) NOT NULL,
Cidade VARCHAR(100) NOT NULL,
Estadio VARCHAR(70) NOT NULL,
ordenado TINYINT DEFAULT(1) CHECK(ordenado=1 OR ordenado=0) NOT NULL
)

CREATE tABLE grupos(
grupo CHAR(1) CHECK(grupo='A' OR grupo='B'OR grupo='C' OR grupo='D') NOT NULL,
codigoTime TINYINT NOT NULL
CONSTRAINT FK_codigoTime FOREIGN KEY (codigoTime) REFERENCES times(codigoTime)
)

select * from grupos
select * from times

INSERT INTO times VALUES
(1,'Santos','Santos', 'Estádio Urbano Caldeira',1),
(2,'Palmeiras','São Paulo','Allianz Parque',1),
(3,'Corinthians','São Paulo','Neo Química Arena',1),
(4,'São Paulo','São Paulo','Estádio Cícero Pompeu de Toledo',1),
(5,'Ponte Preta','Campinas','Estádio Moisés Lucarelli',1),
(6,'Guarani','Campinas','Estádio Brinco de Ouro da Princesa',1),
(7,'São Bento','Sorocaba','Estádio Municipal de Sorocaba Walter Ribeiro',1),
(8,'Novorizontino','Novo Horizonte','Estádio Jorge Ismael de Biasi',1),
(9,'RB Brasil','Campinas', 'Estádio Moisés Lucarelli',1),
(10,'Mirassol','Mirassol','Estádio José Maria de Campos Maia',1),
(11,'Ferroviária','Araraquara','Arena Fonte Luminosa',1),
(12,'Bragantino','Bragança Paulista','Estádio Nabi Abi Chedid',1),
(13,'São Caetano','São Caetano do Sul','Estádio Municipal Anacleto Campanella',1),
(14,'Botafogo-SP','Ribeirão Preto','Estádio Santa Cruz - Botafogo FC Eurobike',1),
(15,'Ituano','Itu','Estádio Municipal Doutor Novelli Júnior',1),
(16,'Oeste','Barueri','Arena Barueri',1)

ALTER PROCEDURE SP_Grupo(@num SMALLINT, @retorno CHAR(1) OUTPUT)
AS

	IF (@num = 1) 
	BEGIN
		SET @retorno = 'A'
	END 

	IF (@num = 2) 
	BEGIN
		SET @retorno = 'B'
	END 

	IF (@num = 3) 
	BEGIN
		SET @retorno = 'C'
	END 

	IF (@num = 4) 
	BEGIN
		SET @retorno = 'D'
	END 


alter PROCEDURE SP_DivideTime_INS
AS

	TRUNCATE table grupos
	TRUNCATE table jogos
	UPDATE times SET ordenado = 1 

	DECLARE @cont SMALLINT
	SET @cont = 1
	DECLARE @saida CHAR(1)
	DECLARE @cod SMALLINT

	/* ----- ADICIONAR OS 4 PRIMEIROS TIMES ------ */
	WHILE @cont < 5
	BEGIN

		SET @cod = (SELECT codigoTime from times WHERE codigoTime = @cont)
		EXEC SP_Grupo @cont, @saida OUTPUT

		INSERT INTO grupos VALUES (@saida, @cod)
		UPDATE times SET ordenado = 0 WHERE codigoTime = @cod

		set @cont = @cont + 1
	END

	PRINT '4 primeiros inseridos com sucesso'

	SET @cont = 1

	/* ----- ADICIONAR OS OUTROS 12 TIMES ------ */
	DECLARE @grupo SMALLINT

	WHILE @cont < 13
	BEGIN

		DECLARE @aleatorioTime SMALLINT
		DECLARE @aleatorioGrupo SMALLINT

		SET @aleatorioTime = (ABS(CHECKSUM(NewId())) % 12 ) + 5
		SET @aleatorioGrupo = (ABS(CHECKSUM(NewId())) % 4 ) + 1

		SET @cod = (SELECT codigoTime from times WHERE codigoTime = @aleatorioTime AND ordenado = 1)

		DECLARE @saidaN char(1)
		EXEC SP_Grupo @aleatorioGrupo, @saidaN OUTPUT
		print @saidaN 


		IF ( (@cod IS NULL) OR (@cod='') )
		BEGIN
			PRINT 'o numero selecionado não está disponivel'
			SET @cont = @cont + 0
		END 
		ELSE
		BEGIN
			DECLARE @tamanho SMALLINT
			SET @tamanho = (SELECT COUNT(grupo) FROM grupos WHERE grupo = @saidaN)

			IF @tamanho >= 4
			BEGIN	
				PRINT 'o grupo já está cheio'
				SET @cont = @cont + 0
			END
			ELSE
			BEGIN
				UPDATE times SET ordenado = 0 WHERE codigoTime = @cod
				INSERT INTO grupos VALUES (@saidaN, @cod)
				SET @cont = @cont + 1
			END
		END
	END

	EXEC SP_DivideTime_INS
	select * from grupos ORDER BY grupo
	select * from times

/* ----------------------------- ATE AQUI FUNCIONA ----------------------------------- */

CREATE PROCEDURE SP_Verifica(@time smallint, @rodada smallint, @retorno varchar(10) output)
AS
	DECLARE @codigo smallint

	set @codigo = (select Rodada from jogos where timeb = @time AND Rodada = @rodada)

	if (@codigo is null)
	begin
		set @retorno = 'ok'
	end
	else
	begin
		set @retorno = 'nao'
	end 

/* -----------------------------  ESSA PROCEDURE TB FUNCIONA ----------------------------------- */
alter PROCEDURE SP_FormarJogo
AS
	TRUNCATE table jogos

	DECLARE @possibilidade TINYINT
	SET @possibilidade = 1

	DECLARE @grupoTimeA CHAR(1)
	DECLARE @grupoTimeB CHAR(1)
	DECLARE @inicio SMALLINT
	SET @inicio = 0

		IF (@possibilidade = 1)
		BEGIN
			SET @grupoTimeA = 'A'
			SET @grupoTimeB = 'B'
			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio 
			set @possibilidade = @possibilidade + 1
		END

		IF (@possibilidade = 2)
		BEGIN
			SET @grupoTimeA = 'C'
			SET @grupoTimeB = 'D'
			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio
			set @possibilidade = @possibilidade + 1
		END 

		SET @inicio = @inicio + 4

		IF (@possibilidade = 3)
		BEGIN
			SET @grupoTimeA = 'A'
			SET @grupoTimeB = 'C'

			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio
			set @possibilidade = @possibilidade + 1
		END

		IF (@possibilidade = 4)
		BEGIN
			SET @grupoTimeA = 'B'
			SET @grupoTimeB = 'D'
			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio
			set @possibilidade = @possibilidade + 1
		END

		SET @inicio = @inicio + 4

		IF (@possibilidade = 5)
		BEGIN
			SET @grupoTimeA = 'A'
			SET @grupoTimeB = 'D'
			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio
			set @possibilidade = @possibilidade + 1
		END

		IF (@possibilidade = 6)
		BEGIN
			SET @grupoTimeA = 'B'
			SET @grupoTimeB = 'C'
			EXEC SP_Rodadas @grupoTimeA, @grupoTimeB, @inicio
			set @possibilidade = @possibilidade + 1
		END 


	EXEC SP_FormarJogo
	select * from jogos order by Rodada

alter PROCEDURE SP_Rodadas(@GrupoManda CHAR(1), @GrupoVisit CHAR(1), @incio SMALLINT)
AS
	DECLARE @timeManda SMALLINT
	DECLARE @timeVisit SMALLINT

	DECLARE @contManda SMALLINT
	DECLARE @contVisit SMALLINT

	SET @contManda = 0
	SET @contVisit = 0

	WHILE @contManda < 4
	begin
		 
		SET @timeManda = (SELECT TOP (1) codigoTime from grupos WHERE grupo = @GrupoManda AND
			(codigoTime not in (SELECT TOP (@contManda) codigoTime FROM grupos WHERE grupo = @GrupoManda order by grupo, codigoTime)) order by grupo, codigoTime)
		print 'escolheu o mandante ' + cast(@timeManda as varchar(12))

		SET @contVisit = 0
		DECLARE @incioAUX SMALLINT
		set @incioAUX = @incio
		
		DECLARE @cont SMALLINT
		SET @cont = 0

		WHILE @contVisit < 4
		BEGIN
			if (@cont < 4)
			begin	
				
				print 'contvisit: ' + cast(@contVisit as varchar(12)) 
				print 'cont: ' + cast(@cont as varchar(12)) 

				set @timeVisit = 0
				SET @timeVisit = (SELECT TOP (1) codigoTime from grupos WHERE grupo = @GrupoVisit AND
				(codigoTime not in (SELECT TOP (@cont) codigoTime FROM grupos WHERE grupo = @GrupoVisit
				order by grupo, codigoTime)) order by grupo, codigoTime)

				print 'escolheu o visitante ' + cast(@timeVisit as varchar(12))


				DECLARE @resposta varchar(10) 
				DECLARE @incioAUX2 smallint
				set @incioAUX2 = @incioAUX + 1

				print 'verificar->' + cast(@timeVisit as varchar(12)) + ' - ' + cast (@incioAUX2 as varchar(12)) 

				exec SP_Verifica  @timeVisit,  @incioAUX2, @resposta output

				print @resposta


				if (@resposta = 'nao')
				begin
					print 'entrou no nao'
					set @cont = @cont + 1
				end
				ELSE
				BEGIN
					print 'entrou no sim'
					set @contVisit = @contVisit + 1
					set @incioAUX = @incioAUX + 1 
					print 'inserir->' + cast(@timeManda as varchar(12)) + ' - ' + cast(@timeVisit as varchar(12)) + ' - ' + cast(@incioAUX as varchar(12))
					insert into jogos values (@timeManda, @timeVisit, @incioAUX, null, null, null)
					set @cont = @cont + 1
				end
			end
			else 
			begin
				print 'vai zerar o cont'
				set @cont = 0
			end
		
		END

		set @contManda = @contManda + 1
	end

	EXEC SP_DatasRodadas

-------------------  fim da procedure ------------------

alter PROCEDURE SP_DatasRodadas
AS
	DECLARE @dataJogo DATE
	SET @dataJogo = '2019-01-16' --comeca no domingo

	DECLARE @rodada SMALLINT
	SET @rodada = 1

	WHILE (@rodada < 13)
	BEGIN
		IF ( (@rodada % 2) <> 0)
		BEGIN	
			SET @dataJogo = (select dateadd(day,4,@dataJogo))
			UPDATE jogos SET dataRod = @dataJogo WHERE Rodada = @rodada;
		END

		IF ((@rodada % 2) = 0)
		BEGIN
			SET @dataJogo = (select dateadd(day,3,@dataJogo))
			UPDATE jogos SET dataRod = @dataJogo WHERE Rodada = @rodada;
		END

		SET @rodada = @rodada + 1
	END

create TABLE jogos(
id SMALLINT PRIMARY KEY IDENTITY,
timeA SMALLINT,
timeb SMALLINT,
Rodada SMALLINT,
dataRod DATE,
golsTimeA SMALLINT,
golsTimeB SMALLINT
)

select * from jogos 

truncate table jogos

select * from grupos order by grupo, codigoTime
select * from jogos ORDER BY Rodada

exec SP_FormarJogo

DECLARE @resposta varchar(10) 
exec SP_Verifica  3, 5, @resposta output
print @resposta


CREATE FUNCTION fn_jogos(@data date)
RETURNS @table TABLE(
nomeTimeA VARCHAR(50),
nomeTimeB VARCHAR(50),
rodada SMALLINT,
id SMALLINT
)
AS
BEGIN
	INSERT INTO @table (nomeTimeA,nomeTimeB,rodada, id)
		select tm.NomeTime,tm2.NomeTime, jg.Rodada, jg.id
	from jogos jg 
	INNER JOIN times tm ON jg.timeA = tm.codigoTime
	INNER JOIN times tm2 ON jg.timeB = tm2.codigoTime
	WHERE dataRod =	@data

	RETURN 
END

select * from fn_jogos ('2019-01-23')

-------------------------------------------------------- Parte 2 ----------------------------------------------------------------
-- mudanca tabela jogos(adicionei a coluna de gols)

/* Triggers grupos e valor => nao permitir NSERT, UPDATE ou DELETE
   Trigger Jogo => não permitir INSERT e DELETE */

CREATE TRIGGER TriggerTimes ON times
FOR INSERT, DELETE, UPDATE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido excluir, inserir ou atualizar registros nessa tabela serviços', 16, 1)
END


CREATE TRIGGER TriggerGrupos ON grupos
FOR INSERT, DELETE, UPDATE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido excluir, inserir ou atualizar registros nessa tabela serviços', 16, 1)
END

CREATE TRIGGER TriggerJogos ON jogos
FOR INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido excluir, inserir ou atualizar registros nessa tabela serviços', 16, 1)
END

--Procedure que insere o placar dos jogos
ALTER Procedure InsereGols(@golsA SMALLINT, @golsB SMALLINT, @idJogo SMALLINT)
AS

	IF ( (@golsA is NULL) OR (@golsB is null) )
	BEGIN
		print 'nao vai fazer nada'
	END
	ELSE
	BEGIN
		UPDATE jogos SET golsTimeA = @golsA , golsTimeB = @golsB WHERE id = @idJogo
	END

	select * from jogos

--função para calcular as tabelas
ALTER FUNCTION fn_tabelaGrupos(@numGrupo CHAR)
RETURNS @grupo TABLE(
nomeTime VARCHAR(50),
jogos SMALLINT,
vitorias SMALLINT,
empates SMALLINT,
derrotas SMALLINT,
golsMarcados SMALLINT,
golsSofridos SMALLINT,
saldoGols SMALLINT,
pontos SMALLINT
)
AS
BEGIN
	DECLARE @contTimeTabela SMALLINT
	DECLARE @time SMALLINT
	set @contTimeTabela = 0

	-- Variaveis para calcular as informacoes da tabela
	DECLARE @nome VARCHAR(20)
	DECLARE @jogos SMALLINT
	DECLARE @vitorias SMALLINT
	DECLARE @derrotas SMALLINT
	DECLARE @empate SMALLINT
	DECLARE @golsMarcados SMALLINT
	DECLARE @golsSofridos SMALLINT
	DECLARE @saldoGols SMALLINT
	DECLARE @pontos SMALLINT

		-- while para cada time do grupo
		WHILE(@contTimeTabela < 4)
		BEGIN
			--seleciona os times com grupo igual ao do parametro
			SET @time = (SELECT TOP(1) codigoTime from grupos WHERE grupo = @numGrupo AND
				(codigoTime not in (SELECT TOP(@contTimeTabela) codigoTime FROM grupos WHERE grupo = @numGrupo)))	

			--zerando as informações 
			SET @nome = null
			SET @jogos = 0
			SET @vitorias = 0
			SET @derrotas = 0
			SET @empate = 0
			SET @golsMarcados = 0
			SET @golsSofridos = 0
			SET @saldoGols = 0
			SET @pontos = 0

			--- Variaveis para percorrer a tabela
			DECLARE @timeA smallint
			DECLARE @timeB smallint
			DECLARE @golsTimeA smallint
			DECLARE @golsTimeB smallint
			DECLARE c CURSOR FOR SELECT timeA, timeb, golsTimeA, golsTimeB FROM jogos
			
			OPEN c
			FETCH NEXT FROM c INTO @timeA, @timeB, @golsTimeA, @golsTimeB 

			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF @timeA = @time or @timeB = @time
				BEGIN 
					IF (@golsTimeA IS not NULL) OR  (@golsTimeB IS not NULL)
					BEGIN
						--nome do time
						SET @nome = (SELECT NomeTime FROM times WHERE codigoTime = @time)

						--calcula partidas jogadas
						SET @jogos = @jogos + 1

						--Calcula vitorias, derrotas, golsMarcados, golsSofridos, saldoGols, pontos

						IF(@time = @timeA)
						BEGIN
							--time A ganha
							IF(@golsTimeA > @golsTimeB)
							BEGIN	
								SET @vitorias = @vitorias + 1
								SET @golsMarcados = @golsTimeA + @golsMarcados
								SET @golsSofridos = @golsTimeB + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
								SET @pontos = @pontos + 3	
							END
							--time A perde
							IF(@golsTimeA < @golsTimeB)
							BEGIN	
								SET @derrotas = @derrotas + 1
								SET @golsMarcados = @golsTimeA + @golsMarcados
								SET @golsSofridos = @golsTimeB + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
							END
							--Empate
							IF(@golsTimeA = @golsTimeB)
							BEGIN	
								SET @empate = @empate + 1
								SET @golsMarcados = @golsTimeA + @golsMarcados
								SET @golsSofridos = @golsTimeB + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
								SET @pontos = @pontos + 1	
							END	
						END
						ELSE
						BEGIN
							--time B ganha
							IF(@golsTimeA < @golsTimeB)
							BEGIN	
								SET @vitorias = @vitorias + 1
								SET @golsMarcados = @golsTimeB + @golsMarcados
								SET @golsSofridos = @golsTimeA + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
								SET @pontos = @pontos + 3	
							END
							--time B perde
							IF(@golsTimeA > @golsTimeB)
							BEGIN	
								SET @derrotas = @derrotas + 1
								SET @golsMarcados = @golsTimeB + @golsMarcados
								SET @golsSofridos = @golsTimeB + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
							END
							--Empate
							IF(@golsTimeA = @golsTimeB)
							BEGIN	
								SET @empate = @empate + 1
								SET @golsMarcados = @golsTimeA + @golsMarcados
								SET @golsSofridos = @golsTimeB + @golsSofridos
								SET @saldoGols = @golsMarcados - @golsSofridos
								SET @pontos = @pontos + 1	
							END	
						END
					END
				END
				FETCH NEXT FROM c INTO @timeA, @timeB, @golsTimeA, @golsTimeB
			END

			--inserir na tabela da funcao
			INSERT INTO @grupo values (@nome,@jogos,@vitorias,@empate,@derrotas,@golsMarcados,@golsSofridos, @saldoGols,@pontos)


			CLOSE c
			DEALLOCATE c
		
			set @contTimeTabela = @contTimeTabela + 1
		END
	RETURN
END

--Função para montar a tabela geral
ALTER FUNCTION fn_tabelaGeral()
RETURNS @tabela TABLE(
nomeTime VARCHAR(50),
jogos SMALLINT,
vitorias SMALLINT,
empates SMALLINT,
derrotas SMALLINT,
golsMarcados SMALLINT,
golsSofridos SMALLINT,
saldoGols SMALLINT,
pontos SMALLINT
)
AS
BEGIN

	INSERT INTO @tabela select * from fn_tabelaGrupos('A')
	INSERT INTO @tabela select * from fn_tabelaGrupos('B')
	INSERT INTO @tabela select * from fn_tabelaGrupos('C')
	INSERT INTO @tabela select * from fn_tabelaGrupos('D')

	RETURN
END

Alter Function fn_Promovidos()
RETURNS @tabela TABLE(
nomeTime VARCHAR(50),
jogos SMALLINT,
vitorias SMALLINT,
empates SMALLINT,
derrotas SMALLINT,
golsMarcados SMALLINT,
golsSofridos SMALLINT,
saldoGols SMALLINT,
pontos SMALLINT
)
AS
BEGIN
		INSERT INTO @tabela select top(2) * from fn_tabelaGrupos('A') ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc
		INSERT INTO @tabela select top(2) * from fn_tabelaGrupos('B') ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc
		INSERT INTO @tabela select top(2) * from fn_tabelaGrupos('C') ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc
		INSERT INTO @tabela select top(2) * from fn_tabelaGrupos('D') ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc

	RETURN
END

select * from fn_Promovidos()







