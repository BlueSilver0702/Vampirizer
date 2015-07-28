//
//  TwitterLoginDialog.m
//  Vampirizer
//
//  Created by user on 11/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterLoginDialog.h"

static CGFloat kTransitionDuration = 0.3;


@implementation TwitterLoginDialog
@synthesize delegate;

- (id)init
{
	if (self = [super initWithFrame:CGRectZero])
	{
		delegate = nil;
		self.frame = CGRectMake(10, 16, 300, 448);
		
		
		m_pMaskView = [[UIView alloc] initWithFrame:CGRectMake(10, 37, 280, 401)];
		m_pMaskView.clipsToBounds = TRUE;
		[self addSubview:m_pMaskView];
		
		m_pMainBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 401)];
		m_pMainBack.image = [UIImage imageNamed:@"TwitterLogInBackGround.png"];
		[m_pMaskView addSubview:m_pMainBack];
		

		UIImageView* pTitleView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 280, 27)];
		pTitleView.image = [UIImage imageNamed:@"TwitterLogInTitle.png"];
		[self addSubview:pTitleView];
		
		UIImageView* pBorder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 448)];
		pBorder.image = [UIImage imageNamed:@"TwitterLogInBorder.png"];
		[self addSubview:pBorder];
		
		//close Button
		UIImage* closeImage = [UIImage imageNamed:@"FBDialog.bundle/images/close.png"];
		UIColor* color = [UIColor colorWithRed:167.0/255 green:184.0/255 blue:216.0/255 alpha:1];
		_closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[_closeButton setImage:closeImage forState:UIControlStateNormal];
		[_closeButton setTitleColor:color forState:UIControlStateNormal];
		[_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[_closeButton addTarget:self action:@selector(cancel:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		// To be compatible with OS 2.x
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_2_2
		_closeButton.font = [UIFont boldSystemFontOfSize:12];
#else
		_closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
#endif
		
		_closeButton.showsTouchWhenHighlighted = YES;
		_closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
		| UIViewAutoresizingFlexibleBottomMargin;
		_closeButton.frame = CGRectMake(265, 12, 21, 21);
		[self addSubview:_closeButton];
		
		[pTitleView release];
		[pBorder release];
		
		m_pCancel = [[UIButton alloc] initWithFrame:CGRectMake(80, 390, 76, 32)];
		[m_pCancel setBackgroundImage:[UIImage imageNamed:@"but-cancel-up.png"] forState:UIControlStateNormal];
		[m_pCancel setBackgroundImage:[UIImage imageNamed:@"but-cancel-down.png"] forState:UIControlStateHighlighted];
		
		[m_pCancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_pCancel];

		m_pConnect = [[UIButton alloc] initWithFrame:CGRectMake(165, 390, 90, 32)];
		[m_pConnect setBackgroundImage:[UIImage imageNamed:@"but-connect-up.png"] forState:UIControlStateNormal];
		[m_pConnect setBackgroundImage:[UIImage imageNamed:@"but-connect-down.png"] forState:UIControlStateHighlighted];
		
		[m_pConnect addTarget:self action:@selector(onConnect:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_pConnect];
		
		m_pUserName = [[UITextField alloc] initWithFrame:CGRectMake(102, 271, 170, 30)];
		[self addSubview:m_pUserName];
		
		m_pPassword = [[UITextField alloc] initWithFrame:CGRectMake(102, 312, 170, 30)];
		
		m_pPassword.secureTextEntry = YES;
		[self addSubview:m_pPassword];
		
		ActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40, 390, 32, 32)];
		
		[self addSubview:ActivityIndicator];
        
        m_pBackView = [[UIView alloc] init];
        m_pBackView.backgroundColor = [UIColor clearColor];

		
	}
	return self;
}


- (void)addObservers 
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}

- (void)removeObservers 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIKeyboardWillShowNotification" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIKeyboardWillHideNotification" object:nil];
}

-(void) dealloc
{

	[m_pMainBack release];
	[_closeButton release];
	[m_pCancel release];

	[m_pMaskView release];
	[m_pUserName release];
	[m_pPassword release];
	[ActivityIndicator release];
	[m_pBackView release];
	[super dealloc];
}

- (void)show
{
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) 
    {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	m_pBackView.frame = window.frame;
    
    [m_pBackView addSubview:self];
    [window addSubview:m_pBackView];
	

	
	self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/1.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
	self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
	[UIView commitAnimations];
	
	[self addObservers];

}

- (void)postDismissCleanup 
{
	[self removeFromSuperview];
    [m_pBackView removeFromSuperview];
	[self removeObservers];
}

- (void)dismiss:(BOOL)animated
{
	

	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:kTransitionDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(postDismissCleanup)];
		self.alpha = 0;
		[UIView commitAnimations];
	} else {
		[self postDismissCleanup];
	}
}

- (void)bounce1AnimationStopped 
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
	self.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
	[UIView commitAnimations];
}

- (void)bounce2AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/2];
	self.transform = [self transformForOrientation];
	[UIView commitAnimations];
}

- (CGAffineTransform)transformForOrientation
{
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		return CGAffineTransformMakeRotation(M_PI*1.5);
	} else if (orientation == UIInterfaceOrientationLandscapeRight) {
		return CGAffineTransformMakeRotation(M_PI/2);
	} else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}

- (void)keyboardWillShow:(NSNotification*)notification 
{
	float moveAmount = 190;
	float moveTime = 0.3;

	[self animationView:m_pMainBack initFrame:CGRectMake(0, 0, 280, 401) endFrame:CGRectMake(0, 0 - moveAmount, 280, 401) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pCancel initFrame:CGRectMake(80, 390, 76, 32) endFrame:CGRectMake(80, 390 - moveAmount, 76, 32) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pConnect initFrame:CGRectMake(165, 390, 90, 32) endFrame:CGRectMake(165, 390 - moveAmount, 90, 32) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pUserName initFrame:CGRectMake(104, 274, 170, 30) endFrame:CGRectMake(104, 274 - moveAmount, 170, 30) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pPassword initFrame:CGRectMake(104, 315, 170, 30) endFrame:CGRectMake(104, 315 - moveAmount, 170, 30) initAlpha:1 endAlpha:1 animationtime:moveTime];

}

- (void)keyboardWillHide:(NSNotification*)notification 
{
	float moveAmount = 190;
	float moveTime = 0.3;
	
	[self animationView:m_pMainBack initFrame:CGRectMake(0, 0- moveAmount, 280, 401) endFrame:CGRectMake(0, 0 , 280, 401) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pCancel initFrame:CGRectMake(80, 390- moveAmount, 76, 32) endFrame:CGRectMake(80, 390 , 76, 32) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pConnect initFrame:CGRectMake(165, 390- moveAmount, 90, 32) endFrame:CGRectMake(165, 390, 90, 32) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pUserName initFrame:CGRectMake(104, 274- moveAmount, 170, 30) endFrame:CGRectMake(104, 274, 170, 30) initAlpha:1 endAlpha:1 animationtime:moveTime];
	[self animationView:m_pPassword initFrame:CGRectMake(104, 315- moveAmount, 170, 30) endFrame:CGRectMake(104, 315, 170, 30) initAlpha:1 endAlpha:1 animationtime:moveTime];
	
}


- (void)cancel:(id)sender
{

	[m_pUserName resignFirstResponder];
	[m_pPassword resignFirstResponder];
	[self dismiss:YES];
}
- (void)onConnect:(id)sender
{
	[m_pUserName resignFirstResponder];
	[m_pPassword resignFirstResponder];
	
	[delegate SetUserName:m_pUserName.text Password:m_pPassword.text];
	[ActivityIndicator startAnimating];
	
	
}
-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime;
{
	[view setFrame:sFrame];
	[view setAlpha:sAlpha];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:rTime];
	[view setFrame:eFrame];
	[view setAlpha:eAlpha];
	[UIView commitAnimations];	
}
-(void) stopAnimation
{
	[ActivityIndicator stopAnimating];
}
@end
