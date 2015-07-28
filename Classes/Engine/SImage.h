//
//  FaceFat.h
//  PhotoPicker
//
//  Created by KCU on 11/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#ifndef _FACEFATENGINE_H_
#define _FACEFATENGINE_H_

#include "types.h"
#import <UIKit/UIKit.h>

struct SImage
{
	int nWidth;
	int nHeight;
	unsigned char** ppbR;
	unsigned char** ppbG;
	unsigned char** ppbB;
	unsigned char** ppbGr;
};

//int			FATCreateBodyFatted(const char* szDataPath);
//void		FATReleaseBodyFatted();
//
//void		FATSetPoint (int nType, struct point pt);
//// struct point		FATGetFacial(int nType);
//// bool		FATExtractFace (struct SImage* pImage);
//bool		FATExtractBody (struct SImage* pImage);
//bool		FATMakeFatted ();
//
//struct point		FATGetFeatPoint(int nType);
//struct SImage*		FATGetFattedBody();
//struct SImage*		FATGetBody();
//
//
//struct SImage*		FATGetFace();

struct SImage*		NewImage(int nW, int nH);
void DeleteImage(struct SImage* pImage);
struct SImage*		NewImage(struct SImage* pImage, bool fCopy);
bool	IsInterior(struct SImage* pImage, int nX, int nY);
void	GrayImage(struct SImage* pImage);


SImage* UIImage2SImage(UIImage* Image);
UIImage* SImage2UIImage(struct SImage* pImage);
CGContextRef
createARGBBitmapContextFromImage(UIImage* inImage);


UIImage* ScaleUIImage(UIImage* pSrcImage, float rScale);

#endif //_FACEFATENGINE_H_


