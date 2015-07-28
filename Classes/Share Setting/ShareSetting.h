//
//  ShareSetting.h
//  Vampirizer
//
//  Created by user on 11/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LogoutDialog.h"

@class selectPhotoViewController;

@interface ShareSetting : UIViewController <LogoutDialogDelegate>
{
	selectPhotoViewController* m_pPareantController;
	UIButton* m_pFaceBookSignIn;
	UIButton* m_pTwitterSignIn;
	

}
@property(nonatomic, assign) 	selectPhotoViewController* m_pPareantController;

-(void) onFaceBookSignIn:(id)sender;
-(void) onTwitterSignIn:(id)sender;
-(void) onSaveSetting:(id)sender;

-(void) SetFacebookSign:(bool) fSigned;
-(void) SetTwitterSign;
-(void) Init;


@end
