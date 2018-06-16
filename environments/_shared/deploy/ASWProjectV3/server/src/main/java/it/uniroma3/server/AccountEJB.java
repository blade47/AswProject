package it.uniroma3.server;

import javax.ejb.Remote;
import javax.ejb.Stateful;

@Stateful
@Remote(Account.class)
public class AccountEJB implements Account {

    long money;
 
    
	@Override
	public long getMoney() {
		return money;

	}

	public void createAccount(long amount)  
	{
		this.money= amount;
		 
	}

	@Override
	public void deposit(long amount)  
	{
		 
			this.money+= amount;
			 
		System.out.println("Soldi depositati. Il totale e' "+money);
	}
 
	 
	@Override
	public void withdraw(long amount){
		
		long newAmount = money - amount;
		if (newAmount < 0) {
			System.out.println("Soldi insufficienti! ");
		}
		else{
			money = newAmount;
		}
	
		System.out.println("Soldi prelevati. Il totale riamsto e' "+money);
	}
}
