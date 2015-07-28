//
//  UIImage+Resize.h
//  PhotoAlbum0.0.1
//
//  Created by Kim SongIl on 5/26/10.
//  Copyright 2010 CCC. All rights reserved.
//

// Extends the UIImage class to support making rounded corners
@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end