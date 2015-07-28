//
//  SendMessage.mm
//  FatBooth
//
//  Created by user on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SendMessage.h"
#import "VampirizerAppDelegate.h"
#import "MyClanManager.h"

@implementation SendMessage
@synthesize m_pUserName;
@synthesize m_pPassWord;
@synthesize m_Mode;
@synthesize controller;
@synthesize m_pMessageText;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

 	NSString* strNibName;
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		strNibName = [NSString stringWithFormat:@"%@_iPhone", nibNameOrNil];
	else
		strNibName = [NSString stringWithFormat:@"%@_iPad", nibNameOrNil];
	
	self = [super initWithNibName:strNibName bundle:nibBundleOrNil];
	
	
    if (self) {
        // Custom initialization.
    }
    return self;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	VampirizerAppDelegate *appDelegate = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	UIImage*	image;
	
	image = appDelegate.m_pProcessedImage;
	
	m_pPhoto.image = image;
    m_pMessageText.delegate = self;

	UIImageView* pBack;
	pBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBack.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:pBack];
	[pBack release];
	
	
	UIImageView* pTopView;
	pTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	pTopView.image = [UIImage imageNamed:@"top-bar.png"];
	[self.view addSubview:pTopView];
	[pTopView release];
	
	UIImageView* pTextBox;
	pTextBox = [[UIImageView alloc] initWithFrame:CGRectMake(15, 63, 291, 180)];
	pTextBox.image = [UIImage imageNamed:@"textbox.png"];
	[self.view addSubview:pTextBox];
	[pTextBox release];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(9,8,70,30)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but_cancel_up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but_cancel_click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onCancel:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
	
	UIButton* pBtnNext = [[UIButton alloc] initWithFrame:CGRectMake(240,8,70,30)];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but_share_up.png"] forState:UIControlStateNormal];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but_share_click.png"] forState:UIControlStateHighlighted];
	
	[pBtnNext addTarget:self action:@selector(onSend:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnNext];
	[pBtnNext release];
	
	
	UIImageView* pMark;
	if (m_Mode == MessageFaceBook)
	{
		pMark = [[UIImageView alloc] initWithFrame:CGRectMake(112, 8, 103, 25)];
		pMark.image = [UIImage imageNamed:@"logo-facebook.png"];
		[self.view addSubview:pMark];
		[pMark release];
		
	}
	if (m_Mode == MessageTwitter)
	{
		pMark = [[UIImageView alloc] initWithFrame:CGRectMake(112, 8, 103, 25)];
		pMark.image = [UIImage imageNamed:@"logo-twitter.png"];
		[self.view addSubview:pMark];
		[pMark release];
		
		UIImageView* pRemain;
		pRemain = [[UIImageView alloc] initWithFrame:CGRectMake(253, 215, 40, 20)];
		pRemain.image = [UIImage imageNamed:@"textcount-bg.png"];
		[self.view addSubview:pRemain];
		[pRemain release];
		
	}
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																						   target:self action:@selector(onCancel:)] autorelease];
	UIImageView* pPicture;
	pPicture = [[UIImageView alloc] initWithFrame:CGRectMake(250, 58, 46, 63)];
	pPicture.image = appDelegate.m_pProcessedImage;
	pPicture.transform = CGAffineTransformMakeRotation( - M_PI / 72);
	[self.view addSubview:pPicture];
	[pPicture release];
	
	UIImageView* pGrip;
	pGrip = [[UIImageView alloc] initWithFrame:CGRectMake(248, 56, 17, 36)];
	pGrip.image = [UIImage imageNamed:@"clip.png"];
	[self.view addSubview:pGrip];
	[pGrip release];
	
	m_pMessageText = [[UITextView alloc] initWithFrame:CGRectMake(24, 69, 222, 170)];
    m_pMessageText.font = [UIFont fontWithName:@"Arial" size:16];
	[self.view addSubview:m_pMessageText];
	
	if (m_Mode == MessageTwitter)
	{
		m_LeftCharacterNum = [[UITextField alloc] initWithFrame:CGRectMake(262, 217, 25, 20)];
		m_LeftCharacterNum.textAlignment = UITextAlignmentRight;
		m_LeftCharacterNum.font = [UIFont boldSystemFontOfSize:13];
		m_nLeftCharacterNum = 105;
		m_LeftCharacterNum.text = @"105";
		[self.view addSubview:m_LeftCharacterNum];
	}
	
	[m_pMessageText setEditable:YES];
	m_pMessageText.delegate = self;
	
	
	[self.navigationController setNavigationBarHidden:YES];	
//	UIImage* backgroundImage = [UIImage imageNamed:@"twitter.png"];
//	[[UINavigationBar ]]
	
	
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

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
	[m_LeftCharacterNum release];
}


- (void) viewWillAppear:(BOOL)animated{
    
    [m_pMessageText becomeFirstResponder];
}

-(IBAction)onCancel:(id)sender
{
	[controller Return];
	
}


-(IBAction)onSend:(id)sender
{
	
	[self.view endEditing:YES];

	[self onCancel:nil];

	
	if (m_Mode == MessageTwitter)
	{
		
//		TwitpicEngine *twitpicEngine = [[TwitpicEngine alloc] initWithDelegate:self];
//	
//		UIImage*	image;
//		VampirizerAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//
//		
//		image = appDelegate.m_pProcessedImage;
//
//        NSString* szCurMessage = m_pMessageText.text;
//        NSString* szMessage = [NSString stringWithFormat:@"%@#Vampirizer http://",szCurMessage];
//
//		m_pPassWord = appDelegate.m_szTwitPass;
//		
//		m_pUserName = appDelegate.m_szTwitUserName;
//		
//	
//        [self AddAlertWindow];
//        if(m_pPassWord ==nil || m_pUserName == nil)
//            return;
//		[twitpicEngine uploadImageToTwitpic:image withMessage:szMessage
//							   username:m_pUserName password:m_pPassWord];
//	
//		[twitpicEngine release];
		
		[self performSelector:@selector(UploadToTwitter) withObject:nil afterDelay:0.1f];

		

		
	}
	else
	{
		VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
        NSString* szMessage = m_pMessageText.text;
		
		szMessage = [szMessage stringByAppendingString:@"\n Bring out your vampire alter ego..."];
		
		
		[app UploadPhotoToFacebook:szMessage];
		

	}

}


-(void)AddAlertWindow
{
    alertMain = [[[UIAlertView alloc] initWithTitle:@"Uploading Photo\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
    [alertMain show];
    
    ActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    ActivityIndicator.center = CGPointMake(150, 85);
    [alertMain addSubview:ActivityIndicator];
    [ActivityIndicator startAnimating];
}

//- (void)twitpicEngine:(TwitpicEngine *)engine didUploadImageWithResponse:(NSString *)response{
//    [ActivityIndicator stopAnimating];
//    [alertMain dismissWithClickedButtonIndex:0 animated:YES];
//    
//    if([response hasPrefix:@"http://"])
//    {
//        UIAlertView *baseAlert = [[[UIAlertView alloc] initWithTitle:@"Photo Uploaded Successfully." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] autorelease];
//        [baseAlert show];
//    }
//    else if([[response uppercaseString] isEqualToString:@"ERROR"])
//    {
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",@"Error") message:NSLocalizedString(@"Unable to upload Photo",@"Unable to upload Flyers") delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss",@"Dismiss") otherButtonTitles: nil] autorelease];
//        [alert show];
//        
//    }
//    else
//    {
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",@"Error") message:response delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss",@"Dismiss") otherButtonTitles: nil] autorelease];
//        [alert show];
//        
//    }
//	[self onCancel:nil];
//}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
	{
        [textView resignFirstResponder];
        return NO;
    }

    if(textView != m_pMessageText)
        return NO;
	
	int nCurLength = [textView.text length];

    if(nCurLength > 105 && [text length] != 0)
        return NO;
	
	if ([text length] == 0)
	{
		nCurLength -= 2;
	}
	
	if (m_Mode == MessageTwitter)
	{
		m_nLeftCharacterNum = 105 - nCurLength;
		m_LeftCharacterNum.text = [NSString stringWithFormat:@"%d", m_nLeftCharacterNum]; 
		return YES;
	}
	return YES;
}

-(void) UploadToTwitter
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	NSString* szCurMessage = m_pMessageText.text;
	
	szCurMessage = [szCurMessage stringByAppendingString:@"\n Bring out your vampire alter ego..."];
	
	NSString* szMessage = [NSString stringWithFormat:@"%@  #Vampirizer http://",szCurMessage];

	
	[app UploadPhotoToTwitter:szMessage];
}

@end
