#include <cstdio>
#include <cstdlib>
#include <iostream>

using namespace std;
 
class Invoice {
public:
	Invoice()
	{
	}
	Invoice(string partNum, string partDes, int qty, int price)
	{
		setPartNumber(partNum);
		setPartDescription(partDes);
		setQuantity(qty);
		setPrice(price);
	}
	void setPartNumber(string partNum)
	{
		partNumber = partNum;
	}
	string getPartNumber()
	{
		return partNumber;
	}
	void setPartDescription(string partDes)
	{
		partDescription = partDes;
	}
	string getPartDescription()
	{
		return partDescription;
	}
	void setQuantity(int qty)
	{
		if (qty >= 0)
		{
			quantity = qty;
		}
		if (qty < 0)
		{
			quantity = 0;
		}
	}
	int getQuantity()
	{
		return quantity;
	}
	void setPrice(int price)
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
	int getPrice()
	{
		return pricePerItem;
	}
	int getInvoiceAmount()
	{
		return getQuantity() * getPrice();
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
