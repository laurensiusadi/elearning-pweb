#include"Bola.h"

Bola::Bola(int xi, int yi){
	this->x = xi;
	this->y = yi;
	radius = 10;
	velocityX = 10;
	velocityY = 0;
	acc = 9.8;
	dt = 0.1;
	MassBall = 50.0;
	MassEarth = 5000.0;
}

//Bola::~Bola(){}

void Bola::update_vel_pos(){
	velocityY = velocityY + acc*dt;
	x = x + (velocityX*dt);
	y = y + (velocityY*dt) + 0.5*acc*(dt*dt);
}
void Bola::tabrak(){
	if (y > 430)
		velocityY = (fabs(velocityY)*(MassBall - MassEarth)) / (MassBall + MassEarth);
	if (x > 690)
		velocityX = (fabs(velocityX)*(MassBall - MassEarth)) / (MassBall + MassEarth);
	if (x < 10)
		velocityX = -(fabs(velocityX)*(MassBall - MassEarth)) / (MassBall + MassEarth);
	if (y < 10)
		velocityY = -(fabs(velocityY)*(MassBall - MassEarth)) / (MassBall + MassEarth);
	if (y>480) {
		x = 0;
		y = 0;
		velocityX = -10;
		velocityY = 0;
	}
}

void Bola::collision(Bola *otherbola){
	float xd = x - otherbola->x;
	float yd = y - otherbola->y;

	float sumRadius = radius + otherbola->radius;
	float sqrRadius = sumRadius * sumRadius;

	float distSqr = (xd*xd) + (yd*yd);

	if (distSqr <= sqrRadius){
		velocityX *= -1;
		velocityY *= -1;
	}
}