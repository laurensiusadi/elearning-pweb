#include "Ball.h"

using namespace std;

Ball::Ball(int x, int y, int size)
{
	this->setX(x);
	this->setY(y);
	this->setSize(size);
	this->tempx = 0;
	this->tempy = 1;
}

Ball::~Ball()
{

}

void Ball::setX(int x)
{
	this->x = x;
}

int Ball::getX()
{
	return this->x;
}

void Ball::setY(int y)
{
	this->y = y;
}

int Ball::getY()
{
	return this->y;
}

void Ball::setSize(int size)
{
	this->size = size;
}

int Ball::getSize()
{
	return this->size;
}

void Ball::moveBall()
{
	int x, y, size;

	x = this->getX();
	y = this->getY();
	size = this->getSize();

	if (x + size >= 625) this->tempx = 1;
	else if (x - size <= 0) this->tempx = 0;

	if (y + size >= 455) this->tempy = 1;
	else if (y - size <= 0) this->tempy = 0;

	if (this->tempx == 0) x += 4;
	else x -= 4;
	if (this->tempy == 0) y += 4;
	else y -= 4;

	this->setX(x);
	this->setY(y);
}