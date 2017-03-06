#include <cstdio>
#include <cstdlib>
#include <iostream>

using namespace std;

class Invoice
{
public:
  Invoice(string initPartNumber, string initPartDescription, int initQuantity, int initPrice)
  {
    setPartNumber( initPartNumber );

    setPartDescription( initPartDescription );

    if (initQuantity >= 0)
    {
      setQuantity( initQuantity );
    }
    if (initQuantity < 0)
    {
      quantity = 0;
      cout << "Number can not be negative and set as 0" << endl;
    }

    if (initPrice >= 0)
    {
      setPrice( initPrice );
    }
    if (initPrice < 0)
    {
      price = 0;
      cout << "Price can not be negative and set as 0" << endl;
    }
  }

  void setPartNumber(string initPartNumber) 
  {
    partNumber = initPartNumber;
  }

  string getPartNumber()
  {
    return partNumber;
  }

  void setPartDescription (string initPartDescription) 
  {
    partDescription = initPartDescription;
  }

  string getPartDescription() 
  {
    return partDescription;
  }

  void setQuantity( int initQuantity ) 
  {
    quantity = initQuantity;
  }

  int getQuantity()
  {
    return quantity;
  }

  void setPrice( int initPrice ) 
  {
    price = initPrice;
  }

  int getPrice()
  {
    return price;
  }

  int getInvoiceAmount(int iQuantity, int iPrice)
  {
    if((iQuantity<0)||(iPrice<0))
    {
      cout << "Incorrect args!" << endl;
    }
    else
    {
     invoiceAmount = iQuantity * iPrice;
   }
   return invoiceAmount;
 }

private:
  string partNumber;
  string partDescription;
  int quantity;
  int price;
  int invoiceAmount;
};

int main()
{
	return 0;
}
