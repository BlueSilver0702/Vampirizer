//
//  TwitterLogin.h
//  FatBooth
//
//  Created by user on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class selectPhotoViewController;

@interface TwitterLogin : UIViewController <UITableViewDataSource>
{
	UITextField* m_pUserName;
	UITextField* m_pPassword;
	
	selectPhotoViewController* controller;
	
	IBOutlet UITableView *m_pTabelView;
    BOOL m_fSelectedRemember;
}
@property(nonatomic, assign)selectPhotoViewController* controller;
-(IBAction)actionSwitch:(id)sender;
-(IBAction)onSignIn:(id)sender;
-(void)actionCancel:(id)sender;

@end
