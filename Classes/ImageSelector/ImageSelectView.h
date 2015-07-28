//
//  ImageSelectView.h
//  WakeMe
//
//  Created by OCH-Mac on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ImageSelectDelegate;

@interface ImageSelectView : UIView 
{
	id <ImageSelectDelegate> delegate;
	NSMutableArray*		m_arrayButton;
}

@property (nonatomic, retain) id <ImageSelectDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (void) refresh;


@end

@protocol ImageSelectDelegate
-(void)ReturnImageIndex:(int) i;
@end