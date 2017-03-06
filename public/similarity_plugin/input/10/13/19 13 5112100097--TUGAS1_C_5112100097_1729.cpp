#include <iostream>
#include <string>
using namespace std;

class Invoice {

	private:
		string numb;
		string Description;
		int qty;
		int price;
	
	public:
		Invoice (string num, string des, int qua, int pri) {
			numb = num;
			Description = des;
			qty = qua;
			price = pri;
		}
		
		void setNumber (string num) {
			numb = num;
		}
		
		void setDescription (string des) {
			Description = des;
		}
		
		void setQty (int qua) {
			if (qua > 0)
				qty = qua;
			else
				qty = 0;
		}
		
		void setPrice (int pri) {
			if (pri > 0)
				price = pri;
			else
				price = 0;
		}
		
		string getNumb () {
			return numb;
		}
		
		string getDescription () {
			return Description;
		}
		
		int getQty () {
			return qty;
		}
		
		int getPrice () {
			return price;
		}
		
		int getInvoiceAmount() {
			return qty * price;
		}
};

int main() {
	return 0;
}
