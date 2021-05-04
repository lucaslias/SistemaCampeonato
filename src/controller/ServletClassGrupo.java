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
import persistence.GrupoDao;


@WebServlet("/ClassificacaoG")
public class ServletClassGrupo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletClassGrupo() {
        super(); 
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Classificacao> grupoA = new ArrayList<>();
		ArrayList<Classificacao> grupoB = new ArrayList<>();
		ArrayList<Classificacao> grupoC = new ArrayList<>();
		ArrayList<Classificacao> grupoD = new ArrayList<>();
		ArrayList<Classificacao> rebaixados = new ArrayList<>();
		
		try {
			ClassificacaoDAO cDao = new ClassificacaoDAO();	
			grupoA = cDao.ClassGrupo("A");
			grupoB = cDao.ClassGrupo("B");
			grupoC = cDao.ClassGrupo("C");
			grupoD = cDao.ClassGrupo("D");
			rebaixados = cDao.rebaixados();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 
		
		request.setAttribute("GrupoA", grupoA);
		request.setAttribute("GrupoB", grupoB);
		request.setAttribute("GrupoC", grupoC);
		request.setAttribute("GrupoD", grupoD);
		request.setAttribute("rebaixados", rebaixados);
		request.getRequestDispatcher("/tabela.jsp").forward(request, response);
	}

}