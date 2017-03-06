#ifndef BALL_H
#define BALL_H

class Ball
{
private:
	int x;
	int y;
	int size;
	int tempx;
	int tempy;
public:
	Ball(int, int, int);
	~Ball();
	void setX(int);
	int getX();
	void setY(int);
	int getY();
	void setSize(int);
	int getSize();
	void moveBall();
};

#endif