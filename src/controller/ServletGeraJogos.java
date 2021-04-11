package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import persistence.TimesDao;


@WebServlet("/divideJogos")
public class ServletGeraJogos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletGeraJogos() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saida="";
		
		try {
			TimesDao cDao = new TimesDao();
			saida = cDao.geraJogos();
		} catch (ClassNotFoundException | SQLException e) {
			saida = e.getMessage();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("saidajogo", saida);
			rd.forward(request, response);
		}
		
		
	
	}

}