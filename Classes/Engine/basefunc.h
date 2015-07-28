/*
 *  basefunc.h
 *  Untitled
 *
 *  Created by user on 8/1/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */



#ifndef _BASEFUNC_H_
#define _BASEFUNC_H_

struct CCRect
{
	int nMinX;
	int nMinY;
	int nMaxX;
	int nMaxY;
};

struct SRect
{
	int x;			
	int y;			
	int width;		
	int height;		
};

void GetEigenValue(float  a, float b, float c, float& ramda1, float& ramda2, float& rAngle);

#ifndef Sqr
#define	Sqr(x)	((x)*(x))
#endif

#ifndef MIN
#define MIN(a,b)  ((a) > (b) ? (b) : (a))
#endif

#ifndef MAX
#define MAX(a,b)  ((a) < (b) ? (b) : (a))
#endif

#ifndef ABS
#define ABS(a)  ((a) > 0 ? (a) : (-a))
#endif

typedef unsigned char	BYTE;

void HSVToRGB(int h, int s, int v, unsigned char& r, unsigned char& g, unsigned char& b);
void RGBToHSV(unsigned char r, unsigned char g, unsigned char b, int& h, int& s, int& v);

void HSLtoRGB(int _h, int _s, int _l, BYTE& _r, BYTE& _g, BYTE& _b);
void RGBtoHSL(BYTE _r, BYTE _g, BYTE _b, int& _h, int& _s, int& _l);

#endif
