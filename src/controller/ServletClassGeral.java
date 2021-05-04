package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Classificacao;
import persistence.ClassificacaoDAO;


@WebServlet("/geral")
public class ServletClassGeral extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletClassGeral() {
        super(); 
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Classificacao> tabela = new ArrayList<>();
		ArrayList<Classificacao> rebaixados = new ArrayList<>();
		ArrayList<Classificacao> promovidos = new ArrayList<>();
		
		try {
			ClassificacaoDAO cDao = new ClassificacaoDAO();	
			tabela = cDao.ClassGeral();
			rebaixados = cDao.rebaixados();
			promovidos = cDao.promovidos();
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 
		
		request.setAttribute("tabela", tabela);
		request.setAttribute("rebaixados", rebaixados);
		request.setAttribute("promovidos", promovidos);
		request.getRequestDispatcher("/TabelaGeral.jsp").forward(request, response);
	}
	

}