/*
 *  Theme.mm
 *  Vampirizer
 *
 *  Created by user on 11/19/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#import "Theme.h"
#import "SImage.h"
#import "basefunc.h"

SImage* Grayscale(SImage* pSimage)
{
	SImage *pNewImage = NewImage(pSimage, TRUE);
	int nWidth, nHeight;
	nWidth = pNewImage->nWidth;
	nHeight = pNewImage->nHeight;
	
	int i,j;
	for (i = 0; i < nWidth; i++)
	{
		for (j = 0; j < nHeight; j++)
		{
			BYTE r,g,b;
			int h,s,v;
			r = pSimage->ppbR[j][i];
			g = pSimage->ppbG[j][i];
			b = pSimage->ppbB[j][i];
			
			RGBtoHSL(r,g, b, h, s, v);
			
			s = 0;
			h = 0;
			
			HSLtoRGB(h, s, v, r, g, b);
			
			pNewImage->ppbR[j][i] = r;
			pNewImage->ppbG[j][i] = g;
			pNewImage->ppbB[j][i] = b;
			
		}
	}
	return pNewImage;
	
}

SImage* Sepia(SImage* pSimage)
{
	SImage *pNewImage = NewImage(pSimage, TRUE);
	int nWidth, nHeight;
	nWidth = pNewImage->nWidth;
	nHeight = pNewImage->nHeight;
	
	int i,j;
	for (i = 0; i < nWidth; i++)
	{
		for (j = 0; j < nHeight; j++)
		{
			BYTE r,g,b;
			int h,s,v;
			r = pSimage->ppbR[j][i];
			g = pSimage->ppbG[j][i];
			b = pSimage->ppbB[j][i];
			
			RGBtoHSL(r,g, b, h, s, v);
			
			s = 25;
			h = 50;
			
			HSLtoRGB(h, s, v, r, g, b);
			
			pNewImage->ppbR[j][i] = r;
			pNewImage->ppbG[j][i] = g;
			pNewImage->ppbB[j][i] = b;
			
		}
	}
	return pNewImage;
	
}

SImage* Tangsten(SImage* pSimage)
{
	SImage *pNewImage = NewImage(pSimage, TRUE);
	int nWidth, nHeight;
	nWidth = pNewImage->nWidth;
	nHeight = pNewImage->nHeight;
	
	int i,j;
	for (i = 0; i < nWidth; i++)
	{
		for (j = 0; j < nHeight; j++)
		{
			BYTE r,g,b;
			int h,s,v;
			r = pSimage->ppbR[j][i];
			g = pSimage->ppbG[j][i];
			b = pSimage->ppbB[j][i];
			
			RGBtoHSL(r,g, b, h, s, v);
			
			s = 25;
			h = 200;
			
			HSLtoRGB(h, s, v, r, g, b);
			
			pNewImage->ppbR[j][i] = r;
			pNewImage->ppbG[j][i] = g;
			pNewImage->ppbB[j][i] = b;
			
		}
	}
	return pNewImage;
	
}


//UIImage* Grayscale(UIImage* pInImage)
//{
//	SImage* pSInImage = UIImage2SImage(pInImage);
//	SImage* pSOutImage = Grayscale(pSInImage);
//	UIImage* pResultImage = SImage2UIImage(pSOutImage);
//	
//	DeleteImage(pSInImage);
//	DeleteImage(pSOutImage);
//	
//	return pResultImage;
//}
//UIImage* Tangsten(UIImage* pInImage)
//{
//	SImage* pSInImage = UIImage2SImage(pInImage);
//	SImage* pSOutImage = Tangsten(pSInImage);
//	UIImage* pResultImage = SImage2UIImage(pSOutImage);
//	
//	DeleteImage(pSInImage);
//	DeleteImage(pSOutImage);
//	
//	return pResultImage;
//	
//}
//UIImage* Sepia(UIImage* pInImage)
//{
//	SImage* pSInImage = UIImage2SImage(pInImage);
//	SImage* pSOutImage = Sepia(pSInImage);
//	UIImage* pResultImage = SImage2UIImage(pSOutImage);
//	
//	DeleteImage(pSInImage);
//	DeleteImage(pSOutImage);
//	
//	return pResultImage;
//}

UIImage* Grayscale(UIImage* Image)
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
				BYTE r,g,b;
				int h,s,v;
				
				r = data[offset+1];
				g = data[offset+2];
				b = data[offset+3];
				
				RGBtoHSL(r,g, b, h, s, v);
				
				s = 0;
				h = 0;
				
				HSLtoRGB(h, s, v, r, g, b);

				data[offset+1] = r;
				data[offset+2] = g;
				data[offset+3] = b;
				
				offset += 4;
				
			}
		}
	}
	
	// When finished, release the context
	CGContextRelease(cgctx); 
	
	// Free image data memory for the context
	int nWidth = w;
	int nHeight = h;

	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(data, 
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

	if (data) { free(data); }

	return rawImage;
	
	
}

UIImage* Tangsten(UIImage* Image)
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
				BYTE r,g,b;
				int h,s,v;
				
				r = data[offset+1];
				g = data[offset+2];
				b = data[offset+3];
				
				RGBtoHSL(r,g, b, h, s, v);
				
				s = 40;
				h = 210;
				
				HSLtoRGB(h, s, v, r, g, b);
				
				data[offset+1] = r;
				data[offset+2] = g;
				data[offset+3] = b;
				
				offset += 4;
				
			}
		}
	}
	
	// When finished, release the context
	CGContextRelease(cgctx); 
	
	// Free image data memory for the context
	int nWidth = w;
	int nHeight = h;
	
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(data, 
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
	
	if (data) { free(data); }
	
	return rawImage;
	
	
}

UIImage* Sepia(UIImage* Image)
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
				BYTE r,g,b;
				int h,s,v;
				
				r = data[offset+1];
				g = data[offset+2];
				b = data[offset+3];
				
				RGBtoHSL(r,g, b, h, s, v);
				
				s = 40;
				h = 40;
				
				HSLtoRGB(h, s, v, r, g, b);
				
				data[offset+1] = r;
				data[offset+2] = g;
				data[offset+3] = b;
				
				offset += 4;
				
			}
		}
	}
	
	// When finished, release the context
	CGContextRelease(cgctx); 
	
	// Free image data memory for the context
	int nWidth = w;
	int nHeight = h;
	
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(data, 
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
	
	if (data) { free(data); }
	
	return rawImage;
	
	
}


