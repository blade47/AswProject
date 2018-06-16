package it.uniroma3.client;

import it.uniroma3.server.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.wildfly.naming.client.*; 
import javax.naming.spi.NamingManager;

public class RemoteEJBClient {

	public static void main(String[] args) throws Exception {
		Calculator calculator = lookupCalculatorEJB();
                 
		Account account = lookupAccountEJB();

		SessionCounter counter = lookupSessionCounterEJB();

		System.out.println("Crea un account con 1000€ ");

		account.createAccount(1000l);
		System.out.println("Deposita 250€ ");
		account.deposit(250);


		System.out.println("Preleva 500€ ");
		account.withdraw(500);

		long money = account.getMoney();
		System.out.println("Soldi rimasti " + money);
		float totalMoney = calculator.calculateInterest(money);
		System.out.println("Soldi tolti gli interessi " + totalMoney);


		System.out.println("SessionCounter AppClient: Ora invoco 20 volte il metodo getCounter() di un bean SessionCounter: ");
		for (int i=1; i<=20; i++) {
			System.out.println("SessionCounter AppClient: Invocazione " + i + ": " + counter.getCounter());
		}
		counter.close();
		System.out.println("SessionCounter AppClient: Ho finito di usare il bean SessionCounter");
	}

	private static SessionCounter lookupSessionCounterEJB() throws NamingException {

		final Context ctx = new InitialContext();
 

		return (SessionCounter) ctx.lookup("ejb:/server/SessionCounterEJB!it.uniroma3.server.SessionCounter?stateful");
	}

	private static Account lookupAccountEJB() throws NamingException {

		final Context ctx = new InitialContext();
 

		return (Account) ctx.lookup("ejb:/server/AccountEJB!it.uniroma3.server.Account?stateful");
	}

	private static Calculator lookupCalculatorEJB() throws NamingException {

		final Context context = new InitialContext();

		return (Calculator) context.lookup("ejb:/server/CalculatorEJB!it.uniroma3.server.Calculator");

	}
}
