#include <iostream>
#include <string>

using namespace std;

class Invoice 
{
	public:
		Invoice (string numb, string desc, int qtty, int prc) 
    	{
			number = numb;
			partDescription = desc;
			quantity = qtty;
			price = prc;
		}
		
		void setNumber (string numb) 
    	{
			number = numb;
		}
		
		void setPartDescription (string desc) 
    	{
			partDescription = desc;
		}
		
		void setQuantity (int qtty) 
    	{
			if (qtty > 0)
				quantity = qtty;
			else
				quantity = 0;
		}
		
		void setPrice (int prc) 
    	{
			if (prc > 0)
				price = prc;
			else
				price = 0;
		}
		
		string getNumber () 
    	{
			return number;
		}
		
		string getPartDescription () 
    	{
			return partDescription;
		}
		
		int getQuantity () 
   	 	{
			return quantity;
		}
		
		int getPrice () 
	    {
			return price;
		}
		
		int getInvoiceAmount() 
	   	{
			return quantity * price;
		}
		
	private:
		string number;
		string partDescription;
		int quantity;
		int price;
};

int main() 
{
	return 0;
}
