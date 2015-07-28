//
//  VampirizerAppDelegate.h
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartViewController.h"

#import "selectPhotoViewController.h"
#import "SelectFromCameraAndAlbum.h"
#import "MyClanManager.h"
#import "FBConnect.h"
#import "ShareSetting.h"
#import "Twitter.h"



@interface VampirizerAppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate, FBRequestDelegate, TwitterDelegate>
{
    UIWindow *window;
	IBOutlet StartViewController* m_pStartViewController;
	IBOutlet UINavigationController* m_pMainNavigationController;
	
	
#pragma mark Processing Image
	
	UIImage* m_pOrgImage;
	UIImage* m_pProcessedImage;
	
	
#pragma mark ImageCaptured
	
	bool m_fCapturedFromCamera;

#pragma mark ViewController
	
	selectPhotoViewController* m_pSelectPhotoController;
	SelectFromCameraAndAlbum* m_pSelectFromCameraAndAlbum;
	MyClanManager* m_pMyClanManager;
	ShareSetting* m_pShareSetting;
	
	UIImageView* m_pLogo;
	
	
#pragma mark Centers
	CGRect m_pFaceTaggingRect[4];
	float m_rScale;
	
	float m_rMouthWidth, m_rMouthHeight;
	float m_rMouthAngle;
	
	
#pragma mark Facebook
	Facebook*   facebook;
	NSArray*    _permissions;
	
	BOOL m_fFromUpLoad;
	
#pragma mark Twitter
	
	NSString*   m_szTwitUserName;
    NSString*   m_szTwitPass;
	Twitter* m_pTwitterEngine;
	BOOL m_fTwitterSigned;
	
	
    NSTimer* timer;
    float maxValue;
    float curValue;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) IBOutlet StartViewController* m_pStartViewController;
@property (nonatomic, retain ) UIImage* m_pOrgImage;
@property (nonatomic, retain) UIImage* m_pProcessedImage;
@property (nonatomic, assign) bool m_fCapturedFromCamera;
@property (nonatomic, assign) selectPhotoViewController* m_pSelectPhotoController;
@property (nonatomic, assign) SelectFromCameraAndAlbum* m_pSelectFromCameraAndAlbum;
@property (nonatomic, assign) ShareSetting* m_pShareSetting;
@property (nonatomic, assign) MyClanManager* m_pMyClanManager;
@property (nonatomic, assign) BOOL m_fFromUpLoad;
@property (nonatomic, assign) Facebook*   facebook;

@property (nonatomic, retain) NSString*   m_szTwitUserName;
@property (nonatomic, retain) NSString*   m_szTwitPass;

@property (nonatomic, assign) BOOL m_fTwitterSigned;

@property (nonatomic, assign) float m_rMouthWidth;
@property (nonatomic, assign) float m_rMouthHeight;
@property (nonatomic, assign) float m_rMouthAngle;

@property (nonatomic, assign)	Twitter* m_pTwitterEngine;

-(UIImage *)CropImage:(UIImage*) pSourceImage x:(int) nX y:(int) nY width:(int) nWidth height:(int) nHeight;
-(void) ProcessView:(UIImageView*) bloodView rect:(CGRect) backgroudRect percent:(float) rPercent;
-(CGRect) GetViewRect:(CGRect) backgroudRect;
-(void) removeLogo;


-(void) SetFaceTaggingRect:(int) nIndex rect:(CGRect) rect;
-(CGRect) GetFaceTaggingRect:(int) nIndex;

-(void) SetScale:(float) rScale;
-(float) GetScale;
-(void) ShowSetting;

-(void) TwitterLogIn;
-(void) TwitterLogOut;
-(void) UploadPhotoToTwitter:(NSString*)szMessage;
-(void) ConnectTwitter;

#pragma mark FaceBook
- (void)    FacebookLogin;
- (void)    FacebookLogOut;
- (void)    UploadPhotoToFacebook:(NSString*)szMessage;
//- (void)    ShowSenMessageView;


@end

