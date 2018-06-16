package it.uniroma3.server;

public interface SessionCounter {

	/* incrementa il contatore e ne restituisce il valore */
	public int getCounter();

	/* termina la sessione */
	public void close();

}
