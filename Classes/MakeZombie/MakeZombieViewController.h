//
//  MakeZombieViewController.h
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClanManager.h"

@interface MakeZombieViewController : UIViewController <UIActionSheetDelegate> 
{
	UIImageView* m_pImageView;
	UIImageView* m_pShakeMeView;

	UIButton* m_pTheme;
	UIButton* m_pSave;
	
	IBOutlet MyClanManager* m_pMyClanManager;
	
	UIImage* pTempOriginal;
	UIImage* pTempResult;
	
	int m_nEyeKind;
	int m_nMouthKind;
	
}

-(void) MakeZombie;
-(void) Init;
-(void) onShake:(id)sender;
-(void) onShakeClick:(id)sender;
-(void) onTheme:(id)sender;
-(void) onSave:(id)sender;
-(void) ShakeImageDisappear;
-(void) animationView:(UIView*)view initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime;
-(void) onBack:(id)sender;


@end
