/*
 *  basefunc.cpp
 *  Untitled
 *
 *  Created by user on 8/1/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "basefunc.h"
#include <math.h>

int my_round(double in_x)
{
	if (in_x < 0)
		return (int)(in_x - 0.5);
	else
		return (int)(in_x + 0.5);
}



void RGBToHSV(unsigned char r, unsigned char g, unsigned char b, int& h, int& s, int& v)
{
	int maxvalue, minvalue,deltavalue;
	maxvalue = MAX(r,MAX(g,b));
	minvalue = MIN(r,MIN(g,b));
	deltavalue = maxvalue - minvalue;
	
	v = ((float)maxvalue /255)*100;
	
	float _s, _h;
	
	if (maxvalue!=0)
	{
		_s = (float)deltavalue / maxvalue;
	}
	else
	{
		_s = 0;
	}
	
	if (_s ==0)
	{
		_h = 0;
	}
	else
	{
		if(r == maxvalue)
		{
			_h = (float)(g - b)/deltavalue;
		}
		else if(g == maxvalue)
		{
			_h = 2 + (float)(b - r)/deltavalue;
		}
		else if(b == maxvalue)
		{
			_h= 4 + (float)(r - g)/deltavalue;
		}
		h = _h * 60; 
		if (h<0)
		{
			h += 360;
		}
		
	}
	s = _s * 100;
}

void HSVToRGB(int h, int s, int v, unsigned char& r, unsigned char& g, unsigned char& b)
{
	int i;
	float aa,bb,cc, f;
	float _r, _g, _b;
	float _h, _s, _v;
	_h = (float)h / 360;
	_s = (float)s / 100;
	_v = (float)v / 100;
	
	if (_h < 0)
	{
		_h = 0;
	}
	if (_h > 1.0f)
	{
		_h = 1.0f;
	}
	if (_s < 0)
	{
		_s = 0;
	}
	if (_s > 1.0f)
	{
		_s = 1.0f;
	}
	if (_v < 0)
	{
		_v = 0;
	}
	if (_v > 1.0f)
	{
		_v = 1.0f;
	}
	
	
	if (_s == 0.0f)/*GrayScale*/
	{
		_r = _g = _b = _v;
	}
	else
	{
		if (_h == 1.0f)
		{
			_h = 0.0f;
		}
		_h *= 6.0f;
		
		i = floorf(_h);
		f = _h - i;
		aa = _v * (1 - _s);
		bb = _v * (1 - (_s * f));
		cc = _v * (1 - (_s *(1 - f)));
		switch (i)
		{
			case 0:
				_r = _v;
				_g = cc;
				_b = aa;
				break;
			case 1:
				_r = bb;
				_g = _v;
				_b = aa;
				break;
			case 2:
				_r = aa;
				_g = _v;
				_b = cc;
				break;
			case 3:
				_r = aa;
				_g = bb;
				_b = _v;
				break;
			case 4:
				_r = cc;
				_g = aa;
				_b = _v;
				break;
			case 5:
				_r = _v;
				_g = aa;
				_b = bb;
				break;
				
		}
	}
	r = (unsigned char)(_r * 255);
	g = (unsigned char)(_g * 255);
	b = (unsigned char)(_b * 255);
	
	return;
} 

void GetEigenValue(float  a, float b, float c, float& ramda1, float& ramda2, float& rAngle)
{
	float rTempRamda1, rTempRamda2;
	rTempRamda1 = (a + c + sqrt(Sqr(a - c) + Sqr(b) * 4)) / 2;
	rTempRamda2 = (a + c - sqrt(Sqr(a - c) + Sqr(b) * 4)) / 2;
	
	ramda1 = MAX(rTempRamda1, rTempRamda2);
	ramda2 = MIN(rTempRamda1, rTempRamda2);
	
	if (b == 0)
	{
		rAngle = 0;
	}
	else
	{
		rAngle = atan((ramda1 - a) / b);
	}

	
	return;
}

float GetValue(float n1, float n2, float hue)
{
	float v;
	
	if ( hue > 360 )
		hue = hue - 360;
	if ( hue < 0 )
		hue = hue + 360;
	if ( hue < 60)
		v = n1 + (n2 - n1) * hue / 60;
	else if( hue < 180 ) 
		v = n2;
	else if( hue < 240)
		v = n1 + (n2 - n1) * (240 - hue) / 60;
	else
		v = n1;
	
	return v;
}

void HSLtoRGB(int _h, int _s, int _l, BYTE& _r, BYTE& _g, BYTE& _b)
{
	float h = (float)_h;
	
	if (_s >= 100)
	{
		_s = 99;
	}
	if (_s < 0)
	{
		_s = 0;
	}
	if (h >= 360)
	{
		h = 359;
	}
	if (h < 0)
	{
		h = 0;
	}
	if (_l >= 100)
	{
		_l = 99;
	}
	if (_l < 0)
	{
		_l = 0;
	}
	
	float s = (float)_s / 100;
	float l = (float)_l / 100;
	
	float r, g, b;
	float m1, m2;
	
	if(l <= 0.5)
		m2 = l * (1 + s);
	else
		m2 = l + s - l * s;
	
	m1 = 2 * l - m2;
	
	if(s == 0)
	{
		if(h == 0)
		{
			r = g = b = l;
		}
		else
		{
			return;
		}
	}
	else
	{
		r = GetValue(m1, m2, h + 120);
		g = GetValue(m1, m2, h);
		b = GetValue(m1, m2, h - 120);
	}
	
	_r = (BYTE)(r * 255);
	_g = (BYTE)(g * 255);
	_b = (BYTE)(b * 255);
	
}

void RGBtoHSL(BYTE _r, BYTE _g, BYTE _b, int& _h, int& _s, int& _l)
{
	float r = (float)_r / 255;
	float g = (float)_g / 255;
	float b = (float)_b / 255;
	
	float h;
	float s;
	float l;
	
	float m, n;
	
	m = MAX(MAX(r, g), b);
	n = MIN(MIN(r, g), b);
	
	l = (m + n) / 2;
	if (m==n)
	{
		s = 0;
		h = 0;
	}
	else
	{
		if(l <= 0.5) s = (m - n) / (m + n);
		else s = (m - n)/(2 - m - n);
		float delta = m - n;
		if(r == m) h = (g - b) / delta;
		else if(g == m)
			h = 2 + (b - r) / delta;
		else if(b == m)
			h = 4 + (r - g) / delta;
		h = h * 60;
		if(h < 0.0)
			h = h + 360;
		
	}
	_h = (int)h;
	_s = (int)(s * 100);
	_l = (int)(l * 100);
	
}