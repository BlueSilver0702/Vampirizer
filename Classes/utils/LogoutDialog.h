//
//  LogoutDialog.h
//  Vampirizer
//
//  Created by Gold Luo on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoutDialog;
@protocol LogoutDialogDelegate <NSObject>
- (void) closeLogoutDialog:(int) mode;
@end


@interface LogoutDialog : UIView 
{
    id<LogoutDialogDelegate> delegate;
    
    int mode;
}

@property (nonatomic, retain) id<LogoutDialogDelegate> delegate;

- (void) setMode:(int) index;

@end
