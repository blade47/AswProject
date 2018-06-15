package it.uniroma3.client;

import java.util.Hashtable;

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
		System.out.println("Create Account with 1000$ ");

		account.createAccount(1000l);
		System.out.println("Deposit 250$ ");
		account.deposit(250);


		System.out.println("Withdraw 500$ ");
		account.withdraw(500);

		long money = account.getMoney();
		System.out.println("Money left " + money);
		float totalMoney = calculator.calculateInterest(money);
		System.out.println("Money plus interests " + totalMoney);


	}

	private static Account lookupAccountEJB() throws NamingException {
		final Hashtable<String, String> jndiProperties = new Hashtable<String, String>();
 
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY,  "org.wildfly.naming.client.WildFlyInitialContextFactory");
        jndiProperties.put(Context.PROVIDER_URL,"remote+http://10.11.1.151:8080");
                // Pure HTTP
		//jndiProperties.put(Context.PROVIDER_URL,"http://10.11.1.101:8080/wildfly-services");

		final Context ctx = new InitialContext(jndiProperties);
 

		return (Account) ctx
				.lookup("ejb:/server/AccountEJB!it.uniroma3.server.Account?stateful");
	}

	private static Calculator lookupCalculatorEJB() throws NamingException {
		final Hashtable<String, String> jndiProperties = new Hashtable<String, String>();
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY,  "org.wildfly.naming.client.WildFlyInitialContextFactory");
        jndiProperties.put(Context.PROVIDER_URL,"remote+http://10.11.1.151:8080");

                // Pure HTTP  
                //jndiProperties.put(Context.PROVIDER_URL,"http://10.11.1.101:8080/wildfly-services");
		final Context context = new InitialContext(jndiProperties);

		return (Calculator) context
				.lookup("ejb:/server/CalculatorEJB!it.uniroma3.server.Calculator");

	}
}
