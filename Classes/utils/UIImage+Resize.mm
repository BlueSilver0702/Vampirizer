//
//  UIImage+Resize.h
//  PhotoAlbum0.0.1
//
//  Created by Kim SongIl on 5/26/10.
//  Copyright 2010 CCC. All rights reserved.
//

#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

// Private helper methods
@interface UIImage ()
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end

@implementation UIImage (Resize)

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
	
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)thumbImageWithSize:(CGSize)_size
                    interpolationQuality:(CGInterpolationQuality)quality {
    return [self resizedImage:_size interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
            default:
            break;
    }
    
    return transform;
}

////////////////////////////////////////

/**
 * Create ARGB Bitmap context from CGImageRef.
 * @ param  inImage  [in]   image 
 * @ return  ARGB bitmap context
 */
- (CGContextRef)
createARGBBitmapContextFromImage
{
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	size_t pixelsWide, pixelsHigh;
	
	// Get image width, height. We'll use the entire image.
	
	pixelsWide = self.size.width;
	pixelsHigh = self.size.height;
	
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
									 kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}

- (unsigned char*) getImageBuffer
{
	int iW =0, iH =0;
	float xVar, yVar;
	
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self createARGBBitmapContextFromImage];
	if (cgctx == NULL) { return NULL; /* error */ }
	
    size_t w = CGBitmapContextGetWidth(cgctx);
	size_t h = CGBitmapContextGetHeight(cgctx);
	CGRect rect;
	switch (self.imageOrientation) {
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
			xVar = h / 2 * cos(M_PI_2) - w / 2 * sin(M_PI_2) - w / 2;
			yVar = h / 2 * sin(M_PI_2) + w / 2 * cos(M_PI_2) - h/ 2;
			CGContextTranslateCTM(cgctx, -xVar, -yVar);
			CGContextRotateCTM(cgctx, M_PI_2);
			rect = CGRectMake(0, 0, h, w);
			break;
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			xVar = h / 2 * cos(-M_PI_2) - w / 2 * sin(-M_PI_2) - w / 2;
			yVar = h / 2 * sin(-M_PI_2) + w / 2 * cos(-M_PI_2) - h / 2;
			CGContextTranslateCTM(cgctx, -xVar, -yVar);
			CGContextRotateCTM(cgctx, -M_PI_2);
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
	CGContextDrawImage(cgctx, rect, self.CGImage); 
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	int nByteWidth = w * 3;
	unsigned char* data = (unsigned char*)CGBitmapContextGetData (cgctx);
	unsigned char* retData = (unsigned char*)malloc(h * nByteWidth);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y. 
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int nPos =0;
		int offset =0;
		for(iH =0; iH < h; iH++)
		{
			for(iW =0; iW < w; iW++)
			{
				int red = data[offset+1]; 
				int green = data[offset+2]; 
				int blue = data[offset+3];
				nPos = iH * nByteWidth + iW * 3;
				//nPos = (h -1 - iH) * nByteWidth + iW * 3;
				retData[nPos] = blue;
				retData[nPos + 1] = green;
				retData[nPos + 2] = red;
				offset += 4;
			}
		}
	}
	
	// When finished, release the context
	CGContextRelease(cgctx); 
	// Free image data memory for the context
	if (data) { free(data); }
	return retData;
}

@end