#include<iostream>
#include<string>

using namespace std;

class Invoice
{
	public:
		Invoice ()
		{	
		}
		
		Invoice (string partNum, string partDes, int qty, int prc)
		{
			partNumber = partNum;
			partDescription = partDes;
			if (qty < 0) {
				qty = 0;
			}
			quantity = qty;
			
			if (prc < 0) {
				prc = 0;
			}
			price = prc;
		}
		
		void setPartNumber (string partNum)
		{
			partNumber = partNum;
		}
		
		void setPartDescription (string partDes)
		{
			partDescription = partDes;
		}
		
		void setQuantity (int qty)
		{
			if (qty < 0) {
				qty = 0;
			}
			quantity = qty;
		}
		
		void setPrice (int prc)
		{
			if (prc < 0) {
				prc = 0;
			}
			price = prc;
		}
		
		string getPartNumber() {
			return partNumber;
		}
		
		string getPartDescription() {
			return partDescription;
		}
		
		int getQuantity() {
			return quantity;
		}
		
		int getPrice() {
			return price;
		}
		
		int getInvoiceAmount() {
			return quantity*price;
		}
		
	private:
		string partNumber, partDescription;
		int quantity, price;
};

int main()
{
	
	return 0;	
}
