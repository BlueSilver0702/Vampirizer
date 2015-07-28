//
//  MyClanManager.h
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "LoadingBar.h"
enum
{
	Processed_Mode,
	Clan_Mode,
};

@interface MyClanManager : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
	int m_nManageIndex;
	UIImageView* m_pImageView;
	
	UIImageView* m_pDarkBack;
	UIImageView* m_pPopBox;
	UIImageView* m_pPopLabel;
	
	
	UIButton* m_pFire;
	UIButton* m_pFireBack;
	
	int m_nMode;
	
	UIImageView* pTopView;
	UIImageView* pTipView;
	UIButton* pBtnBack;
	UIButton* pBtnDelete;
	
	UIButton* pBtnSaveToAlbum;
	UIButton* pBtnHome;
	UIButton* pBtnShare;
	

	UIImageView* pOhNo;
	UIImageView* pLastOneThing;
	
	UIButton* pBtnSetting;
	UIButton* pBtnLastOneThingBack;
	UIButton* pBtnOhNoBack;
	
	UIImageView* pSharingNow;
	UIImageView* pSharingComplete;
	
	UIImageView* pBloodFrame;
	UIImageView* pBloodView;
	LoadingBar* pLoadingBar;

	
}

@property(nonatomic, assign) int m_nManageIndex;
@property(nonatomic, assign)	int m_nMode;

-(void) Init;
-(void)onDelete:(id)sender;
-(void)onBack:(id)sender;
-(void)onShare:(id)sender;
-(void)DeleteControllsShow:(BOOL) fShow;
-(void) onFire:(id)sender;
-(void) onFireBack:(id)sender;
-(void) onSaveToAlbum:(id)sender;
-(void) onHome:(id)sender;


#pragma mark Email
- (void)showPicker;
- (void)displayComposerSheet;
- (void)launchMailAppOnDevice;


#pragma mark Sharing Process
-(void) BloodProcessing:(float) rPercent;
-(void) HideSharing;
-(void) SharingComplete;

#pragma mark SendMessage
-(void) SendMessage:(int) nMode;

-(void) Return;

-(void) ShowLastOneThink:(bool) fShow;
-(void) ShowOhNo:(bool) fShow;

-(void) onOneLastThingBack:(id)sender;
-(void) onOhNoBack:(id)sender;
-(void) onSetting:(id)sender;

-(void) HideLoading;
-(void) StartLoding;
-(void) CompleteLoading;

-(void) StopLoading;

-(void) animationView:(UIView*)view initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime;
-(void) animationDelete:(bool) fShow;

@end
