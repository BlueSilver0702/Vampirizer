//
//  helpViewController.mm
//  Vampirizer
//
//  Created by user on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "helpViewController.h"


@implementation helpViewController
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
    [super viewDidLoad];
	
	
	UIImageView* pBackground;
	pBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBackground.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:pBackground];
	[self.view addSubview:pBackground];
	[pBackground release];
	
	UIImageView* pOkOrNot;
	pOkOrNot = [[UIImageView alloc] initWithFrame:CGRectMake(26, 54, 269, 366)];
	pOkOrNot.image = [UIImage imageNamed:@"07-10text.png"];
	[self.view addSubview:pOkOrNot];
	[self.view addSubview:pOkOrNot];
	[pOkOrNot release];
	
	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(15,438,71,32)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning
{
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

-(void) onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSSet* allTouch = [event touchesForView:self.view];
	
	UITouch *touch = [allTouch anyObject];
	CGPoint touchPoint= [touch locationInView:self.view];	

	if(CGRectContainsPoint(CGRectMake(91, 299, 147, 52), touchPoint))
	{
		NSURL *url;
		
		url = [NSURL URLWithString:@"http://www.facebook.com/vampirizer"];
		[[UIApplication sharedApplication] openURL:url];
		
	}
}
@end
