//
//  UIImage+Resize.h
//  PhotoAlbum0.0.1
//
//  Created by Kim SongIl on 5/26/10.
//  Copyright 2010 CCC. All rights reserved.
//

// Helper methods for adding an alpha layer to an image
@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
@end