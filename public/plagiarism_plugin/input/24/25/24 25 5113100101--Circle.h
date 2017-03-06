#pragma once
#include <cmath>
#include <cstdlib>
class Circle
{
public:
	int posX;
	int posY;
	int size;
	int vX;
	int vY;
	int R, G, B;

	Circle(int X,int Y);
	~Circle();

	void ballMove();
	void wallHit();
	void ballHit(Circle *Other);
};

