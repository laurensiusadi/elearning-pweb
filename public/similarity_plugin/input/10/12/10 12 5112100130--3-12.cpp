//==========================||
//  Maulina Nur Istiqomah   ||
//  5112100130              ||
//  PBO - C                 ||
//==========================||

#include <iostream>

using namespace std;

class Bank
{
    public:
        void setBalance(int money)
        {
            if(money>=0) balance = money;
            else
            {
                cout << "Initial balance was invalid.\n";
                balance = 0;
            }
        }
        int getBalance()
        {
            return balance;
        }
        void credit(int money)
        {
            balance = balance + money;
        }
        void debit(int money)
        {
            if(balance>=money) balance = balance - money;
            else cout << "Debit amount exceeded account balance.\n";
        }
    private:
        int balance;
};

int main()
{
}
