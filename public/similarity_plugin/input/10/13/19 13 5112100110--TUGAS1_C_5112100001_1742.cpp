/*
 * Nama : Karsten Ari Agathon
 * NRP 	: 5112100110
 * Kelas: PBO C
 * Tugas PBO 1
 */
#include <iostream>
using namespace std;
class Invoice{
public:
	Invoice(string number, string description, int quantity, int price){
		setPartNumber(number);
		setPartDescription(description);
		setItemQuantity(quantity);
		setItemPrice(price);
	}
	void setPartNumber(string number){
		partNumber=number;
	}
	void setPartDescription(string description){
		partDescription=description;
	}
	void setItemQuantity(int quantity){
		if(quantity>=0) itemQuantity=quantity;
		else itemQuantity=0;
	}
	void  setItemPrice(int price){
		if(price>=0) itemPrice=price;
		else itemPrice=0;
	}
	string getPartNumber(){
		return partNumber;
	}
	string getPartDescription(){
		return partDescription;
	}
	int getItemQuantity(){
		return itemQuantity;
	}
	int getItemPrice(){
		return itemPrice;
	}
	int getInvoiceAmount(){
		return itemQuantity*itemPrice;
	}
private:
	string partNumber;
	string partDescription;
	int itemQuantity;
	int itemPrice;
};
int main(){
	
	return 0;
}
