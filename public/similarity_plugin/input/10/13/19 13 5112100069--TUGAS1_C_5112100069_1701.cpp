/*
 * invoiceStoreClass.cpp

 *
 *  Created on: 19 Sep 2013
 *      Author: Moh Iqbal Tanjung
 */

#include<iostream>
#include<string>
using namespace std;

class Invoices
{
private:
	int productQuantity;
	int productPrice;
	string productTag;
	string productDescription;

public:
	Invoices(int quantity, int price, string tag, string descrip)
	{
		setProductQuantity (quantity);
		setProductPrice (price);
		setProductTag (tag);
		setProductDescription (descrip);
	}

	void setProductQuantity (int quantity)
	{
		if(quantity >= 0)
		{
			productQuantity = quantity;
		}
		else productQuantity = 0;
	}

	int getProductQuantity ()
	{
		return productQuantity;
	}

	void setProductPrice (int price)
	{
		if (price >= 0)
		{
			productPrice = price;
		}
		else productPrice = 0;
	}

	int getProductPrice ()
	{
		return productPrice;
	}

	void setProductTag (string tag)
	{
		productTag = tag;
	}

	string getProductTag()
	{
		return productTag;
	}

	void setProductDescription(string descrip)
	{
		productDescription = descrip;
	}

	string getProductDescription()
	{
		return productDescription;
	}

	int getInvoiceAmount()
	{
		int amount;
		amount = productQuantity * productPrice;
		return amount;
	}

};
int main()
{

}
