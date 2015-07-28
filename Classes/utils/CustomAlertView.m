//
//  CustomAlertView.m
//  Vampirizer
//
//  Created by Gold Luo on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView * mesView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 160, 275, 161)];
        [mesView setImage:[UIImage imageNamed:@"custom_alert_back"]];
        [self addSubview:mesView];
        [mesView release];

        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 160 + 5, 260, 30)];
        lbTitle.textColor = [UIColor whiteColor];
        [lbTitle setFont:[UIFont systemFontOfSize:35.0f]];
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.textAlignment = UITextAlignmentCenter;
        lbTitle.tag = 2000;
        [self addSubview:lbTitle];

        UILabel *lbText = [[UILabel alloc] initWithFrame:CGRectMake(30, 160 + 40, 260, 60)];
        lbText.textColor = [UIColor whiteColor];
        [lbText setFont:[UIFont systemFontOfSize:20.0f]];
        lbText.backgroundColor = [UIColor clearColor];
        lbText.textAlignment = UITextAlignmentCenter;
        lbText.tag = 2001;
        [self addSubview:lbText];

        UIButton *btnYes = [[UIButton alloc] initWithFrame:CGRectMake(124, 275, 72, 30)];
        [btnYes setBackgroundImage:[UIImage imageNamed:@"yes_01"] forState:UIControlStateNormal];
        [btnYes setBackgroundImage:[UIImage imageNamed:@"yes_02"] forState:UIControlStateHighlighted];
        btnYes.tag = 2001;
        
        [btnYes addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnYes];
        [btnYes release];
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

- (void) btnClicked:(UIButton*)button {
//    int tag = button.tag;
    
    [self removeFromSuperview];
}

- (void) setTitleText:(NSString*) strTitle :(NSString*) strText{
    UILabel * labelTitle = (UILabel*)[self viewWithTag:2000];
    labelTitle.text = strTitle;

    UILabel * labelText = (UILabel*)[self viewWithTag:2001];
    labelText.text = strText;
}

@end
