package it.uniroma3.server;

public interface Account {


	public void deposit(long amount);
	public void withdraw(long amount);
	
	public long getMoney();
	public void createAccount(long amount);
}