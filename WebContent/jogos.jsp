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
						href="http://localhost:8080/CampeonatoPaulista/grupos.jsp">Tabela de Grupo</a></li>
							
				    <li class="nav-item">
          				<a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/tabela.jsp">Classificação por Grupos</a>
        			</li>
        
        			<li class="nav-item">
          				<a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/TabelaGeral.jsp">Classificação Geral</a>
        			</li>
        
        			<li class="nav-item">
          				<a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/Quartas.jsp">Quartas de final</a>
        			</li>
        			
				</ul>
				<span class="navbar-text"> feito por: Lucas Guilherme </span>
			</div>
		</div>
	</nav>

	<br><br>
	
	<center>
		<form action="Mostrajogos" method="post">
			<input type="date" name="data" id="data"> 
			<input type="submit" name="enviar" id="inviar" value="ver Jogos">
		</form>
		
		<br><br>
	
		<c:out value="${mensagem}"> </c:out>
	
		<div class="container-fluid">
			<div class="row">

				<div class="col-md-12">
					<table class="table table-bordered">
						<thead>
							<tr align="center">
								<th>Time A</th>
								<th>placar</th>
								<th> x </th>
								<th>placar</th>
								<th>Time b</th>
								<th>Rodada</th>
							</tr>
						</thead>
						<tbody>

						<form action="insereResultado" method="post">
						
						<c:set var ="contA" value="1" scope="page"> </c:set>
						<c:set var ="contB" value="9" scope="page"> </c:set>
						<c:set var ="contC" value="20" scope="page"> </c:set>
						
							<c:forEach var="jogoN" items="${jogo}">
								<tr align="center" class="table-active">
									<td>${jogoN.getTimeA()}</td>
									
									<input type ="hidden" name="${contC}" value="${jogoN.getId()}"/>
									
									<td><input type="number" name="${contA}" placeholder="0"></td>
																		
									<td> x </td>
									
									<td><input type="number" name="${contB}" placeholder="0"></td>
									
									<td>${jogoN.getTimeb()}</td>
									<td>${jogoN.getRodada()}</td>
									<td>${jogoN.getId()}</td>
	
								</tr>
								
							<c:set var="contA" value="${contA+1}" scope="page"/>
							<c:set var="contB" value="${contB+1}" scope="page"/>
							<c:set var="contC" value="${contC+1}" scope="page"/>							
							</c:forEach>
							
							<tr align="center"> 
								<td colspan="6"> <input type="submit" name="enviar" id="inviar" value="enviar"> </td>
							</tr>
						</form>

						</tbody>
					</table>
				</div>
			</div>
		</div>
		<center>
</body>
</html>


