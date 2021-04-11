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
import persistence.GrupoDao;
import persistence.TimesDao;


@WebServlet("/MostraGrupos")
public class ServletMostraGrupo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletMostraGrupo() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ArrayList<Grupo> grupoLista = new ArrayList<>();
		
		try {
			GrupoDao cDao = new GrupoDao();	
			grupoLista = cDao.mostraGrupo();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 

		@SuppressWarnings("unchecked")
        ArrayList<Grupo> agrupamentos[] = new ArrayList[4];
        
        for(int i = 0; i<agrupamentos.length; i++) {
            agrupamentos[i] = new ArrayList<Grupo>();
        }
        
        for(Grupo g : grupoLista) {
            String grupo = g.getGrupo();
            if(grupo.equalsIgnoreCase("a")) {
                agrupamentos[0].add(g);
            }else if(grupo.equalsIgnoreCase("b")) {
                agrupamentos[1].add(g);
            }else if(grupo.equalsIgnoreCase("c")) {
                agrupamentos[2].add(g);
            }else {
                agrupamentos[3].add(g);
            }
        }
        for(ArrayList<Grupo> listagens : agrupamentos) {
            request.setAttribute("Grupo_"+listagens.get(0).getGrupo(), listagens);
        }
        request.getRequestDispatcher("/grupos.jsp").forward(request, response);
    }


}