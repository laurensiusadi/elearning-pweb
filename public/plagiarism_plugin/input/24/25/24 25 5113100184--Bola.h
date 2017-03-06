#include<cmath>

class Bola{
public:
	double radius;
	double x;
	double y;
	double velocityX = 10;
	double velocityY = 0;
	double acc = 9.8;
	double dt = 0.1;
	double MassBall = 50.0;
	double MassEarth = 5000.0;

	Bola(int x, int y);
	//~Bola();

	void update_vel_pos();
	void tabrak();
	void collision(Bola *otherbola);
};

