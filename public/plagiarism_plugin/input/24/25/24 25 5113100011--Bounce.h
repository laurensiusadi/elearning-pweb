#include <wx/wx.h>

class Bounce{
public:
	float radius;
	float x;
	float y;
	float speedX;
	float speedY;
	Bounce(float x, float y);

	void HitWall(int x1, int y1, int x2, int y2);
	void Collides(Bounce *otherBall);
	void move();
};
