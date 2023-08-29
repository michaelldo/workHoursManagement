<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="model.RegisterHours"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Time"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="model.WorkHours"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
List<WorkHours> workHoursList = new ArrayList();
RegisterHours registerHours = new RegisterHours();

workHoursList = (ArrayList<WorkHours>) request.getAttribute("workHours");
registerHours = (RegisterHours) request.getAttribute("registerHours");
String err = (String) request.getAttribute("error");
String resultado = (String) request.getAttribute("horasCalculadas");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Work Hours Management</title>
<link rel="icon" href="images/logo.jpeg">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


</head>
<body>
	<nav class="navbar bg-body-tertiary bg-dark border-bottom border-body"
		data-bs-theme="dark">
		<div class="container-fluid col-6">
			<a class="navbar-brand" href="#"> <img src="images/logo.jpeg"
				alt="Logo" width="30" height="24"
				class="d-inline-block align-text-top"> Work Hours Management
			</a>
		</div>
		<div class="col-6">
			<%
			if (workHoursList != null && registerHours != null) {
			%>
			<form action="CalculateTime"
				class="container-fluid justify-content-start" method="post">
				<%
				if (err == null && workHoursList != null) {
					for (int i = 0; workHoursList.size() > i; i++) {
				%>
				<input type="hidden" name="startTime-<%=i%>"
					value="<%=workHoursList.get(i).getStartTime()%>"> <input
					type="hidden" name="exitTime-<%=i%>"
					value="<%=workHoursList.get(i).getExittime()%>">
				<%
				}
				}

				if (err == null && registerHours != null) {
				int count = 0;
				for (int i = 0; registerHours.getMarcacao().size() > i; i++) {
				%>

				<input type="hidden" name="registerHour-<%=i%>"
					value="<%=registerHours.getMarcacao().get(i)%>">
				<%
				count++;
				}
				%>
				<input type="hidden" name="count" value="<%=count%>">
				<%
				}
				%>

				<button class="btn btn-sm btn-outline-secondary" type="submit">Calcular
					Horas</button>
			</form>
			<%
			}
			%>
		</div>
	</nav>

	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
    <path
			d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
  </symbol>
  <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
    <path
			d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z" />
  </symbol>
  <symbol id="exclamation-triangle-fill" fill="currentColor"
			viewBox="0 0 16 16">
    <path
			d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
  </symbol>
</svg>

	<div class="container">
		<%
		if (resultado != null) {
		%>
		<div class="alert alert-warning alert-dismissible fade show"
			role="alert">
			<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img"
				aria-label="Danger:">
				<use xlink:href="#exclamation-triangle-fill" /></svg>
			<strong>Resultado: </strong>
			<%=resultado%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>
		<%
		if (err != null) {
		%>
		<div
			class="alert alert-danger d-flex align-items-center alert-dismissible fade show"
			role="alert">
			<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img"
				aria-label="Danger:">
				<use xlink:href="#exclamation-triangle-fill" /></svg>
			<div>
				<%=err%>
			</div>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>
		<form>
			<div class="row" style="margin-top: 25px;">
				<div class="col-sm-3 mb-3 mb-sm-0">
					<div class="card">
						<div class="card-header">Horário de trabalho</div>
						<div class="card-body form-floating mb-2">
							<table id="workHours" class="table table-striped"
								style="width: 100%">
								<thead>
									<tr>
										<th>Entrada</th>
										<th>Saída</th>
										<th>Opções</th>
									</tr>
								</thead>
								<tbody>
									<%
									if (workHoursList != null) {
										for (WorkHours wh : workHoursList) {
									%>
									<tr>
										<td><%=wh.getStartTime()%></td>
										<td><%=wh.getExittime()%></td>
										<td><input type="button" class="btn btn-primary"
											value="E" onclick="editWorkHours()"> <input
											type="button" value="X" class="btn btn-danger"
											onclick="excludeWorkHours()"></td>

									</tr>
									<%
									}
									}
									%>
								</tbody>
							</table>
							<button type="button" class="btn btn-outline-info"
								data-bs-toggle="modal" data-bs-target="#workHoursModal">Add.
								Horario</button>
						</div>

					</div>
				</div>
				<div class="col-sm-9">
					<div class="card">
						<div class="card-body">
							<table id="hoursTable" class="table table-striped"
								style="width: 100%">
								<thead>
									<tr>
										<%
										if (registerHours == null) {
										%><th>Sem Marcações registradas</th>
										<%
										}
										%>
										<%
										if (registerHours != null) {
											for (int i = 0; registerHours.getMarcacao().size() > i; i++) {
										%>
										<th>Marcação: <%=i + 1%></th>
										<%
										}
										}
										%>
									</tr>
								</thead>
								<tbody>
									<tr>
										<%
										if (registerHours == null) {
										%><td>00:00</td>
										<%
										}
										%>
										<%
										if (registerHours != null) {
											for (String marcacao : registerHours.getMarcacao()) {
										%>
										<td><%=marcacao%></td>

										<%
										}
										}
										%>
									</tr>
								</tbody>
							</table>
							<%
							if (workHoursList != null) {
								if (workHoursList.size() >= 1) {
							%>
							<button type="button" class="btn btn-outline-success"
								data-bs-toggle="modal" data-bs-target="#registerHoursModal">Add.
								Horario</button>
							<%
							}
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="workHoursModal" tabindex="-1"
		aria-labelledby="workHoursModal" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="workHoursModalLabel">Horário
						de trabalho</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="insertWorkHours" name="formWorkHours" method="post">
						<%
						if (err == null && workHoursList != null) {
							for (int i = 0; workHoursList.size() > i; i++) {
						%>
						<input type="hidden" name="startTime-<%=i%>"
							value="<%=workHoursList.get(i).getStartTime()%>"> <input
							type="hidden" name="exitTime-<%=i%>"
							value="<%=workHoursList.get(i).getExittime()%>">
						<%
						}
						}
						%>
						<div class="row g-2">
							<div class="col-md">
								<label for="startTime">Hora Entrada</label> <input type="time"
									id="startTime" name="startTime" class="form-control">
							</div>
							<div class="col-md">
								<label for="exitTime">Hora Saída</label> <input type="time"
									id="exitTime" name="exitTime" class="form-control">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="button" onclick="addWorkHours()"
						class="btn btn-primary">Salvar</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="registerHoursModal" tabindex="-1"
		aria-labelledby="workHoursModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="registerTimeModalLabel">Marcar
						Horário</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="RegisterHours" name="formRegisterHours" method="post">
						<%
						if (err == null && workHoursList != null) {
							for (int i = 0; workHoursList.size() > i; i++) {
						%>
						<input type="hidden" name="startTime-<%=i%>"
							value="<%=workHoursList.get(i).getStartTime()%>"> <input
							type="hidden" name="exitTime-<%=i%>"
							value="<%=workHoursList.get(i).getExittime()%>">
						<%
						}
						}

						if (err == null && registerHours != null) {
						int count = 0;
						for (int i = 0; registerHours.getMarcacao().size() > i; i++) {
						%>

						<input type="hidden" name="registerHour-<%=i%>"
							value="<%=registerHours.getMarcacao().get(i)%>">
						<%
						count++;
						}
						%>
						<input type="hidden" name="count" value="<%=count%>">
						<%
						}
						%>

						<div class="row g-2">
							<div class="col-sm-4">
								<label for="registerTime">defina o horário</label> <input
									type="time" id="registerTime" name="registerTime"
									class="form-control">
							</div>
							<div class="col-sm-2"
								style="margin-top: 18px; padding-left: 30px;">
								<h6>
									<br>OU
								</h6>
							</div>
							<div class="col-sm-4 form-check form-switch"
								style="margin-top: 33px;">
								<label for="timeNow" class="form-check-label">Horário
									Agora</label> <input class="form-check-input" type="checkbox"
									id="timeNow" name="timeNow">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Cancelar</button>
					<button type="button" class="btn btn-primary"
						onclick="addRegisterHours()">Salvar</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
	<script src="js/workHours.js"></script>
</body>
</html>
