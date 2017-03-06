#include "wx/wx.h"
#include "Bounces.h"

Bounces::Bounces(void)
{
	// TODO Auto-generated constructor stub
}

Bounces::~Bounces(void)
{
	// TODO Auto-generated destructor stub
}

void Bounces::Render (wxDc *dc){
	dc->SetPen(*wxWHITE_PEN);
	dc->Setbrush(*this->brush);
	
	//speedY = speedY + 0.5 * t;

	x = x + speedX;
	y = y + speedY;
	
	dc = DrawCircle(x, y, radius);
	
	t += 0.01f;
}

void Bounces::HitWallTest(int x1, int y1, int x2, int y2)
{
	if ((y-radius) < y1 || (y + radius) > y2)
	{
		speedY = -speedY;
	}
	if((x - radius) < x1 || (x + radius) > x2)
	{
		speedX = -speedX;
	}
}

void Bounces::Collides(Ball *otherBall)
{
	int xd = x - otherBall -> x;
	int yd = y - otherBall -> y;

	float sumRadius = radius + otherBall->radius;
	float sqrRadius = sumRadius = sumRadius*sumRadius;

	float distSqr = (xd*xd) + (yd*yd);

	if (distSqr <= sqrRadius)
	{
		speedX *= -1;
		speedY *= -1;
	}
}
