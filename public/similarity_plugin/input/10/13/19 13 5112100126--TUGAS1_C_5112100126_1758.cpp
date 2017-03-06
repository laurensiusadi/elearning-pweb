#include<iostream>
#include<string>
using namespace std;

class Invoice
{
	//variable
	string partNum, description;
	int quantity, price;
	public:
		// set a constructor
		Invoice(){}
		Invoice(string a, string b, int c, int d)
		{
			partNum = a; // bisa juga memakai setPartNum(a); dan di setter, void diganti dengan tipe data (string)
			description = b; // setDescription(b);
			if(c < 0) // setQuantity(c);
			{
				quantity = 0;
			}
			else quantity = c;
			if(d < 0) // setPrice(d);
			{
				price = 0;
			}
			else price = d;
		}
		
		// setter
		void setPartNum(string a)
		{
			partNum = a;
		}
		void setDescription(string b)
		{
			description = b;
		}
		void setQuantity(int c)
		{
			if(c < 0)
			{
				quantity = 0;
			}
			else quantity = c;
		}
		void setPrice(int d)
		{
			if(d < 0)
			{
				price = 0;
			}
			else price = d;
		}
		
		//getter
		string getPartNum()
		{
			return partNum;
		}
		string getDescription()
		{
			return description;
		}
		int getQuantity()
		{
			return quantity;
		}
		int getPrice()
		{
			return price;
		}
		int getInvoiceAmount()
		{
			return quantity * price;
		}
};

int main()
{

}
