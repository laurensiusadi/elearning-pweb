#include<cstdio>
#include<cstdlib>
#include<iostream>
using namespace std;

class Invoice
{
	public:
	Invoice(string initPartNumber, string initPartDescription, int initQuantity, int initPrice)
	{
  		setPartNumber(initPartNumber);
 		setPartDescription(initPartDescription);
   		// quantity positif
  		if(initQuantity>=0)
  		{
    		setQuantity(initQuantity);
     	}
  		// quantity negatif
  		if(initQuantity<0)
  		{
    		quantity=0;
    		cout<<"Number can not be negative!"<<endl;
  		}
   		// price positif
   		if(initPrice>=0)
    	{
      		setPrice(initPrice);
    	}
    	// price negatif
   		if(initPrice<0)
    	{
      		price=0;
      		cout<<"Price can not be negative!"<<endl;
  		}
	}
	
	//fungsi untuk set PartNumber
	void setPartNumber(string initPartNumber)
	{
  		partNumber=initPartNumber;
	}
	
	//fungsi untuk mendapatkan nilai partNumber
	string getPartNumber()
	{
  		return partNumber;
	}	
	
	//fungsi untuk set description
	void setPartDescription(string initPartDescription)
	{
  		partDescription=initPartDescription;
	}
	
	//fungsi untuk mendapatkan description
	string getPartDescription()
	{
  		return partDescription;
	}
	
	//fungsi untuk set quantity
	void setQuantity(int initQuantity)
	{
  		quantity=initQuantity;
	}
	
	//fungsi untuk mendapatkan nilai quantity
	int getQuantity()
	{
  		return quantity;
	}
 
	//fungsi untuk set price
	void setPrice(int initPrice)
	{
  		price=initPrice;
	}
 
	//fungsi mendapatkan nilai price
	int getPrice()
	{
  		return price;
	}
 
	//fungsi untuk mendapatkan invoiceAmount
	int getInvoiceAmount(int iQuantity, int iPrice)
	{
  		if((iQuantity<0)||(iPrice<0))
  		{
    		cout << "Incorrect arguments!" << endl;
   		}
  		else
  		{
     		invoiceAmount=iQuantity*iPrice;
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

 

 

 

 

 

