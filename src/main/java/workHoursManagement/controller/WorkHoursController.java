package workHoursManagement.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.WorkHours;

@WebServlet("/insertWorkHours")
public class WorkHoursController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<WorkHours> workHoursList = new ArrayList<WorkHours>();
		String error = null;

		for (int i = 0; 3 > i; i++) {
			WorkHours wHours = new WorkHours();
			wHours.setStartTime(request.getParameter("startTime-" + i));
			wHours.setExittime(request.getParameter("exitTime-" + i));

			if (wHours.getStartTime() != null) {
				workHoursList.add(wHours);
			}
		}

		if (workHoursList.size() != 3) {
			WorkHours hoursToWork = new WorkHours();
			hoursToWork.setStartTime(request.getParameter("startTime"));
			hoursToWork.setExittime(request.getParameter("exitTime"));

			workHoursList.add(hoursToWork);
		} else {
			error = "Não é possível adicionar mais horas, limite de 3 alcançado";
		}

		request.setAttribute("workHours", workHoursList);
		request.setAttribute("error", error);
		RequestDispatcher rd = request.getRequestDispatcher("systemWorkHours.jsp");
		rd.forward(request, response);
	}

}
