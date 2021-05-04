<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Campeonato Paulista</title>
</head>
<body>

	<!------------ menu das coisa ---------------->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Bem Vindo ao Campeonato Paulista</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">

					<li class="nav-item"><a class="nav-link" id=grupo
						href="http://localhost:8080/CampeonatoPaulista/">Home</a></li>
						
					<li class="nav-item"><a class="nav-link"
						href="http://localhost:8080/CampeonatoPaulista/grupos.jsp">Tabela de Grupo</a>
					</li>

					<li class="nav-item"><a class="nav-link"
						href="http://localhost:8080/CampeonatoPaulista/jogos.jsp">Tabela de Jogos</a></li>	
						
					<li class="nav-item">
          				<a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/tabela.jsp">Classificação por Grupos</a>
        			</li>
        
        			<li class="nav-item">
          				<a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/Quartas.jsp">Quartas de final</a>
        			</li>
					
				</ul>
				<span class="navbar-text"> feito por: Lucas Guilherme e Diego Ribeiro</span>
			</div>
		</div>
	</nav>

	<br>
	<br>

	<center>
		<h1>Classificação Geral</h1><br>
		
		<div class="btn-group">
			<form action="geral" method="post">
				<input type="submit" name="enviar" id="inviar" value="Mostrar">
			</form>
		</div>
	</center>

	<br>
	<br>


	<div class="container-fluid">
		<div class="row">

			<div class="col-md-12">
				<table class="table table-bordered">
					<thead>
						<tr align="center">
							<th colspan="9"> Classificação Serie A</th>
						<tr>					
						
						<tr align="center">
							<th>time</th>
							<th>Jogo</th>
							<th>Vitorias</th>
							<th>Empate</th>
							<th>Derrotas</th>
							<th>Gols Marcados</th>
							<th>Gols Sofridos</th>
							<th>Saldo de Gols</th>
							<th>Pontos</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach var="Grupo" items="${tabela}">
						
							<c:set var ="cond" value="0" scope="page"> </c:set>
							
							<c:forEach var="rebaixado" items="${promovidos}">							
								<c:if test="${Grupo.getNomeTime() == rebaixado.getNomeTime()}">
									<c:set var ="cond" value="1" scope="page"> </c:set>
									<tr style="background-color:#90EE90" align="center">			
										<td>${Grupo.getNomeTime()}</td>
										<td>${Grupo.getJogos()}</td>
										<td>${Grupo.getVitorias()}</td>
										<td>${Grupo.getEmpates()}</td>
										<td>${Grupo.getDerrotas()}</td>
										<td>${Grupo.getGolsMarcados()}</td>
										<td>${Grupo.getGolsSofridos()}</td>
										<td>${Grupo.getSaldoGols()}</td>
										<td>${Grupo.getPonto()}</td>
									</tr>
								</c:if>
							</c:forEach>
							
							<c:forEach var="rebaixado" items="${rebaixados}">							
								<c:if test="${Grupo.getNomeTime() == rebaixado.getNomeTime()}">
									<c:set var ="cond" value="2" scope="page"> </c:set>
									<tr style="background-color:#FA8072" align="center">			
										<td>${Grupo.getNomeTime()}</td>
										<td>${Grupo.getJogos()}</td>
										<td>${Grupo.getVitorias()}</td>
										<td>${Grupo.getEmpates()}</td>
										<td>${Grupo.getDerrotas()}</td>
										<td>${Grupo.getGolsMarcados()}</td>
										<td>${Grupo.getGolsSofridos()}</td>
										<td>${Grupo.getSaldoGols()}</td>
										<td>${Grupo.getPonto()}</td>
									</tr>
								</c:if>
							</c:forEach>
						
							<c:if test="${cond == 0}">
								<tr class="table-active" align="center">
									<td>${Grupo.getNomeTime()}</td>
									<td>${Grupo.getJogos()}</td>
									<td>${Grupo.getVitorias()}</td>
									<td>${Grupo.getEmpates()}</td>
									<td>${Grupo.getDerrotas()}</td>
									<td>${Grupo.getGolsMarcados()}</td>
									<td>${Grupo.getGolsSofridos()}</td>
									<td>${Grupo.getSaldoGols()}</td>
									<td>${Grupo.getPonto()}</td>
								</tr>
							</c:if>
							
							
						</c:forEach>

					</tbody>
				</table>
			</div>
			
</body>
</html>