package workHoursManagement.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.MidiDeviceTransmitter;

import model.RegisterHours;
import model.WorkHours;


@WebServlet("/RegisterHours")
public class RegisterHoursController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<WorkHours> workHoursList = new ArrayList<WorkHours>();
		RegisterHours register = new RegisterHours();
		String error = null;
		
		if (request.getParameter("count") != null) {
			int count = Integer.parseInt(request.getParameter("count")); ;
			for(int i = 0; count > i; i++) {
				register.addHours((String) request.getParameter("registerHour-" + i));
			}
		}

		if ("on".equals(request.getParameter("timeNow"))) {
			SimpleDateFormat smt = new SimpleDateFormat("HH:mm");
			register.addHours(smt.format(new Date()));
		}else {
			register.addHours(request.getParameter("registerTime"));
		}		
		
		for (int i = 0; 3 > i; i++) {
			WorkHours wHours = new WorkHours();
			wHours.setStartTime(request.getParameter("startTime-" + i));
			wHours.setExittime(request.getParameter("exitTime-" + i));

			if (wHours.getStartTime() != null) {
				workHoursList.add(wHours);
			}
		}
		
		
		request.setAttribute("registerHours", register);
		request.setAttribute("workHours", workHoursList);
		request.setAttribute("error", error);
		RequestDispatcher rd = request.getRequestDispatcher("systemWorkHours.jsp");
		rd.forward(request, response);
	}

}
