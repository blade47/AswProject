package it.uniroma3.server;

import it.uniroma3.server.SessionCounter;

import javax.annotation.PostConstruct;
import javax.ejb.Remove;
import javax.ejb.Stateful;
import javax.ejb.Remote;

/**
 * Session Bean implementation class SessionCounterImpl
 */
@Stateful
@Remote(SessionCounter.class)
public class SessionCounterEJB implements SessionCounter {

	private int counter;

	/* inizializza un'istanza del bean, assegnando un valore iniziale al contatore */
	@PostConstruct
	public void initialize() {

		System.out.println("SessionCounter: initializing SessionCounter instance");
		this.counter = 0;
	}

	@Override
	/* incrementa il contatore e ne restituisce il valore */
	public int getCounter() {
		counter++;
		System.out.println("SessionCounter: getCounter() ==> " + counter);
		return counter;
	}

	@Override
	@Remove
	/* termina la sessione */
	public void close() {
		/* effettivamente, il contenitore termina la sessione */
	}

}
