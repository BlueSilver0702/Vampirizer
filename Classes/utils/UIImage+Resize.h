//
//  UIImage+Resize.h
//  PhotoAlbum0.0.1
//
//  Created by Kim SongIl on 5/26/10.
//  Copyright 2010 CCC. All rights reserved.
//

#import <UIKit/UIKit.h>

// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)thumbImageWithSize:(CGSize)_size interpolationQuality:(CGInterpolationQuality)quality;

/////////////////
- (unsigned char*) getImageBuffer;

@end