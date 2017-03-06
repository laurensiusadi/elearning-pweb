#include<cstdio>
#include<iostream>
#include<algorithm>
#include<string>
using namespace std;

class invoice
{
private:
   	string Number,Describe;
	int Quantity,Price,Amount;
public:
	invoice(){
	}

	void setinvoice(string num, string des, int quan, int price){
		Number = num;
		Describe = des;
		if(quan<0){
			Quantity = 0;
		}
		else Quantity = quan;
		if(price<0){
			Price = 0;
		}
		else Price = price;
	}
	void getinvoice(){
		cout << "Number		: " << Number << endl;
		cout << "Description	: " << Describe << endl;
        cout << "Quantity	: " << Quantity << endl;
        cout << "Price		: " << Price << endl;
	}
	int getInvoiceAmount(){
		Amount = Quantity*Price;
		return Amount;
	}
};

int main()
{
	return 0;
}
