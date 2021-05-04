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


@WebServlet("/quartas")
public class ServletQuartas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletQuartas() {
        super(); 
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Classificacao> quartasA = new ArrayList<>();
		ArrayList<Classificacao> quartasB= new ArrayList<>();
		ArrayList<Classificacao> quartasC = new ArrayList<>();
		ArrayList<Classificacao> quartasD = new ArrayList<>();
		
		try {
			ClassificacaoDAO cDao = new ClassificacaoDAO();	
			quartasA = cDao.QuartasDeFinal("A");
			quartasB = cDao.QuartasDeFinal("B");
			quartasC = cDao.QuartasDeFinal("C");
			quartasD = cDao.QuartasDeFinal("D");

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 
		
		request.setAttribute("quartasA", quartasA);
		request.setAttribute("quartasB", quartasB);
		request.setAttribute("quartasC", quartasC);
		request.setAttribute("quartasD", quartasD);
		request.getRequestDispatcher("/Quartas.jsp").forward(request, response);
	}

}