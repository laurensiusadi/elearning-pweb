/*
*Imaduddin Al Fikri
*5112100092
*PBO C
*invoice class
*/
#include<iostream>
#include<string>

using namespace std;

class InVoice
{
public:
	//part number & part description
	InVoice(string pn, string pd)
	{
		setPart(pn,pd);
	}
	void setPart(string pn, string pd)
	{
		partNum = pn;
		partDes = pd;
	}
	string getPartNum()
	{
		return partNum;
	}
	string getPartDes()
	{
		return partDes;
	}
	//item quantity & price
	InVoice(int iq, int ip)
	{
		setItem(iq,ip);
	}
	void setItem(int iq, int ip)
	{
		itemQuantity = iq;
		itemPrice = ip;
	}
	int getItemQuantity()
	{
		return itemQuantity;
	}
	int getItemPrice()
	{
		if(itemPrice>0)
			return itemPrice;
		else
			return 0;
	}
	//get invoiceamount
	int getInvoiceAmount()
	{
		InvoiceAmount = itemQuantity*itemPrice;
		if(InvoiceAmount>0)
			return InvoiceAmount;
		else
			return 0;
	}
private:
	string partNum, partDes;
	int itemQuantity, itemPrice, InvoiceAmount;
};

int main()
{
	
	return 0;
}
