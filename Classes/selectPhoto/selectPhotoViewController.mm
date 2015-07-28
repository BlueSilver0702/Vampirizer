//
//  selectPhotoViewController.mm
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "selectPhotoViewController.h"
#import "VampirizerAppDelegate.h"

@implementation selectPhotoViewController

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
    [super viewDidLoad];
	
	UIImageView* pBackground;
	pBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBackground.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:pBackground];
	[self.view addSubview:pBackground];
	[pBackground release];
	
	
	m_pCamera = [[UIButton alloc] initWithFrame:CGRectMake(-22,54,278,226)];
	[m_pCamera setBackgroundImage:[UIImage imageNamed:@"pic-camera.png"] forState:UIControlStateNormal];
	[m_pCamera setBackgroundImage:[UIImage imageNamed:@"pic-camera.png"] forState:UIControlStateHighlighted];
	
	[m_pCamera addTarget:self action:@selector(onCameraOrAlbum:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pCamera];
	[m_pCamera release];
	
	
	m_pAlbum = [[UIButton alloc] initWithFrame:CGRectMake(115,101,248,178)];
	[m_pAlbum setBackgroundImage:[UIImage imageNamed:@"pic-library.png"] forState:UIControlStateNormal];
	[m_pAlbum setBackgroundImage:[UIImage imageNamed:@"pic-library.png"] forState:UIControlStateHighlighted];
	
	[m_pAlbum addTarget:self action:@selector(onCameraOrAlbum:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pAlbum];
	[m_pAlbum release];
	
	UIButton* pBtnClun = [[UIButton alloc] initWithFrame:CGRectMake(39,330,243,54)];
	[pBtnClun setBackgroundImage:[UIImage imageNamed:@"but-myclan-up.png"] forState:UIControlStateNormal];
	[pBtnClun setBackgroundImage:[UIImage imageNamed:@"but-myclan-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnClun addTarget:self action:@selector(onMyClan:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnClun];
	[pBtnClun release];
	
	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];

	UIButton* pBtnSetting = [[UIButton alloc] initWithFrame:CGRectMake(0,423,54,58)];
	[pBtnSetting setBackgroundImage:[UIImage imageNamed:@"icon-settings-up.png"] forState:UIControlStateNormal];
	[pBtnSetting setBackgroundImage:[UIImage imageNamed:@"icon-settings-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnSetting addTarget:self action:@selector(onSetting:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnSetting];
	[pBtnSetting release];
	

	UIButton* pBtnHelp = [[UIButton alloc] initWithFrame:CGRectMake(272,423,54,58)];
	[pBtnHelp setBackgroundImage:[UIImage imageNamed:@"icon-help-up.png"] forState:UIControlStateNormal];
	[pBtnHelp setBackgroundImage:[UIImage imageNamed:@"icon-help-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnHelp addTarget:self action:@selector(onHelp:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnHelp];
	[pBtnHelp release];
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	app.m_pSelectPhotoController = self;
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


- (void)dealloc {
    [super dealloc];
}

-(void) onCameraOrAlbum:(id)sender
{


	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if (sender == m_pCamera)
	{
		app.m_fCapturedFromCamera = TRUE;
	}
	else
	{
		app.m_fCapturedFromCamera = FALSE;
	}
	
	[self.navigationController pushViewController:m_pSelectFromCameraAndAlbum animated:YES];
	
	
}

-(void) onMyClan:(id)sender
{
	[self.navigationController pushViewController:m_pMyClan animated:YES];
	[m_pMyClan Init];
}
-(void) onSetting:(id)sender
{
	m_pShareSetting.m_pPareantController = self;
	[self.navigationController pushViewController:m_pShareSetting animated:YES];
	[m_pShareSetting Init];
	
}
-(void) onHelp:(id)sender
{
	m_pHelpViewController.m_pPareantController = self;
	[self.navigationController pushViewController:m_pHelpViewController animated:YES];

}

-(void) TwitterLogIn
{
	m_pTwitterLogIn.controller = self;
	[self.navigationController presentModalViewController:m_pTwitterLogIn animated:YES];

}


@end
