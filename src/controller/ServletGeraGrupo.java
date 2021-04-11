package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.GrupoDao;


@WebServlet("/divideGrupo")
public class ServletGeraGrupo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletGeraGrupo() {
        super(); 
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saida="";
		
		try {
			GrupoDao cDao = new GrupoDao();
			saida = cDao.divideTimes();
		} catch (ClassNotFoundException | SQLException e) {
			saida = e.getMessage();
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("saidagrupo", saida);
			rd.forward(request, response);
		}
		
		
	
	}

}
