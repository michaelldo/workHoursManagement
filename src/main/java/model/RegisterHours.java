package model;

import java.util.ArrayList;
import java.util.List;

public class RegisterHours {

	List<String> marcacao = new ArrayList<>();

	public void addHours(String hours) {
		marcacao.add(hours);
	}

	public List<String> getMarcacao() {
		return marcacao;
	}

	public void setMarcacao(List<String> marcacao) {
		this.marcacao = marcacao;
	}

}
