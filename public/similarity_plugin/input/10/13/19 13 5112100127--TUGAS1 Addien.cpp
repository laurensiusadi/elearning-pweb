#include<iostream>
#include<string>

using namespace std;

class Invoice
{
public :
	   Invoice(string pNumber, string pDes, int iQua, int iPrice)
	   {
	   		partNumber = pNumber;
	   		partDescription = pDes;
	   		setItemQua(iQua);
	   		setItemPrice(iPrice);
	   }
       void displayMessage()
	   {
		    cout << "Welcome to the Invoice\n";
	   }
	   
       void setPartNumber(string pNumber) 
       {
            partNumber = pNumber;
	   }
	   string getPartNumber() 
	   {
            return partNumber;
       }
       
       void setPartDescription(string pDes)
       {
            partDescription = pDes;
	   }
	   string getPartDescription()
	   {
            return partDescription;
       }
       
       void setItemQua(int iQua)
       {
            if(iQua < 0) iQua = 0;
            itemQua = iQua;
	   }
	   int getItemQua() 
	   {
            return itemQua;
       }
       
       void setItemPrice(int iPrice)
       {
            if(iPrice < 0) iPrice = 0;
            itemPrice = iPrice;
	   }
	   int getItemPrice() 
	   {
            return itemPrice;
       }
       
       void PriceTotal()
       {
            totalPrice = itemQua * itemPrice;
       }
       int getPriceTotal()
	   {
            return totalPrice;
       }
       
private :
	string partNumber, partDescription;
	int itemQua, itemPrice, totalPrice;
};

int main()
{
	return 0;
}
