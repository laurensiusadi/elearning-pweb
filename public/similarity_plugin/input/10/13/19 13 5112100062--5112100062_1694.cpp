#include<iostream>
#include<string>

using namespace std;

class Invoices {
	
	public:
		Invoices(){
			
		}
		void setPartNumber(string name) {
			partNumber = name;
		}
		string getPartNumber() {
			return partNumber;
		}
		void setPartDescription(string name) {
			partDescription = name;
		}
		string getPartDesription() {
			return partDescription;
		}
		void setQuantityItemPurchased(int val) {
			if(val < 0)
				quantityItemPurchased = 0;
			else
				quantityItemPurchased = val;
		}
		int getQuantityItemPurchased() {
			return quantityItemPurchased;
		}
		void setPrice(double val) {
			if(val < 0)
				price = 0.0;
			else
				price = val;
		}
		double getPrice() {
			return price;
		}
		double getInvoiceAmount() {
			return price*(double)quantityItemPurchased;
		}

	private:
		string partNumber;
		string partDescription;
		int quantityItemPurchased;
		double price;
};

int main(){

	
	return 0;	
}
