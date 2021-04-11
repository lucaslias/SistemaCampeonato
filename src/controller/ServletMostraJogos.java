package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Grupo;
import model.Jogos;
import persistence.GrupoDao;
import persistence.TimesDao;


@WebServlet("/Mostrajogos")
public class ServletMostraJogos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletMostraJogos() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String data  = request.getParameter("data");

		ArrayList<Jogos> jogosLista = new ArrayList<>();
		
		try {
			TimesDao cDao = new TimesDao();
			jogosLista= cDao.mostraJogo(data);
		} catch (ClassNotFoundException | SQLException e) {
			 e.getMessage();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("jogos.jsp");
			
			if(jogosLista.isEmpty()) {
				request.setAttribute("mensagem", "não há jogos nesse dia");
				rd.forward(request, response);
			}
			else {
				request.setAttribute("jogo", jogosLista);
				rd.forward(request, response);
			}
			
		}
		
		
	
	}

}