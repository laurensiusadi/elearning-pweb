#include <iostream>
#include <string>

using namespace std;

class Invoice
{
public:
	Invoice()
	{
		
	}
	
	Invoice(string num, string des, int qu, int pr)
	{
		setNumber(num);
		setDescription(des);
		setQuantity(qu);
		setPrice(pr);
	}
	
	void setNumber(string num)
	{
		number=num;
	}
	
	void setDescription(string des)
	{
		description=des;
	}
	
	void setQuantity(int qu)
	{
		if (qu >= 0)
			quantity = qu;
		else
			quantity = 0;
	}
	
	void setPrice(int pr)
	{
		if (pr >= 0)
			price = pr;
		else
			price = 0;
	}
	
	string getNumber()
	{
		return number;
	}
	
	string getDescription()
	{
		return description;
	}
	
	int getQuantity()
	{
		return quantity;
	}
	
	int getPrice()
	{
		return price;
	}
	
	int getInvoiceAmount()
	{
		return (quantity*price);
	}
	
private:
	string number;
	string description;
	int quantity;
	int price;
};

int main(){

}
