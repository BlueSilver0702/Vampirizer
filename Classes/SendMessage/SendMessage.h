//
//  SendMessage.h
//  FatBooth
//
//  Created by user on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

enum MessageWindowMode
{
	MessageFaceBook,
	MessageTwitter,
};

@class MyClanManager;

@interface SendMessage : UIViewController <FBSessionDelegate, FBRequestDelegate, UITextViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>
{
	UIImageView* m_pPhoto;
	UITextView* m_pMessageText;
	UITextField*  m_LeftCharacterNum;

	NSString *m_pUserName;
	NSString *m_pPassWord;
	
    NSString *m_pHiddenMsg;
	int m_Mode;


	MyClanManager* controller;
	
    int     m_nLeftCharacterNum;
    int m_nHiddenLen;
    UIAlertView *alertMain;  
    UIActivityIndicatorView *ActivityIndicator;
    
}

@property(nonatomic, retain) 	NSString *m_pUserName;
@property(nonatomic, retain)	NSString *m_pPassWord;
@property(nonatomic, retain)    UITextView* m_pMessageText;
@property(nonatomic, assign)	int m_Mode;
@property(nonatomic, assign)	MyClanManager* controller;


-(IBAction)onCancel:(id)sender;
-(IBAction)onSend:(id)sender;
-(void)AddAlertWindow;
-(void) UploadToTwitter;

@end
