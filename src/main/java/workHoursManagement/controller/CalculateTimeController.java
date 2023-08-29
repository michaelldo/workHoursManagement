package workHoursManagement.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.RegisterHours;
import model.WorkHours;

@WebServlet("/CalculateTime")
public class CalculateTimeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<WorkHours> workHoursList = new ArrayList<WorkHours>();
		RegisterHours register = new RegisterHours();
		String error = null;

		for (int i = 0; 3 > i; i++) {
			WorkHours wHours = new WorkHours();
			wHours.setStartTime(request.getParameter("startTime-" + i));
			wHours.setExittime(request.getParameter("exitTime-" + i));

			if (wHours.getStartTime() != null) {
				workHoursList.add(wHours);
			}
		}

		if (request.getParameter("count") != null) {
			int count = Integer.parseInt(request.getParameter("count"));
			;
			for (int i = 0; count > i; i++) {
				register.addHours((String) request.getParameter("registerHour-" + i));
			}
		}

		String returnCalculate = calculateAtrasoOuHoraExtra(workHoursList, register);

		request.setAttribute("horasCalculadas", returnCalculate);
		request.setAttribute("registerHours", register);
		request.setAttribute("workHours", workHoursList);
		request.setAttribute("error", error);
		RequestDispatcher rd = request.getRequestDispatcher("systemWorkHours.jsp");
		rd.forward(request, response);
	}

	public String calculateAtrasoOuHoraExtra(List<WorkHours> workHoursList, RegisterHours registerHours) {
		Duration totalWorkDuration = calculateTotalWorkDuration(workHoursList);
		Duration totalRegisterDuration = calculateTotalRegisterDuration(registerHours);

		Duration difference = totalWorkDuration.minus(totalRegisterDuration);

		if (difference.isNegative()) {
			return "Hora extra: " + formatDuration(difference.negated());
		} else {
			return "Atraso: " + formatDuration(difference);
		}
	}

	private Duration calculateTotalWorkDuration(List<WorkHours> workHoursList) {
		Duration totalDuration = Duration.ZERO;
		for (WorkHours wh : workHoursList) {
			totalDuration = totalDuration.plus(calculateDuration(wh.getStartTime(), wh.getExittime()));
		}
		return totalDuration;
	}

	private Duration calculateTotalRegisterDuration(RegisterHours registerHours) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime previousTime = null;
		Duration totalDuration = Duration.ZERO;

		for (String hour : registerHours.getMarcacao()) {
			LocalTime currentTime = LocalTime.parse(hour, formatter);
			if (previousTime != null) {
				totalDuration = totalDuration.plus(Duration.between(previousTime, currentTime));
			}
			previousTime = currentTime;
		}

		return totalDuration;
	}

	private Duration calculateDuration(String startTime, String exitTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime start = LocalTime.parse(startTime, formatter);
		LocalTime exit = LocalTime.parse(exitTime, formatter);
		return Duration.between(start, exit);
	}

	private Duration calculateDuration(String time) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime localTime = LocalTime.parse(time, formatter);
		return Duration.ofMinutes(localTime.getHour() * 60 + localTime.getMinute());
	}

	private String formatDuration(Duration duration) {
		long hours = duration.toHours();
		long minutes = duration.toMinutesPart();

		return hours + " hours and " + minutes + " minutes";
	}

}
