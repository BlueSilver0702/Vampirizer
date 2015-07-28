//
//  ShareSetting.mm
//  Vampirizer
//
//  Created by user on 11/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShareSetting.h"
#import "VampirizerAppDelegate.h"

@implementation ShareSetting
@synthesize m_pPareantController;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	UIImageView* pBackground;
	pBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBackground.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:pBackground];
	[self.view addSubview:pBackground];
	[pBackground release];
	
	UIImageView* pOkOrNot;
	pOkOrNot = [[UIImageView alloc] initWithFrame:CGRectMake(45, 43, 229, 145)];
	pOkOrNot.image = [UIImage imageNamed:@"07-02text.png"];
	[self.view addSubview:pOkOrNot];
	[self.view addSubview:pOkOrNot];
	[pOkOrNot release];

	pOkOrNot = [[UIImageView alloc] initWithFrame:CGRectMake(49, 250, 90, 79)];
	pOkOrNot.image = [UIImage imageNamed:@"07-02text2.png"];
	[self.view addSubview:pOkOrNot];
	[self.view addSubview:pOkOrNot];
	[pOkOrNot release];
	
	m_pFaceBookSignIn = [[UIButton alloc] initWithFrame:CGRectMake(192,243,85,30)];
	[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
	[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];
	
	[m_pFaceBookSignIn addTarget:self action:@selector(onFaceBookSignIn:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pFaceBookSignIn];
	
	m_pTwitterSignIn = [[UIButton alloc] initWithFrame:CGRectMake(192,304,85,30)];
	[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
	[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];
	
	[m_pTwitterSignIn addTarget:self action:@selector(onTwitterSignIn:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pTwitterSignIn];
	
	UIButton* pSaveSetting = [[UIButton alloc] initWithFrame:CGRectMake(100,377,136,30)];
	[pSaveSetting setBackgroundImage:[UIImage imageNamed:@"but-saveset-up.png"] forState:UIControlStateNormal];
	[pSaveSetting setBackgroundImage:[UIImage imageNamed:@"but-saveset-click.png"] forState:UIControlStateHighlighted];
	
	[pSaveSetting addTarget:self action:@selector(onSaveSetting:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pSaveSetting];
	[pSaveSetting release];
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	app.m_pShareSetting = self;
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
	
	[m_pFaceBookSignIn release];

	
}
-(void) onFaceBookSignIn:(id)sender
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if ([app.facebook isSessionValid])
	{
//		app.m_fFromUpLoad = FALSE;
//		[app FacebookLogOut];
        LogoutDialog *dlg = [[LogoutDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        dlg.delegate = self;
        [dlg setMode:0];
        
        [self.view addSubview:dlg];
        [dlg release];
	}
	else
	{
		app.m_fFromUpLoad = FALSE;
		[app FacebookLogin];
	}

	
}
-(void) onTwitterSignIn:(id)sender
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	
	if (![app.m_pTwitterEngine isLogin])
	{
		app.m_fFromUpLoad = FALSE;
		[app TwitterLogIn];
	}
	else
	{
//		app.m_fFromUpLoad = FALSE;
//		[app TwitterLogOut];
        
        LogoutDialog *dlg = [[LogoutDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        dlg.delegate = self;
        [dlg setMode:1];
        
        [self.view addSubview:dlg];
        [dlg release];
	}

	
}

#pragma mark ======== LogoOut delegate ==========
- (void) closeLogoutDialog:(int) mode{
    
    VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;

    if (mode == 0) { //facebook
        app.m_fFromUpLoad = FALSE;
		[app FacebookLogOut];
    }else if (mode == 1) { //twitter
        app.m_fFromUpLoad = FALSE;
		[app TwitterLogOut];
    }
        
}

-(void) onSaveSetting:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) SetFacebookSign:(bool) fSigned
{
	if (fSigned)
	{
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-up.png"] forState:UIControlStateNormal];
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-click.png"] forState:UIControlStateHighlighted];
		
	}
	else
	{
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];

	}

}

-(void) Init
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if ([app.facebook isSessionValid])
	{
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-up.png"] forState:UIControlStateNormal];
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-click.png"] forState:UIControlStateHighlighted];
	}
	else
	{
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
		[m_pFaceBookSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];
	}
	
	if ([app.m_pTwitterEngine isLogin])
	{
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-up.png"] forState:UIControlStateNormal];
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-click.png"] forState:UIControlStateHighlighted];
	}
	else
	{
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];
	}
	
}

-(void) SetTwitterSign
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if ([app.m_pTwitterEngine isLogin])
	{
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-up.png"] forState:UIControlStateNormal];
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signout-click.png"] forState:UIControlStateHighlighted];
	}
	else
	{
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-up.png"] forState:UIControlStateNormal];
		[m_pTwitterSignIn setBackgroundImage:[UIImage imageNamed:@"but-signin-click.png"] forState:UIControlStateHighlighted];
	}
}

@end
