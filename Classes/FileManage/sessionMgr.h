//
//  sessionMgr.h
//  ColorSplash
//
//  Created by Developer on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session:NSObject
{
	UIImage* mResultImg;
	UIImage* mThumbnailImg;
	
}

@property (nonatomic, retain) UIImage* mResultImg;
@property (nonatomic, assign) 	UIImage* mThumbnailImg;

-(void)write:(NSString*)path index:(int)index;
-(UIImage *)readImage:(NSString*)path index:(int) index;
-(UIImage *)readThumnail:(NSString*)path index:(int) index;


+(BOOL)exist:(NSString*)path index:(int) index;//if index == 0, it is last session
+(BOOL)kill:(NSString*)path index:(int) index;
-(void) free;
-(void)saveResultImage:(NSString*)path;
-(UIImage *)loadResultImage:(NSString*)path index:(int) index;
-(UIImage *)loadThumbnailImage:(NSString*)path index:(int) index;

-(bool)deleteResultImage:(NSString*)path index:(int) index;
-(int)getResultNum:(NSString*)path;

//- (UIImage *)roundedImage:(UIImage*)originalImage;
//- (void) loadWhole:(NSString*)path;

+ (NSString*) GetMyFileName:(NSString*) path index:(int)index prefix:(NSString*) prefix;
@end