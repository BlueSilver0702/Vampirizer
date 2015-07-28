//
//  MyClanManager.m
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyClanManager.h"
#import "VampirizerAppDelegate.h"
#import "Config.h"
#import "sessionMgr.h"
#import "SendMessage.h"
#import "SImage.h"

#import "CustomAlertView.h"

@implementation MyClanManager

@synthesize m_nManageIndex;
@synthesize m_nMode;
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
	[pBackground release];
	
	m_pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    m_pImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:m_pImageView];
	[m_pImageView release];

	pTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	pTopView.image = [UIImage imageNamed:@"top-bar.png"];
	[self.view addSubview:pTopView];
	[pTopView release];
	
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
	

	pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(11,440,70,30)];

	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];

	pBtnShare = [[UIButton alloc] initWithFrame:CGRectMake(101,440,70,30)];
	[pBtnShare setBackgroundImage:[UIImage imageNamed:@"but-share-up.png"] forState:UIControlStateNormal];
	[pBtnShare setBackgroundImage:[UIImage imageNamed:@"but-share-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnShare addTarget:self action:@selector(onShare:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnShare];
	[pBtnShare release];

	
	pBtnDelete = [[UIButton alloc] initWithFrame:CGRectMake(242,440,70,30)];
	[pBtnDelete setBackgroundImage:[UIImage imageNamed:@"but-delete-up.png"] forState:UIControlStateNormal];
	[pBtnDelete setBackgroundImage:[UIImage imageNamed:@"but-delete-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnDelete addTarget:self action:@selector(onDelete:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnDelete];
	[pBtnDelete release];

	
	pBtnHome = [[UIButton alloc] initWithFrame:CGRectMake(11,8,70,30)];
	[pBtnHome setBackgroundImage:[UIImage imageNamed:@"but-home-up.png"] forState:UIControlStateNormal];
	[pBtnHome setBackgroundImage:[UIImage imageNamed:@"but-home-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnHome addTarget:self action:@selector(onHome:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnHome];
	[pBtnHome release];

	pBtnSaveToAlbum = [[UIButton alloc] initWithFrame:CGRectMake(187,440,127,30)];
	[pBtnSaveToAlbum setBackgroundImage:[UIImage imageNamed:@"but-saveto-up.png"] forState:UIControlStateNormal];
	[pBtnSaveToAlbum setBackgroundImage:[UIImage imageNamed:@"but-saveto-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnSaveToAlbum addTarget:self action:@selector(onSaveToAlbum:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnSaveToAlbum];
	[pBtnSaveToAlbum release];
	
	m_pDarkBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	m_pDarkBack.image = [UIImage imageNamed:@"darkened-screen.png"];
	[self.view addSubview:m_pDarkBack];
	[m_pDarkBack release];
	
	m_pPopBox = [[UIImageView alloc] initWithFrame:CGRectMake(22, 137, 259, 153)];
	m_pPopBox.image = [UIImage imageNamed:@"popbox.png"];
	[self.view addSubview:m_pPopBox];


	m_pPopLabel = [[UIImageView alloc] initWithFrame:CGRectMake(54, 149, 201, 82)];
	m_pPopLabel.image = [UIImage imageNamed:@"07-09text.png"];
	[self.view addSubview:m_pPopLabel];
	[m_pPopLabel release];
	
	m_pFire = [[UIButton alloc] initWithFrame:CGRectMake(65,263,71,32)];
	[m_pFire setBackgroundImage:[UIImage imageNamed:@"but-fire-up.png"] forState:UIControlStateNormal];
	[m_pFire setBackgroundImage:[UIImage imageNamed:@"but-fire-click.png"] forState:UIControlStateHighlighted];
	
	[m_pFire addTarget:self action:@selector(onFire:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pFire];
	[m_pFire release];

	m_pFireBack = [[UIButton alloc] initWithFrame:CGRectMake(189,263,71,32)];
	[m_pFireBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[m_pFireBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[m_pFireBack addTarget:self action:@selector(onFireBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pFireBack];
	[m_pFireBack release];
	
	
	pSharingNow = [[UIImageView alloc] initWithFrame:CGRectMake(59, 256, 217, 22)];
	pSharingNow.image = [UIImage imageNamed:@"06-08text.png"];
	[self.view addSubview:pSharingNow];
	[pSharingNow release];
	
	pSharingComplete = [[UIImageView alloc] initWithFrame:CGRectMake(78, 254, 178, 22)];
	pSharingComplete.image = [UIImage imageNamed:@"06-09text.png"];
	[self.view addSubview:pSharingComplete];
	[pSharingComplete release];
	
	pBloodView = [[UIImageView alloc] initWithFrame:CGRectMake(78, 254, 178, 22)];
	[self.view addSubview:pBloodView];
	[pBloodView release];
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate*)[UIApplication sharedApplication].delegate;
	CGRect pLoadingBarRect = [app GetViewRect:CGRectMake(41, 181, 244, 101)];
	pLoadingBar = [[LoadingBar alloc] initWithFrame:pLoadingBarRect];
//	[self.view addSubview:pLoadingBar];
	
	pBloodFrame = [[UIImageView alloc] initWithFrame:CGRectMake(41, 181, 244, 101)];
	pBloodFrame.image = [UIImage imageNamed:@"loading-vial.png"];
	[self.view addSubview:pBloodFrame];
	[pBloodFrame release];
	
	 
	pLastOneThing = [[UIImageView alloc] initWithFrame:CGRectMake(81, 162, 168, 67)];
	pLastOneThing.image = [UIImage imageNamed:@"07-01text.png"];
	[self.view addSubview:pLastOneThing];
	[pLastOneThing release];
	
	 
	pBtnLastOneThingBack = [[UIButton alloc] initWithFrame:CGRectMake(65,263,70,30)];
	[pBtnLastOneThingBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnLastOneThingBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnLastOneThingBack addTarget:self action:@selector(onOneLastThingBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnLastOneThingBack];
	[pBtnLastOneThingBack release];
	
	pBtnSetting = [[UIButton alloc] initWithFrame:CGRectMake(182,263,70,30)];
	[pBtnSetting setBackgroundImage:[UIImage imageNamed:@"but-setting-up.png"] forState:UIControlStateNormal];
	[pBtnSetting setBackgroundImage:[UIImage imageNamed:@"but-setting-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnSetting addTarget:self action:@selector(onSetting:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnSetting];
	[pBtnSetting release];
	
	pOhNo = [[UIImageView alloc] initWithFrame:CGRectMake(82, 158, 161, 91)];
	pOhNo.image = [UIImage imageNamed:@"06-10text.png"];
	[self.view addSubview:pOhNo];
	[pOhNo release];
	
	
	pBtnOhNoBack = [[UIButton alloc] initWithFrame:CGRectMake(134,263,70,30)];
	[pBtnOhNoBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnOhNoBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnOhNoBack addTarget:self action:@selector(onOhNoBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnOhNoBack];
	[pBtnOhNoBack release];
	[self Init];
	
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
	[m_pPopBox release];
	[pLoadingBar release];
}


-(void)onDelete:(id)sender
{
	[self DeleteControllsShow:YES];
	
}
-(void)onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)onShare:(id)sender
{
	UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:@"Share your new vampire" delegate:self 
											 cancelButtonTitle:nil 
										destructiveButtonTitle:nil 
											 otherButtonTitles:@"Facebook", @"Twitter", @"Email",@"Cancel", nil];
	sheet.destructiveButtonIndex = 3;
	[sheet showInView:self.view];
	[sheet release];

//	[self StartLoding];

}

-(void)Init
{
//	int nImageWidth,nImageHeight;
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	app.m_pMyClanManager = self;
	
	m_pImageView.image = app.m_pProcessedImage;
	
//	nImageHeight = app.m_pProcessedImage.size.height;
//	nImageWidth = app.m_pProcessedImage.size.width;
//	
//	float rScale = MAX(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
//	[app SetScale:rScale];
//	m_pImageView.frame = CGRectMake(0, 0, nImageWidth * rScale, nImageHeight * rScale);
//	m_pImageView.center = CGPointMake(ScreenWidth / 2, ScreenViewHeight/2);

	
	[self HideSharing];
	[self ShowOhNo:FALSE];
	[self ShowLastOneThink:FALSE];
	
	if (m_nMode == Clan_Mode)
	{
		[self DeleteControllsShow:FALSE];
		pTopView.hidden = FALSE;
		pTipView.hidden = FALSE;
		pBtnDelete.hidden = FALSE;
		
		pBtnSaveToAlbum.hidden = TRUE;
		pBtnHome.hidden = TRUE;
		pBtnBack.hidden = FALSE;
		
		pBtnShare.frame = CGRectMake(130, 440, 70, 30);
		
	}
	else
	{
		[self DeleteControllsShow:FALSE];
		pTopView.hidden = FALSE;
		pTipView.hidden = TRUE;
		pBtnDelete.hidden = TRUE;
		
		pBtnSaveToAlbum.hidden = FALSE;
		pBtnHome.hidden = FALSE;
		pBtnBack.hidden = FALSE;
		
		pBtnShare.frame = CGRectMake(101, 440, 70, 30);
		
	}

}
-(void)DeleteControllsShow:(BOOL) fShow
{
	if (fShow)
	{
		m_pPopBox.frame = CGRectMake(24, 147, 274, 159);
		m_pPopLabel.frame = CGRectMake(59, 158, 216, 90);
	}
	
	m_pDarkBack.hidden = !fShow;
	m_pPopBox.hidden = !fShow;
	m_pPopLabel.hidden = !fShow;
	
	m_pFireBack.hidden = !fShow;
	m_pFire.hidden = !fShow;

}

-(void) animationDelete:(bool) fShow
{
	
	
}


-(void) onFire:(id)sender
{
	NSString* path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	Session* session = [[Session alloc] init];
	
	[session deleteResultImage:path index:m_nManageIndex];
	
	[session release];
	
	[self.navigationController popViewControllerAnimated:YES];
}
-(void) onFireBack:(id)sender
{
	[self DeleteControllsShow:FALSE];

}

-(void) onSaveToAlbum:(id)sender
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;

	UIImageWriteToSavedPhotosAlbum(app.m_pProcessedImage, nil, nil, nil);

/*
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil 
												message:@"Image saved." 
											   delegate:self 
									  cancelButtonTitle:@"OK" 
									  otherButtonTitles:nil];
	[alert show];
	[alert release];
*/

    CustomAlertView* alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [alert setTitleText:@"" : @"Image saved"];
    [self.view addSubview:alert];
    [alert release];
	
}
-(void) onHome:(id)sender
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	[self.navigationController popToViewController:app.m_pSelectPhotoController animated:YES];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	switch (buttonIndex) 
	{
		case 0: 
		{
			if([app.facebook isSessionValid])
			{
				[self SendMessage:MessageFaceBook];
				
			}
			else
			{
				app.m_fFromUpLoad = TRUE;
				[app FacebookLogin];
			}

			break;
		}
		case 1:
		{
			if ([app.m_pTwitterEngine isLogin])
			{
				[self SendMessage:MessageTwitter];
			}
			else
			{
				app.m_fFromUpLoad = TRUE;
				[app TwitterLogIn];

			}

			break;
		}
		case 2:
		{
			[self showPicker];
			break;
		}
		default:
			break;
	}
}


#pragma mark Email
-(void)showPicker
{
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
//	MFMailComposeViewController* picker = [[MFMailComposeViewControllerss alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Someone's been bitten!"];
	
	// Set up recipients
//	NSArray *toRecipients = [NSArray arrayWithObject:@""]; 
//	NSArray *ccRecipients = [NSArray arrayWithObjects:@"", @"", nil]; 
//	NSArray *bccRecipients = [NSArray arrayWithObject:@""]; 
	
	//[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	
	UIImage* UploadImage;
    
	int nImageWidth,nImageHeight;
	
	
	nImageHeight = app.m_pProcessedImage.size.height;
	nImageWidth = app.m_pProcessedImage.size.width;
	
	float rScale = MIN(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
	
	UploadImage = ScaleUIImage(app.m_pProcessedImage, rScale);
	
	
	
	NSData *myData;
	
	myData = UIImagePNGRepresentation(UploadImage);
	
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	
	// Fill out the email body text
//	NSString *emailBody = @"<p>Made with the <a href=\"http://itunes.apple.com/us/app/diet-kiosk-hd/id423254635?mt=8&ls=1\">RolePlay </a> App!</p>";
	NSString *emailBody = @"<p>Created with the <a href=\"www.cyclone-digital.com/iosvampirizer\">Vampirizer</a> IPhone app.</p>";
	
	[picker setMessageBody:emailBody isHTML:YES];
	
	[UploadImage release];
	
	[self presentModalViewController:picker animated:YES];
	
	
	
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	
	[self dismissModalViewControllerAnimated:YES];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


#pragma mark Blood Processing
-(void)BloodProcessing:(float) rPercent
{
	m_pDarkBack.hidden = FALSE;
	m_pPopBox.hidden = FALSE;
	
	m_pPopBox.frame = CGRectMake(30, 137, 259, 153);
	
	pBloodView.hidden = FALSE;
	pBloodFrame.hidden = FALSE;
	pSharingNow.hidden = FALSE;
	pSharingComplete.hidden = TRUE;
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;


	[app ProcessView:pBloodView rect:pBloodFrame.frame percent:rPercent];
	
}

-(void) SharingComplete
{
	pSharingNow.hidden = TRUE;
	pSharingComplete.hidden = FALSE;
	[self performSelector:@selector(HideSharing) withObject:nil afterDelay:2.0f];
}

-(void) HideSharing
{
	m_pDarkBack.hidden = TRUE;
	m_pPopBox.hidden = TRUE;
	pBloodView.hidden = TRUE;
	pBloodFrame.hidden = TRUE;
	pSharingNow.hidden = TRUE;
	pSharingComplete.hidden = TRUE;
	
	pLoadingBar.hidden = TRUE;
}


-(void) SendMessage:(int) nMode
{
	[self ShowLastOneThink:FALSE];
	SendMessage* pSendMessage = [[SendMessage alloc] initWithNibName:@"SendMessage" bundle:nil];
	UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:pSendMessage];
	
	pSendMessage.controller = self;
	pSendMessage.m_Mode = nMode;
	
	[self presentModalViewController:navController animated:YES];
	[pSendMessage release];
	[navController release]; 
}

-(void) Return
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

-(void) ShowLastOneThink:(bool) fShow
{
	m_pDarkBack.hidden = !fShow;
	m_pPopBox.hidden = !fShow;
	pLastOneThing.hidden = !fShow;
	pBtnLastOneThingBack.hidden = !fShow;
	pBtnSetting.hidden = !fShow;
	
	if (fShow)
	{
		m_pPopBox.frame = CGRectMake(26, 148, 276, 161);
		pLastOneThing.frame  = CGRectMake(81, 162, 171, 68);
		pBtnLastOneThingBack.frame = CGRectMake(64, 262, 73, 33);
		pBtnSetting.frame = CGRectMake(180, 262, 80, 33);
	}

}
-(void) ShowOhNo:(bool) fShow
{
	[self HideSharing];
	[self HideLoading];
	m_pDarkBack.hidden = !fShow;
	m_pPopBox.hidden = !fShow;
	pOhNo.hidden = !fShow;
	pBtnOhNoBack.hidden = !fShow;
	
	if (fShow)
	{
		m_pPopBox.frame = CGRectMake(23, 146, 275, 162);
		pBtnOhNoBack.frame = CGRectMake(133, 263, 71, 29);
		pOhNo.frame = CGRectMake(82, 158, 158, 88);
		
		
	}
	
}

-(void) onOneLastThingBack:(id)sender
{
	[self ShowLastOneThink:FALSE];
}
-(void) onOhNoBack:(id)sender
{
	[self ShowOhNo:FALSE];
}
-(void) onSetting:(id)sender
{
	[self ShowLastOneThink:NO];
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	[app ShowSetting];
}

-(void) HideLoading
{
	m_pDarkBack.hidden = TRUE;
	m_pPopBox.hidden = TRUE;
	pBloodFrame.hidden = TRUE;
	pLoadingBar.hidden = TRUE;
	pSharingNow.hidden = TRUE;
	pSharingComplete.hidden = TRUE;
}
-(void) StartLoding
{
	m_pDarkBack.hidden = FALSE;
	m_pPopBox.hidden = FALSE;
	pSharingNow.hidden = FALSE;
	pSharingComplete.hidden = TRUE;
	
	pBloodFrame.hidden = FALSE;
	pLoadingBar.hidden = FALSE;
	
	m_pPopBox.frame = CGRectMake(24, 146, 276, 160);
	
	[pLoadingBar startAnimation];
	
}
-(void) CompleteLoading
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate*)[UIApplication sharedApplication].delegate;
	[pLoadingBar stopAnimation];
	
	pSharingNow.hidden = TRUE;
	pSharingComplete.hidden = FALSE;
	[app ProcessView:pBloodView rect:pBloodFrame.frame percent:1.0f];
	
	[self performSelector:@selector(HideSharing) withObject:nil afterDelay:2.0f];
}

-(void) StopLoading
{
	[pLoadingBar stopAnimation];
	[self HideLoading];
	[self ShowOhNo:YES];
	
}


-(void)animationView:(UIView*)view initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime
{
	[view setAlpha:sAlpha];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:rTime];
	[view setAlpha:eAlpha];
	[UIView commitAnimations];	
}

@end
