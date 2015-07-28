//
//  StartViewController.mm
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"


@implementation StartViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
        
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:YES];

	UIImageView* pBackground;
	pBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBackground.image = [UIImage imageNamed:@"Vampirizer-logo.png"];
	[self.view addSubview:pBackground];

	[pBackground release];

	
	UIButton* pbtnStart;
	pbtnStart = [[UIButton alloc] initWithFrame:CGRectMake(39,330,244,51)];
	[pbtnStart setBackgroundImage:[UIImage imageNamed:@"but-start-up.png"] forState:UIControlStateNormal];
	[pbtnStart setBackgroundImage:[UIImage imageNamed:@"but-start-down.png"] forState:UIControlStateHighlighted];
	
	[pbtnStart addTarget:self action:@selector(onStart:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pbtnStart];
	[pbtnStart release];
	
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

-(void) onStart:(id)sender
{
	[self.navigationController pushViewController:m_pSelectViewController animated:YES];
}
@end
