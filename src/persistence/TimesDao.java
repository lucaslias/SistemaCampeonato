package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Grupo;
import model.Jogos;
//import java.sql.Types;

public class TimesDao {
	
	private Connection c;
	
	public TimesDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public String geraJogos() throws SQLException{
		String sql = "{CALL SP_FormarJogo}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		
		String saida = "As rodadas foram definidas";
		return saida;
	}
	
	public ArrayList<Jogos> mostraJogo(String data) throws SQLException, ClassNotFoundException{
		
		System.out.println("comeco do dao");
		
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Jogos> jogosLista = new ArrayList<Jogos>();
		
		
		String selectStatement = "select * from fn_jogos((?))";
		
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
		prepStmt.setString(1, data);
	    ResultSet rs = prepStmt.executeQuery();

	    while (rs.next()) {	
	    	Jogos jogo = new Jogos();
	    	jogo.setTimeA(rs.getString(1));
	    	jogo.setTimeb(rs.getString(2));
	    	jogo.setRodada(rs.getString(3));
	    	
	    	System.out.println("entrou dao");
	    	System.out.println("data no dao" + data);
	    	System.out.println("jogo no dao" + jogo);
	    	
	    	jogosLista.add(jogo);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return jogosLista;
	
	}
	
	
}