#include <iostream>
#include <string>

using namespace std;

class Invoice
{
	public :
		Invoice (string a, string b, int c, int d)
		{
			setPartNumber(a);
			setPartDescription(b);
			setItemQuantity(c);
			setItemPrice(d);
		}
		
		void setPartNumber(string a)
		{
			number=a;
		}
		
		void setPartDescription(string b)
		{
			description=b;
		}
		
		void setItemQuantity(int c)
		{
			if(c<0)
			{
				quantity=0;
			}
			else
			{
				quantity=c;	
			}
		}
		
		void setItemPrice(int d)
		{
			if(d<0)
			{
				price=0;
			}
			else
			{
				price=d;
			}
		}
		
		string getPartNumber()
		{
			return number;
		}
		
		string PartDescription()
		{
			return description;
		}
		
		int getItemQuantity()
		{
			return quantity;
		}
		
		int getItemPrice()
		{
			return price;
		}
		
		int getInvoiceAmount(int c, int d)
		{
			return c*d;
		}
		
	private :
		//int Invoice;
		string number, description;
		int quantity, price;	
};

int main()
{

}
