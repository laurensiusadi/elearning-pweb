#include <iostream>

using namespace std;

class Account 
{
	public:
    	Account (int blc) 
		{
      		if (blc >= 0) 
     	   		setBalance(blc);
     		else 
			{
    			setBalance(0);
    	    	cout << "Initial value cannot be less than 0" << endl;
    		}
    	}
    
    	void credit(int blc) 
		{
      		balance += blc;
    	}
    
 	   void debit(int blc) 
		{
    	  	if (blc > balance)
    	    	cout << "Debit amount exceeded account balance" << endl;
    	  	else 
    			balance -= blc;
    	}
    
 	   int getBalance() 
		{
    		return balance;
   	 	}
    
  	  	int setBalance(int blc) 
		{
      		balance = blc;
    	}

	private:
    	int balance;
};

int main() {
  return 0;
}
