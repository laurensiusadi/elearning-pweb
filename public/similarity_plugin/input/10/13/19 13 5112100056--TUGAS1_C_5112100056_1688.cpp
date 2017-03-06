#include <cstdio>
#include <cstdlib>
#include <iostream>
using namespace std;
 
class Invoice {
public:
	Invoice()
	{
		
	}
	
	Invoice(string partNum, string partDescrip, int q, int price)
	{
		setPartNumber(partNum);
		setPartDescription(partDescrip);
		setQuantity(q);
		setPricePerItem(price);
	}
	
	void setPartNumber(string partNum)
	{
		partNumber = partNum;
	}
	
	string getPartNumber()
	{
		return partNumber;
	}
	
	void setPartDescription(string partDescrip)
	{
		partDescription = partDescrip;
	}
	
	string getPartDescription()
	{
		return partDescription;
	}
	
	void setQuantity(int q)
	{
		if (q >= 0)
		{
			quantity = q;
		}
		
		if (q < 0)
		{
			quantity = 0;
		}
	}
	
	int getQuantity()
	{
		return quantity;
	}
	
	void setPricePerItem(int price)
	{
		if (price >= 0)
		{
			pricePerItem = price;
		}
		
		if (price < 0)
		{
			pricePerItem = 0;
		}
	}
	
	int getPricePerItem()
	{
		return pricePerItem;
	}
	
	int getInvoiceAmount()
	{
		return getQuantity() * getPricePerItem();
	}
	
private:
  string partNumber;
  string partDescription;
  int quantity;
  int pricePerItem;
};

int main()
{

}
