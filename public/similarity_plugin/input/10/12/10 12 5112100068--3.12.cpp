#include <iostream>
using namespace std;

class Account {
    
public:
    Account (int bal) {
        if (bal >= 0)
            setBalance(bal);
        else {
            setBalance(0);
            cout << "Initial value cannot be less than 0" << endl;
        }
    }
    
    void credit(int bal) {
        balance += bal;
    }
    
    void debit(int bal) {
        if (bal > balance)
            cout << "Debit amount exceeded account balance" << endl;
        else
            balance -= bal;
    }
    
    int getBalance() {
        return balance;
    }
    
    void setBalance(int bal) {
        balance = bal;
    }
    
private:
    int balance;
};

int main() {
    
    return 0;
}
