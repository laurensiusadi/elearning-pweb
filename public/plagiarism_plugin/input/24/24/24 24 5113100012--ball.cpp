#include <wx/wx.h>
#include "ball.h"

ball::ball(float x, float y)
{
	this->x = x;
	this->y = y;
	radius = 20;
	speedX = 10;
	speedY = 10;
}

void ball::HitWall(int x1, int y1, int x2, int y2)
{
	if ((y - radius) < y1 || (y + radius) > y2)
	{
		speedY = -speedY;
	}
	if ((x - radius) < x1 || (x + radius) > x2)
	{
		speedX = -speedX;
	}
}

void ball::Collides(ball *otherBall)
{
	int xd = x - otherBall->x;
	int yd = y - otherBall->y;

	float sumRadius = radius + otherBall->radius;
	float sqrRadius = sumRadius = sumRadius*sumRadius;

	float distSqr = (xd*xd) + (yd*yd);

	if (distSqr <= sqrRadius)
	{
		speedX *= -1;
		speedY *= -1;
	}
}

void ball::move()
{
	x = x + speedX;
	y = y + speedY;
}
