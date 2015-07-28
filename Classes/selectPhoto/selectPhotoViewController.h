//
//  selectPhotoViewController.h
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFromCameraAndAlbum.h"
#import "helpViewController.h"
#import "MyClan.h"
#import "ShareSetting.h"
#import "TwitterLogin.h"

@interface selectPhotoViewController : UIViewController 
{
	UIButton* m_pCamera;
	UIButton* m_pAlbum;
	
	IBOutlet SelectFromCameraAndAlbum* m_pSelectFromCameraAndAlbum;
	
	IBOutlet helpViewController* m_pHelpViewController;
	
	IBOutlet MyClan* m_pMyClan;
	IBOutlet ShareSetting* m_pShareSetting;
	
	IBOutlet TwitterLogin* m_pTwitterLogIn;
	
	
}

-(void) onCameraOrAlbum:(id)sender;

-(void) onMyClan:(id)sender;
-(void) onSetting:(id)sender;
-(void) onHelp:(id)sender;
-(void) TwitterLogIn;



@end
