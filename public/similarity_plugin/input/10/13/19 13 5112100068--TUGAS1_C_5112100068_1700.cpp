#include <iostream>
#include <string>
using namespace std;

class Invoice {
	
public:
    Invoice (string num, string des, int qua, int pri) {
        number = num;
        partDescription = des;
        
        if (qua > 0)
            quantity = qua;
        else
            quantity = 0;
        
        if (pri > 0)
            price = pri;
        else
            price = 0;
    }
    
    void setNumber (string num) {
        number = num;
    }
    
    void setPartDescription (string des) {
        partDescription = des;
    }
    
    void setQuantity (int qua) {
        if (qua > 0)
            quantity = qua;
        else
            quantity = 0;
    }
    
    void setPrice (int pri) {
        if (pri > 0)
            price = pri;
        else
            price = 0;
    }
    
    string getNumber () {
        return number;
    }
    
    string getPartDescription () {
        return partDescription;
    }
    
    int getQuantity () {
        return quantity;
    }
    
    int getPrice () {
        return price;
    }
    
    int getInvoiceAmount() {
        return quantity * price;
    }
    
private:
    string number;
    string partDescription;
    int quantity;
    int price;
};

int main() {
	return 0;
}
