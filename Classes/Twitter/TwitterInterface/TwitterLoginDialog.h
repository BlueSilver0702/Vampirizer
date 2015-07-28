//
//  TwitterLoginDialog.h
//  Vampirizer
//
//  Created by user on 11/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TwitterLoginDialogDelegate;

/**
 * Do not use this interface directly, instead, use dialog in Facebook.h
 *
 * Facebook dialog interface for start the facebook webView UIServer Dialog.
 */

@interface TwitterLoginDialog : UIView
{
	id<TwitterLoginDialogDelegate> delegate;

	UIImageView* m_pMainBack;
	UIView* m_pMaskView;
	
	UIButton* _closeButton;
	UIButton *m_pCancel;
	UIButton *m_pConnect;
	
	UITextField* m_pUserName;
	UITextField* m_pPassword;
	
    UIView* m_pBackView;
    
	UIActivityIndicatorView *ActivityIndicator;
}


/**
 * The delegate.
 */
@property(nonatomic,assign) id<TwitterLoginDialogDelegate> delegate;

- (void)show;
- (id)init;
- (void)cancel:(id)sender;
- (void)onConnect:(id)sender;
- (void)dismiss:(BOOL)animated;
- (void)bounce1AnimationStopped;
- (void)bounce2AnimationStopped;
- (CGAffineTransform)transformForOrientation;

- (void)addObservers;
- (void)removeObservers;

-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime;
-(void) stopAnimation;


@end

///////////////////////////////////////////////////////////////////////////////////////////////////

/*
 *Your application should implement this delegate
 */
@protocol TwitterLoginDialogDelegate <NSObject>


@optional
-(void) SetUserName:(NSString *) szUserName Password:(NSString* ) szPassword;


@end

