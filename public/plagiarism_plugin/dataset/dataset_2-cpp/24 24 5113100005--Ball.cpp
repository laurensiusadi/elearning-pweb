#include "wx/wx.h"
#include<Ball.h>

void Ball::Collides(Ball *otherBall)
{
	int xd = x-otherBall-> x;
	int yd = y-otherBall-> y;

	float sumRadius = radius + otherball->radius;
	float sqrRadius = sumRadius * sumRadius;

	float distSqr = (xd*xd) + (yd*yd);
	
	if(distSqr <= sqrRadius)
	{
		speedX *= -1;
		speedY *= -1;
	}
}

void Ball::Render(wxDC *dc)
{
	speedY = speedY + 0.5*t;

	x = x + speedX;
	y = y + speedY;

	dc->DrawCircle(x, y, radius);
	
	t += 0,01lf;
}

void Ball::WallHitTest(int xl, int yl, int x2, int y2)
{
	if((y-radius) < y1 || (y+radius) > y2)
		speedY = -speedY;

	if((x-radius) < x1 || (x+radius) > 2)
		speedX = -speedX;
}
