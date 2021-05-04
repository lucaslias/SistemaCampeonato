<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<title> Campeonato Paulista</title>
</head>
<style>
body {
    background-color:#DCDCDC; 
}
</style>

<body>
	<!------------ menu das coisa ---------------->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Bem Vindo ao Campeonato Paulista</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
        <li class="nav-item">
          <a class="nav-link" id=grupo href="http://localhost:8080/CampeonatoPaulista/grupos.jsp">Tabela de Grupos</a>
        </li>
        
         <li class="nav-item">
          <a class="nav-link" href="http://localhost:8080/CampeonatoPaulista/jogos.jsp">Tabela de Jogos</a>
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
      <span class="navbar-text">
        feito por: Lucas Guilherme
      </span>
    </div>
  </div>
</nav>

	<br><br><br><br><br>
	<!------------ botos Principais---------------->
	<div align="center">
		<form action="divideGrupo" method="post">
			<input type="submit" name="enviar" id="inviar" class="btn btn-success btn-lg" value="dividir os grupo ">		
		</form>
		
		<br><br><br>
		
		<form action="divideJogos" method="post">
			<input type="submit" name="enviar" id="inviar" class="btn btn-primary btn-lg" value=" gerar os jogos ">
		</form>
		
		<br><br><br><br>
		

		
		<c:out value="${saidagrupo}"> </c:out>
		<c:out value="${saidajogo}"> </c:out>
		
	</div>
	
</body>
</html>