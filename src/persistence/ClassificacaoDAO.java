package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Classificacao;
import model.Grupo;

public class ClassificacaoDAO {
	
	private Connection c;
	
	public ClassificacaoDAO() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public ArrayList<Classificacao> ClassGrupo(String grupo) throws SQLException, ClassNotFoundException{
		
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Classificacao> Lista = new ArrayList<Classificacao>();
		
		String selectStatement = "select * from fn_tabelaGrupos((?)) ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
		prepStmt.setString(1, grupo);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) {	
	    	Classificacao time = new Classificacao();
	    	time.setNomeTime(rs.getString("NomeTime"));
	    	time.setJogos(rs.getString("jogos"));
	    	time.setVitorias(rs.getString("vitorias"));
	    	time.setEmpates(rs.getString("empates"));
	    	time.setDerrotas(rs.getString("derrotas"));
	    	time.setGolsMarcados(rs.getString("golsMarcados"));
	    	time.setGolsSofridos(rs.getString("golsSofridos"));
	    	time.setSaldoGols(rs.getString("saldoGols"));
	    	time.setPonto(rs.getString("pontos"));
	    	
	    	Lista.add(time);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return Lista;
		
	}


	public ArrayList<Classificacao> ClassGeral() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Classificacao> Lista = new ArrayList<Classificacao>();
		
		String selectStatement = "select * from fn_tabelaGeral() ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) {	
	    	Classificacao time = new Classificacao();
	    	time.setNomeTime(rs.getString("NomeTime"));
	    	time.setJogos(rs.getString("jogos"));
	    	time.setVitorias(rs.getString("vitorias"));
	    	time.setEmpates(rs.getString("empates"));
	    	time.setDerrotas(rs.getString("derrotas"));
	    	time.setGolsMarcados(rs.getString("golsMarcados"));
	    	time.setGolsSofridos(rs.getString("golsSofridos"));
	    	time.setSaldoGols(rs.getString("saldoGols"));
	    	time.setPonto(rs.getString("pontos"));
	    	
	    	Lista.add(time);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return Lista;
	}
	
	public ArrayList<Classificacao> rebaixados() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Classificacao> ListaReba = new ArrayList<Classificacao>();
		
		String selectStatement = "select top(4) * from fn_tabelaGeral() ORDER BY pontos asc, vitorias asc, golsMarcados asc, saldoGols asc";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) {	
	    	Classificacao time = new Classificacao();
	    	time.setNomeTime(rs.getString("NomeTime"));
	    	time.setJogos(rs.getString("jogos"));
	    	time.setVitorias(rs.getString("vitorias"));
	    	time.setEmpates(rs.getString("empates"));
	    	time.setDerrotas(rs.getString("derrotas"));
	    	time.setGolsMarcados(rs.getString("golsMarcados"));
	    	time.setGolsSofridos(rs.getString("golsSofridos"));
	    	time.setSaldoGols(rs.getString("saldoGols"));
	    	time.setPonto(rs.getString("pontos"));
	    	
	    	ListaReba.add(time);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return ListaReba;
	}
	
	
	public ArrayList<Classificacao> promovidos() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Classificacao> ListaAprov = new ArrayList<Classificacao>();
		
		String selectStatement = "select * from fn_Promovidos()";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) {	
	    	Classificacao time = new Classificacao();
	    	time.setNomeTime(rs.getString("NomeTime"));
	    	time.setJogos(rs.getString("jogos"));
	    	time.setVitorias(rs.getString("vitorias"));
	    	time.setEmpates(rs.getString("empates"));
	    	time.setDerrotas(rs.getString("derrotas"));
	    	time.setGolsMarcados(rs.getString("golsMarcados"));
	    	time.setGolsSofridos(rs.getString("golsSofridos"));
	    	time.setSaldoGols(rs.getString("saldoGols"));
	    	time.setPonto(rs.getString("pontos"));
	    	
	    	ListaAprov.add(time);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return ListaAprov;
	}
	
	
	public ArrayList<Classificacao> QuartasDeFinal(String grupo) throws SQLException, ClassNotFoundException{
		
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Classificacao> Lista = new ArrayList<Classificacao>();
		
		String selectStatement = "select top(2) * from fn_tabelaGrupos((?)) ORDER BY pontos desc, vitorias desc, golsMarcados desc, saldoGols desc";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
		prepStmt.setString(1, grupo);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) {	
	    	Classificacao time = new Classificacao();
	    	time.setNomeTime(rs.getString("NomeTime"));
	    	Lista.add(time);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return Lista;
		
	}
	

	
}
