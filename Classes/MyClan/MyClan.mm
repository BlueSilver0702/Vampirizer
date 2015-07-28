//
//  MyClan.mm
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyClan.h"
#import "VampirizerAppDelegate.h"
#import "sessionMgr.h"

@implementation MyClan

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
	pBackground.image = [UIImage imageNamed:@"theclan-bg.png"];
	[self.view addSubview:pBackground];
	[self.view addSubview:pBackground];
	[pBackground release];
	
	UIImageView* pTopView;
	pTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	pTopView.image = [UIImage imageNamed:@"top-bar.png"];
	[self.view addSubview:pTopView];
	[pTopView release];
	
	UIImageView* pTipView;
	pTipView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 10, 87, 24)];
	pTipView.image = [UIImage imageNamed:@"myclan.png"];
	[self.view addSubview:pTipView];
	[pTipView release];
	
	
	
	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(17,438,69,31)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
	m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 52, 320, 380)];
	[self.view addSubview:m_pScrollView];

	
	m_pImageSelection = [[ImageSelectView alloc] initWithFrame:m_pScrollView.bounds];
	m_pImageSelection.delegate = self;
	[m_pScrollView addSubview:m_pImageSelection];
	m_pScrollView.contentSize = m_pImageSelection.bounds.size;
	
    
    ActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    ActivityIndicator.center = CGPointMake(160, 240);
    [self.view addSubview:ActivityIndicator];

	

}

-(void) viewWillAppear:(BOOL)animated
{
	[ActivityIndicator startAnimating];
	[self performSelector:@selector(refresh) withObject:nil afterDelay:0.01f];

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
	[m_pScrollView release];
    [super dealloc];
}

-(void) Init
{
	[ActivityIndicator startAnimating];
	[self performSelector:@selector(refresh) withObject:nil afterDelay:0.01f];
}
-(void) onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) refresh
{
	[m_pImageSelection refresh];
	m_pScrollView.contentSize = m_pImageSelection.bounds.size;
	[ActivityIndicator stopAnimating];
	
}

-(void)ReturnImageIndex:(int)i
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate* )[UIApplication sharedApplication].delegate;
	
	NSString* path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	Session* session = [[Session alloc] init];
	
	if(app.m_pProcessedImage)
	{
		[app.m_pProcessedImage release];
		app.m_pProcessedImage = nil;
	}
	app.m_pProcessedImage = [session loadResultImage:path index:i];
	[session release];	
	
	[self.navigationController pushViewController:m_pMyClanManager animated:YES];
	m_pMyClanManager.m_nManageIndex = i;
	m_pMyClanManager.m_nMode = Clan_Mode;
	
	[m_pMyClanManager Init];
}
@end
