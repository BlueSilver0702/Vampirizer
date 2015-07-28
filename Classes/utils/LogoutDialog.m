//
//  LogoutDialog.m
//  Vampirizer
//
//  Created by Gold Luo on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogoutDialog.h"

@implementation LogoutDialog

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView * mesView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 160, 275, 161)];
        [mesView setImage:[UIImage imageNamed:@"logout_back"]];
        [self addSubview:mesView];
        [mesView release];
        
        UIButton *btnYes = [[UIButton alloc] initWithFrame:CGRectMake(65, 275, 72, 30)];
        [btnYes setBackgroundImage:[UIImage imageNamed:@"yes_01"] forState:UIControlStateNormal];
        [btnYes setBackgroundImage:[UIImage imageNamed:@"yes_02"] forState:UIControlStateHighlighted];
        btnYes.tag = 1001;
        
        [btnYes addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnYes];
        [btnYes release];

        UIButton *btnNo = [[UIButton alloc] initWithFrame:CGRectMake(183, 275, 72, 30)];
        [btnNo setBackgroundImage:[UIImage imageNamed:@"no_01"] forState:UIControlStateNormal];
        [btnNo setBackgroundImage:[UIImage imageNamed:@"no_02"] forState:UIControlStateHighlighted];
        btnNo.tag = 1002;
        
        [btnNo addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnNo];
        [btnNo release];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setMode: (int) index{
    mode = index;
}

- (void) btnClicked:(UIButton*)button {
    int tag = button.tag;
    
    if (tag == 1001) { //YES;
       [delegate closeLogoutDialog:mode];
    }
    
    [self removeFromSuperview];
    
}

@end
