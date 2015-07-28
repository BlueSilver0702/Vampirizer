//
//  FaceFat.mm
//  PhotoPicker
//
//  Created by KCU on 11/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#include "SImage.h"

//#include "BodyThinned.h"

//using namespace CVLib;
//
//static CVLib::BodyThinned* mpEngine = NULL;
//static struct point mpt;
//
//static CVLib::CoImage* SImage2CoImage(SImage* pImg)
//{
//	CVLib::CoImage* pCoImage = new CVLib::CoImage (pImg->nHeight, pImg->nWidth, MAT_Tbyte, CVLib::CoImage::enCOLOR_MODE);
//	memcpy(pCoImage->m_matX.data.ptr[0], pImg->ppbR[0], pImg->nWidth * pImg->nHeight);
//	memcpy(pCoImage->m_matY.data.ptr[0], pImg->ppbG[0], pImg->nWidth * pImg->nHeight);
//	memcpy(pCoImage->m_matZ.data.ptr[0], pImg->ppbB[0], pImg->nWidth * pImg->nHeight);
//	return pCoImage;
//}
//
//static SImage* CoImage2SImage(CVLib::CoImage* pImg)
//{
//	SImage* pImage = NewImage (pImg->m_matX.Cols(), pImg->m_matX.Rows());
//	memcpy(pImage->ppbR[0], pImg->m_matX.data.ptr[0], pImage->nWidth * pImage->nHeight);
//	memcpy(pImage->ppbG[0], pImg->m_matY.data.ptr[0], pImage->nWidth * pImage->nHeight);
//	memcpy(pImage->ppbB[0], pImg->m_matZ.data.ptr[0], pImage->nWidth * pImage->nHeight);
//	return pImage;
//}
//
//int			FATCreateBodyFatted(const char* szDataPath)
//{
//	CVLib::InitMemManager();
//	mpt.x = 0;
//	mpt.y = 0;
//	mpEngine = new CVLib::BodyThinned;
//	return mpEngine->Create (szDataPath);
//}
//
//void		FATReleaseBodyFatted()
//{
//	if (mpEngine)
//	{
//		mpEngine->Release();
//		delete mpEngine;
//		mpEngine = NULL;
//	}
//	CVLib::ReleaseMemManager();
//}
//
//void		FATSetPoint (int nType, struct point pt)
//{
//	if (!mpEngine)
//		return;
//	SPoint spt;
//	spt.x = pt.x;
//	spt.y = pt.y;
//	mpEngine->SetPoint(nType, spt);
//}
//
//struct point		FATGetFeatPoint(int nType)
//{
//	if (!mpEngine)
//		return mpt;
//	
//	SPoint spt=mpEngine->GetFeatPt(nType);
//	struct point pt;
//	pt.x = spt.x;
//	pt.y = spt.y;
//	return pt;
//}
//
//
//bool	FATExtractBody(struct SImage* pImage)
//{
//	if (!mpEngine)
//		return false;
//	CVLib::CoImage* img = SImage2CoImage(pImage);
//	bool fRet = mpEngine->ExtractBody(img);
//	delete img;
//	return fRet;
//}
//
//bool		FATMakeFatted ()
//{
//	if (!mpEngine)
//		return false;
//	
//	bool fRet;
//	fRet = mpEngine->MakeFaceThinned();
//	fRet = mpEngine->MakeBodyThinned();
//	return fRet;
//}
//
//struct SImage* FATGetFattedBody()
//{
//	if(!mpEngine)
//		return 0;
//	const CoImage* pFatted = mpEngine->GetThinnedBody();
//	return CoImage2SImage((CoImage*)pFatted);
//}
//
//struct SImage* FATGetBody()
//{
//	if (!mpEngine)
//		return 0;
//	const CoImage* pFace = mpEngine->GetBody();
//	return CoImage2SImage((CoImage*)pFace);
//
//}
//
//
//struct SImage*	FATGetFatted()
//{
//	if (!mpEngine)
//		return 0;
//	const CoImage* pFatted = mpEngine->GetThinnedFace();
//	return CoImage2SImage((CoImage*)pFatted);
//}
//
//struct SImage*	FATGetFace()
//{
//	if (!mpEngine)
//		return 0;
//	const CoImage* pFace = mpEngine->GetFace();
//	return CoImage2SImage((CoImage*)pFace);
//}

struct SImage*		NewImage(int nW, int nH)
{
	int i;
	struct SImage* pImg = new struct SImage;
	pImg->nWidth = nW;
	pImg->nHeight = nH;
	pImg->ppbR = new unsigned char*[nH];
	pImg->ppbR[0] = new unsigned char[nH*nW];
	pImg->ppbG = new unsigned char*[nH];
	pImg->ppbG[0] = new unsigned char[nH*nW];
	pImg->ppbB = new unsigned char*[nH];
	pImg->ppbB[0] = new unsigned char[nH*nW];
	pImg->ppbGr = new unsigned char*[nH];
	pImg->ppbGr[0] = new unsigned char[nH*nW];

	for (i = 1; i < nH; i ++)
	{
		pImg->ppbR[i] = &pImg->ppbR[0][nW * i];
		pImg->ppbG[i] = &pImg->ppbG[0][nW * i];
		pImg->ppbB[i] = &pImg->ppbB[0][nW * i];
		pImg->ppbGr[i]= &pImg->ppbGr[0][nW * i];

	}
	return pImg;
}

void		DeleteImage(struct SImage* pImage)
{
	delete pImage->ppbR[0];
	delete pImage->ppbR;
	delete pImage->ppbG[0];
	delete pImage->ppbG;
	delete pImage->ppbB[0];
	delete pImage->ppbB;
	delete pImage->ppbGr[0];
	delete pImage->ppbGr;
	delete pImage;
}

struct SImage*		NewImage(struct SImage* pImage, bool fCopy)
{
	int nW = pImage->nWidth;
	int nH = pImage->nHeight;
	struct SImage *retImage = NewImage(nW, nH);
	if (fCopy && pImage)
	{
		int i,j;
		for (i = 0; i < nH; i++)
		{
			for (j = 0; j < nW; j++)
			{
				retImage->ppbR[i][j] = pImage->ppbR[i][j];
				retImage->ppbG[i][j] = pImage->ppbG[i][j];
				retImage->ppbB[i][j] = pImage->ppbB[i][j];
				retImage->ppbGr[i][j] = pImage->ppbGr[i][j];
			}
		}
	}
	return retImage;
}

void	GrayImage(struct SImage* pImage)
{
	int nW = pImage->nWidth;
	int nH = pImage->nHeight;
	int i,j;

	for (i = 0; i < nH; i++)
	{
		for (j = 0; j < nW; j++)
		{
			pImage->ppbGr[i][j] = (pImage->ppbR[i][j] * 299 + pImage->ppbR[i][j] * 587 + pImage->ppbR[i][j] * 114) / 1000;
		}
	}
	return;
	
}
bool	IsInterior(struct SImage* pImage, int nX, int nY)
{
	int m_nCols, m_nRows;
	m_nCols = pImage->nWidth;
	m_nRows = pImage->nHeight;
	return (nX < m_nCols && nX >= 0 && nY < m_nRows && nY >= 0);
}



CGContextRef
createARGBBitmapContextFromImage(UIImage* inImage)
{
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	size_t pixelsWide, pixelsHigh;
	
	// Get image width, height. We'll use the entire image.
	
	pixelsWide = inImage.size.width;
	pixelsHigh = inImage.size.height;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL) 
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits 
	// per component. Regardless of what the source image format is 
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}

UIImage* SImage2UIImage(struct SImage* pImage)
{
	int nWidth = pImage->nWidth;
	int nHeight = pImage->nHeight;
	char *resultBuffer = (char*) malloc(nHeight * nWidth * 4);
	int iW =0, iH =0, offset = 0;
	
	for(iH =0; iH < nHeight; iH++)
	{
		for(iW =0; iW < nWidth; iW++)
		{
			resultBuffer[offset] = 255;
			resultBuffer[offset+1] = pImage->ppbR[iH][iW]; 
			resultBuffer[offset+2] = pImage->ppbG[iH][iW];
 			resultBuffer[offset+3] = pImage->ppbB[iH][iW];
			offset += 4;
		}
	}
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(resultBuffer, 
											 nWidth , 
											 nHeight , 
											 8, 
											 nWidth*4, 
											 colorSpace, 
											 kCGImageAlphaPremultipliedFirst ); 
	
	CGImageRef imageRef = CGBitmapContextCreateImage (ctx); 
	UIImage* rawImage = [[UIImage alloc] initWithCGImage:imageRef]; 
	CGColorSpaceRelease( colorSpace );
	CGImageRelease(imageRef);
	CGContextRelease(ctx);
	free(resultBuffer);
	return rawImage;
}

SImage* UIImage2SImage(UIImage* Image)
{
	int iW =0, iH =0;
	float xVar, yVar;
	UIImageOrientation imageOrientation = Image.imageOrientation;
	
	CGImageRef inImage = Image.CGImage;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = createARGBBitmapContextFromImage(Image);
	if (cgctx == NULL) { return NULL; /* error */ }
	
    size_t w = CGBitmapContextGetWidth(cgctx);
	size_t h = CGBitmapContextGetHeight(cgctx);
	
	SImage* pSImage = NewImage (w, h);
	
	CGRect rect;  
	
	switch (imageOrientation) {
		case UIImageOrientationDown:
		case UIImageOrientationDownMirrored:
			xVar = w / 2 * cos(M_PI) - h / 2 * sin(M_PI) - w / 2;
			yVar = w / 2 * sin(M_PI) + h / 2 * cos(M_PI) - h / 2;
			CGContextTranslateCTM(cgctx, -xVar, -yVar);
			CGContextRotateCTM(cgctx, M_PI);
			rect = CGRectMake(0, 0, w, h);
			break;
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
			xVar = h / 2 * cos(M_PI/2) - w / 2 * sin(M_PI/2) - w / 2;
			yVar = h / 2 * sin(M_PI/2) + w / 2 * cos(M_PI/2) - h/ 2;
			CGContextTranslateCTM(cgctx, -xVar, -yVar);
			CGContextRotateCTM(cgctx, M_PI / 2);
			rect = CGRectMake(0, 0, h, w);
			break;
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			xVar = h / 2 * cos(-M_PI/2) - w / 2 * sin(-M_PI/2) - w / 2;
			yVar = h / 2 * sin(-M_PI/2) + w / 2 * cos(-M_PI/2) - h / 2;
			CGContextTranslateCTM(cgctx, -xVar, -yVar);
			CGContextRotateCTM(cgctx, -M_PI / 2);
			rect = CGRectMake(0, 0, h, w);
			break;
		case UIImageOrientationUp:
		case UIImageOrientationUpMirrored:
			rect = CGRectMake(0, 0, w, h);
			break;
		default:
			break;
	}
	
	// Draw the image to the bitmap context. Once we draw, the memory 
	// allocated for the context for rendering will then contain the 
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage); 
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = (unsigned char *)CGBitmapContextGetData (cgctx);
	if (data != NULL)
	{
		//offset locates the pixel in the data from x,y. 
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset =0;
		for(iH =0; iH < h; iH++)
		{
			for(iW =0; iW < w; iW++)
			{
				pSImage->ppbR[iH][iW] = data[offset+1];
				pSImage->ppbG[iH][iW] = data[offset+2];
				pSImage->ppbB[iH][iW] = data[offset+3];
				offset += 4;
			}
		}
	}
	
	// When finished, release the context
	CGContextRelease(cgctx); 
	// Free image data memory for the context
	if (data) { free(data); }
	return pSImage;
}

UIImage* ScaleUIImage(UIImage* pSrcImage ,float rScale)
{
	CGColorSpaceRef colorSpace;
	
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	int nSrcImageWidth, nSrcImageHeight;
	int nDesImageWidth, nDesImageHeight;
	
	nSrcImageWidth = [pSrcImage size].width;
	nSrcImageHeight = [pSrcImage size].height;
	nDesImageWidth = nSrcImageWidth * rScale;
	nDesImageHeight = nSrcImageHeight * rScale;
	
	bitmapBytesPerRow   = (nDesImageWidth * 4);
	bitmapByteCount   = (bitmapBytesPerRow * nDesImageHeight);
	
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
		return NULL;
	
	CGContextRef context = CGBitmapContextCreate (NULL,
												  nDesImageWidth,
												  nDesImageHeight,
												  8,      
												  bitmapBytesPerRow,
												  colorSpace,
												  kCGImageAlphaPremultipliedLast);
	
	
	CGContextDrawImage(context, CGRectMake(0, 0, nDesImageWidth, nDesImageHeight), [pSrcImage CGImage]);
	
	CGImageRef ref = CGBitmapContextCreateImage(context);
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(ref);
	CGContextRelease(context);
	return newImage;
}

