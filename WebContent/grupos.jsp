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
			<a class="navbar-brand" href="#">Campeonato Paulista</a>
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
						href="http://localhost:8080/CampeonatoPaulista/jogos.jsp">Tabela de Jogos</a>
					</li>
					
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

	<br>
	<br>

	<center>
		<h1>Tabelas</h1>
		<form action="MostraGrupos" method="post">
			<input type="submit" name="enviar" id="inviar" value="dividir os grupo">
		</form>
	</center>

	<br>
	<br>


	<div class="container-fluid">
		<div class="row">

			<div class="col-md-3">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Grupo A</th>

						</tr>
					</thead>
					<tbody>

						<c:forEach var="Grupo" items="${Grupo_A}">
							<tr class="table-active">
								<td>${Grupo.getCodigoTime()}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>

			<div class="col-md-3">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Grupo B</th>

						</tr>
					</thead>
					<tbody>

						<c:forEach var="Grupo" items="${Grupo_B}">
							<tr class="table-active">
								<td>${Grupo.getCodigoTime()}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>

			<div class="col-md-3">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Grupo C</th>

						</tr>
					</thead>
					<tbody>

						<c:forEach var="Grupo" items="${Grupo_C}">
							<tr class="table-active">
								<td>${Grupo.getCodigoTime()}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>

			<div class="col-md-3">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Grupo D</th>

						</tr>
					</thead>
					<tbody>

						<c:forEach var="Grupo" items="${Grupo_D}">
							<tr class="table-active">
								<td>${Grupo.getCodigoTime()}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>
		</div>
</body>
</html>