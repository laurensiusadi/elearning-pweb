#include "Ball.h"
#include "wx/wx.h"

Ball::Ball(void)
{
}


Ball::~Ball(void)
{
}

void Ball::Collides(Ball *otherBall)
{
	int xd = x - otherBall->x;
	int yd = y - otherBall->y;

	float sumRadius = radius + otherBall->radius;
	float sqrRadius = sumRadius * sumRadius;

	float sidtSqr = (xd * xd) + (yd * yd);

	if (distSqr <= sqrRadius)
	{
		speedX *= -1;
		speedY *= -1;
	}

}

void Ball::Render(wxDC *dr)
{
	dc->SetPen(*wxWHITE_PEN);
	dc->SetBrush(*this->brush);

	//speedY = speedY + 0,5 * t;

	x = x + speedX;
	y = y + speedY;

	dc->DrawCircle(x, y, radius);

	t += 0.01f;
}

void Ball::WallHitTest(int x1, int y1, int x2, int y2)
{
	if ((y-radius) < y1 || (y+radius) > y2)
	{
		speedY = -speedY;
	}

	if ((x-radius) < x1 || (x+radius) > x2)
	{
		speedX = -speedX;
	}
}