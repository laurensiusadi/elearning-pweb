#pragma once
#include <math.h>
#include <stdlib.h>
class Circle
{
public:
	int posX;
	int posY;
	int size;
	int speedX;
	int speedY;
	int R, G, B;

	Circle(int X,int Y);
	~Circle();

	void ballMove();
	void wallHit();
	void ballHit(Circle *Other);
};

