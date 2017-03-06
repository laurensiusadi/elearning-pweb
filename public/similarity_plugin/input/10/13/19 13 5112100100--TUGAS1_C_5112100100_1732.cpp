#include <iostream>
#include <string>
using namespace std;
class Invoice
{
	private :
		string partNumber,partDescription;
		int quantityOfItem,pricePerItem;
	public :
		Invoice()
		{}
		Invoice(string pN,string pD,int qO,int pP)
		{
			setValuePartNumber(pN);
			setValuePartDescription(pD);
			setValueQuantityOfItem(qO);
			setValuePricePerItem(pP);
		}
		void setValuePartNumber(string pN)
		{
			partNumber=pN;
		}
		void setValuePartDescription(string pD)
		{
			partDescription=pD;
		}
		void setValueQuantityOfItem(int qO)
		{
			if(qO>=0)
				quantityOfItem=qO;
			else
				quantityOfItem=0;
		}
		void setValuePricePerItem(int pP)
		{
			if(pP>=0)
				pricePerItem=pP;
			else
				pricePerItem=0;
		}
		string getValuePartNumber()
		{
			return partNumber;
		}
		string getValuePartDescription()
		{
			return partDescription;
		}
		int getValueQuantityOfItem()
		{
			return quantityOfItem;
		}
		int getValuePricePerItem()
		{
			return pricePerItem;
		}
		int getInvoiceAmount()
		{
			return pricePerItem*quantityOfItem;
		}
};
int main()
{
	return 0;
}
