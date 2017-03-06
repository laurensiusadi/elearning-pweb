/*
	author: akbar anugerah syahdamar 5112100138
	program: invoice class (struk pembayar)
*/
#include<iostream>
#include<string>
using namespace std;

class Invoice
{
	private:
		string partNumber;
		string partDescription;
		int quantity;	//quntity of the item being purchased
		int price; //price per item
	public:
		Invoice(string pn, string pd, int q, int p) //constructor
		{
				setPartNumber(pn);
				setPartDescription(pd);
				setQuantity(q);
				setPrice(p);
		}
		
		void setQuantity(int q)
		{
			if(q < 0)
				{
					quantity = 0; //quantity di set 0 jika bernilai negatif
				}
			else
				{
					quantity = q;
				};
		}
		
		int getQuantity()
		{
			return quantity;	//memberikan nilai quantity
		}
			
		void setPrice(int p)
		{	
			if(p < 0)
				{
					price = 0;	//price di set 0 jika bernilai negatif
				}
			else
				{
					price = p;
				};
		}
		
		int getPrice()
		{
			return price;	//memberikan nilai price
		}
		
		void setPartNumber(string pn)
		{
			partNumber = pn;
		}
		
		string getPartNumber()
		{
			return partNumber;
		}
		
		void setPartDescription(string pd)
		{
			partDescription = pd;
		}
		
		string getPartDescription()
		{
			return partDescription;
		}
		
		int getInvoiceAmount()
		{
			return (quantity*price);	//memberikan nilai total yang harus dibayarkan
		}
		
};

int main()
{
	return 0;
}
