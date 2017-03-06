#include <iostream>
#include <string>
using namespace std;

class Invoice {
	private :
		string partNumber;
		string partDesc;
		int quantity;
		int price;
	
	public :
		Invoice ();
		Invoice(string prtNm,int qnty, string prtDs, int prc) {
			setPartNumber (prtNm);
			setQuantity (qnty);
			setPartDesc (prtDs);
			setPrice (prc);
		}
		
		void setPartNumber (string prtNm) {
			partNumber = prtNm;
		}
		
		void setQuantity (int qnty) {
			quantity = qnty;
			if(quantity < 0) 
				quantity = 0;
		}
		
		void setPartDesc (string prtDs){
			partDesc = prtDs;
		}
		
		void setPrice (int prc){
			price = prc;
			if(price < 0) 
				price = 0;
		}
		
		string getPartNumber () {
			return partNumber;
		}
		
		int getQuantity () {
			return quantity;
		}
		
		string getPartDesc () {
			return partDesc;
		}
		
		int getPrice () {
			return price;
		}
		
		int getInvoiceAmount () {
			return price * quantity;
		}
		
				
};

int main (){
	
}
