//
//  ShareDialog.m
//  
//
//  Created by Xi Wang on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShareDialog.h"
#import <QuartzCore/QuartzCore.h>



@implementation ShareDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];

//        UIImageView * backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)]; 
//        [backView setImage:[UIImage imageNamed:@"darkened-screen"]];
//        [self addSubview:backView];
//        [backView release];
        
        UIImageView * mesView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 160, 275, 161)];
        [mesView setImage:[UIImage imageNamed:@"dlg_back"]];
        [self addSubview:mesView];
        [mesView release];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(124, 275, 72, 30)];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"but-back-up"] forState:UIControlStateNormal];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"but-back-click"] forState:UIControlStateHighlighted];

//        btnOK.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | 
//        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin |
//        UIViewAutoresizingFlexibleBottomMargin;
        [btnOK addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnOK];
        [btnOK release];

        self.exclusiveTouch = YES;
        
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    }
    return self;
}


- (void) show:(UIView*)parent {

    if (parent == [self superview]) {
        return;
    }
    
	[self removeFromSuperview];
    
	[parent addSubview:self];
	[parent bringSubviewToFront:self];
    
//    btnOK.hidden = YES;


	self.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView beginAnimations:@"scale" context:NULL];
	self.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	if ([animationID isEqualToString:@"scale"]) {
		
		[UIView beginAnimations:nil context:NULL];
		self.transform = CGAffineTransformMakeScale(1.0, 1.0);
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.2];
		[UIView commitAnimations];
		
		return;
	}
}

- (void)setMode:(int)_mode {

    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
//    UIImage* bgImage = [UIImage imageNamed:@"dlg_back"];
//    
//    [bgImage drawInRect:CGRectMake((320 - bgImage.size.width)/ 2, (440 - bgImage.size.height) / 2, bgImage.size.width, bgImage.size.height)];
}

- (void) btnClicked:(UIButton*)button {

    [self removeFromSuperview];
    
}

@end
