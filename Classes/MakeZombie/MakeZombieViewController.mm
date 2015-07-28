//
//  MakeZombieViewController.m
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MakeZombieViewController.h"
#import "VampirizerAppDelegate.h"

#import "sessionMgr.h"
#import "Theme.h"
#import "Config.h"

@implementation MakeZombieViewController

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
	
	m_pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:m_pImageView];
	[m_pImageView release];


	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];
	

	m_pSave = [[UIButton alloc] initWithFrame:CGRectMake(231,439,70,29)];
	[m_pSave setBackgroundImage:[UIImage imageNamed:@"but-save-up.png"] forState:UIControlStateNormal];
	[m_pSave setBackgroundImage:[UIImage imageNamed:@"but-save-click.png"] forState:UIControlStateHighlighted];
	[m_pSave addTarget:self action:@selector(onSave:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pSave];
	[m_pSave release];
	
	m_pTheme = [[UIButton alloc] initWithFrame:CGRectMake(121,439,70,29)];
	[m_pTheme setBackgroundImage:[UIImage imageNamed:@"but-theme-up.png"] forState:UIControlStateNormal];
	[m_pTheme setBackgroundImage:[UIImage imageNamed:@"but-theme-click.png"] forState:UIControlStateHighlighted];
	[m_pTheme addTarget:self action:@selector(onTheme:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:m_pTheme];
	[m_pTheme release];
	
	m_pShakeMeView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 146, 275, 112)];
	m_pShakeMeView.image = [UIImage imageNamed:@"Vamp05-10-popup.png"];
	[self.view addSubview:m_pShakeMeView];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(17,438,69,31)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
	pTempOriginal = nil;
	pTempResult = nil;
	
	[self canBecomeFirstResponder];
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
	if (pTempOriginal)
	{
		[pTempOriginal release];
	}
	if (pTempResult)
	{
		[pTempResult release];
	}
	
	[m_pShakeMeView release];

	
}

-(void) MakeZombie
{

	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	CGPoint LeftEyeCenter, RightEyeCenter, MouthCenter, ChinCenter;
	float LeftEyeWidth, RightEyeWidth, MouthWidth;
	float MouthAngle;

	CGRect leftRect = [app GetFaceTaggingRect:0];
	LeftEyeCenter.x = leftRect.origin.x + leftRect.size.width / 2;
	LeftEyeCenter.y = leftRect.origin.y + leftRect.size.height / 2;
	LeftEyeWidth = leftRect.size.width;
	
	CGRect rightRect = [app GetFaceTaggingRect:1];
	RightEyeCenter.x = rightRect.origin.x + rightRect.size.width / 2;
	RightEyeCenter.y = rightRect.origin.y + rightRect.size.height / 2;
	RightEyeWidth = rightRect.size.width;
	
	CGRect mouthRect = [app GetFaceTaggingRect:2];
	MouthCenter.x = mouthRect.origin.x + mouthRect.size.width / 2;
	MouthCenter.y = mouthRect.origin.y + mouthRect.size.height / 2;
	MouthWidth = app.m_rMouthWidth;
	MouthAngle = app.m_rMouthAngle;
	
	CGRect chinRect = [app GetFaceTaggingRect:3];
	ChinCenter.x = chinRect.origin.x + chinRect.size.width / 2;
	ChinCenter.y = chinRect.origin.y + chinRect.size.height;
	
	
	
	CGColorSpaceRef colorSpace;
	
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	int nSrcImageWidth, nSrcImageHeight;
	int nDesImageWidth, nDesImageHeight;
	
	UIImage *pSourceImage = app.m_pOrgImage;
	
	nSrcImageWidth = [pSourceImage size].width;
	nSrcImageHeight = [pSourceImage size].height;
	nDesImageWidth = nSrcImageWidth;
	nDesImageHeight = nSrcImageHeight;
	
	bitmapBytesPerRow   = (nSrcImageWidth * 4);
	bitmapByteCount   = (bitmapBytesPerRow * nSrcImageHeight);
	
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
		return;
	
	
	CGContextRef context = CGBitmapContextCreate (NULL,
												  nSrcImageWidth,
												  nSrcImageHeight,
												  8,      
												  bitmapBytesPerRow,
												  colorSpace,
												  kCGImageAlphaPremultipliedLast);
	
	
	CGContextDrawImage(context, CGRectMake(0, 0, nSrcImageWidth, nSrcImageHeight), [pSourceImage CGImage]);

	float rScaleX, rScaleY;
	UIImage* pEyeImage;
	
	//FaceHighlight
	rScaleX = (RightEyeCenter.x - LeftEyeCenter.x) / 95 ;
	rScaleY = (ChinCenter.y - LeftEyeCenter.y) / 171;
	
	pEyeImage = [UIImage imageNamed:@"face_highlight_(soft-light).png"];
	
	CGContextTranslateCTM(context, (RightEyeCenter.x + LeftEyeCenter.x) / 2, nDesImageHeight - (RightEyeCenter.y + LeftEyeCenter.y) / 2);
	CGContextSetBlendMode(context, kCGBlendModeSoftLight);
	CGContextDrawImage(context, CGRectMake( -228.5 * rScaleX, -259 * rScaleY,  390 * rScaleX, 443 * rScaleY), [pEyeImage CGImage]);
	CGContextTranslateCTM(context, - ((RightEyeCenter.x + LeftEyeCenter.x) / 2), - (nDesImageHeight - (RightEyeCenter.y + LeftEyeCenter.y) / 2));
	
	//EyeMask
	rScaleX = (RightEyeCenter.x - LeftEyeCenter.x) / 78 ;
	
	//Left
	pEyeImage = [UIImage imageNamed:@"darkened_eyesleft.png"];
	
	CGContextTranslateCTM(context, LeftEyeCenter.x, nDesImageHeight -  LeftEyeCenter.y);
	CGContextSetBlendMode(context, kCGBlendModeSoftLight);
	CGContextDrawImage(context, CGRectMake( -39 * rScaleX , -27 * rScaleX,  77 * rScaleX , 51 * rScaleX), [pEyeImage CGImage]);
	CGContextTranslateCTM(context, -  LeftEyeCenter.x, - (nDesImageHeight -  LeftEyeCenter.y));
	
	//Right
	pEyeImage = [UIImage imageNamed:@"darkened_eyesright.png"];
	
	CGContextTranslateCTM(context, RightEyeCenter.x, nDesImageHeight -  RightEyeCenter.y);
	CGContextSetBlendMode(context, kCGBlendModeSoftLight);
	CGContextDrawImage(context, CGRectMake( -39 * rScaleX * 2, -27 * rScaleX * 2,  77 * rScaleX * 2, 51 * rScaleX * 2), [pEyeImage CGImage]);
	CGContextTranslateCTM(context, -  RightEyeCenter.x, - (nDesImageHeight -  RightEyeCenter.y));
	
    int nEyeKind = rand() % 4;
//    nEyeKind = (nEyeKind >= 3) ? 0 : nEyeKind + 1;
	
	if (nEyeKind == m_nEyeKind)
	{
		nEyeKind++;
		if (nEyeKind == 4)
		{
			nEyeKind = 0;
			
		}
	}
	m_nEyeKind = nEyeKind;
	
	//LeftEye
	rScaleX = LeftEyeWidth / 96;
	
	switch (nEyeKind)
	{
		case 0:
			pEyeImage = [UIImage imageNamed:@"half-eye-blue-left.png"];
			break;
		case 1:
			pEyeImage = [UIImage imageNamed:@"half-eye-grey-left.png"];
			break;
		case 2:
			pEyeImage = [UIImage imageNamed:@"half-eye-red-left.png"];
			break;
		case 3:
			pEyeImage = [UIImage imageNamed:@"half-eye-yellow-left.png"];
			break;
			
		default:
			break;
	}
	if (nEyeKind < 3)
	{
		rScaleX = LeftEyeWidth / 106;
	}
	CGContextTranslateCTM(context, LeftEyeCenter.x, nDesImageHeight - LeftEyeCenter.y);
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextDrawImage(context, CGRectMake( -52 * rScaleX, -52 * rScaleX,  104 * rScaleX, 104 * rScaleX), [pEyeImage CGImage]);
	CGContextTranslateCTM(context, - LeftEyeCenter.x, - (nDesImageHeight - LeftEyeCenter.y));
	
	//RightEye
	rScaleX = RightEyeWidth / 96;
	
	switch (nEyeKind)
	{
		case 0:
			pEyeImage = [UIImage imageNamed:@"half-eye-blue-right.png"];
			break;
		case 1:
			pEyeImage = [UIImage imageNamed:@"half-eye-grey-right.png"];
			break;
		case 2:
			pEyeImage = [UIImage imageNamed:@"half-eye-red-right.png"];
			break;
		case 3:
			pEyeImage = [UIImage imageNamed:@"half-eye-yellow-right.png"];
			break;
			
		default:
			break;
	}
	if (nEyeKind < 3)
	{
		rScaleX = RightEyeWidth / 106;
	}
	CGContextTranslateCTM(context, RightEyeCenter.x, nDesImageHeight - RightEyeCenter.y);
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextDrawImage(context, CGRectMake( -52 * rScaleX, -52 * rScaleX,  104 * rScaleX, 104 * rScaleX), [pEyeImage CGImage]);
	CGContextTranslateCTM(context, - RightEyeCenter.x, - (nDesImageHeight - RightEyeCenter.y));
	
	//Mouth
//	static int nMouthKind = 0;
//    nMouthKind = (nMouthKind == 0) ? 1 : 0;
	int nMouthKind = rand() % 2;	
	if (m_nMouthKind == nMouthKind)
	{
		nMouthKind++;
		if (nMouthKind == 2)
		{
			nMouthKind = 0;
		}

	}
	m_nMouthKind = nMouthKind;
//	static int mouth = 0;
//    mouth = (mouth == 0) ? 1 : 0;
	if (rand() % 2 == 0)
	{
		rScaleX = MouthWidth / 238;
		pEyeImage = [UIImage imageNamed:@"bloodied-fangs.png"];
		
		CGContextTranslateCTM(context, MouthCenter.x, nDesImageHeight - MouthCenter.y);
		CGContextRotateCTM(context, -MouthAngle);
		CGContextSetBlendMode(context, kCGBlendModeNormal);
		CGContextDrawImage(context, CGRectMake( -119 * rScaleX, -56 * rScaleX,  238 * rScaleX, 112 * rScaleX), [pEyeImage CGImage]);
		CGContextRotateCTM(context,  MouthAngle);
		CGContextTranslateCTM(context, - MouthCenter.x, - (nDesImageHeight - MouthCenter.y));
	}
	else
	{
		rScaleX = MouthWidth / 319;
		rScaleY = (ChinCenter.y - MouthCenter.y) / 350;
		
		pEyeImage = [UIImage imageNamed:@"bloodied-mouth.png"];
		
		CGContextTranslateCTM(context, MouthCenter.x, nDesImageHeight - MouthCenter.y);
		CGContextRotateCTM(context,- MouthAngle);
		CGContextSetBlendMode(context, kCGBlendModeNormal);
		CGContextDrawImage(context, CGRectMake( -318 * rScaleX, -280 * rScaleY,  658 * rScaleX, 494 * rScaleY), [pEyeImage CGImage]);
		CGContextRotateCTM(context, MouthAngle);
		CGContextTranslateCTM(context, - MouthCenter.x, - (nDesImageHeight - MouthCenter.y));
		
	}

	
	

	CGImageRef ref = CGBitmapContextCreateImage(context);
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(ref);
	CGContextRelease(context);
	
	if (pTempOriginal)
	{
		[pTempOriginal release];
		pTempOriginal  = nil;
	}
	
	if (pTempResult)
	{
		[pTempResult release];
		pTempResult  = nil;
	}
	
	pTempOriginal = newImage;
	pTempResult = [[UIImage alloc] initWithCGImage:[newImage CGImage]];
	
	m_pImageView.image = newImage;
	
	
}
-(void) Init
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	int nImageWidth,nImageHeight;
	
	m_pImageView.image = app.m_pOrgImage;
	
	nImageHeight = app.m_pOrgImage.size.height;
	nImageWidth = app.m_pOrgImage.size.width;
	
	
	float rScale = MAX(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
	[app SetScale:rScale];
	m_pImageView.frame = CGRectMake(0, 0, nImageWidth * rScale, nImageHeight * rScale);
	m_pImageView.center = CGPointMake(ScreenWidth / 2, ScreenViewHeight/2);
	
	
	[self MakeZombie];

	m_pShakeMeView.alpha = 1.0f;
	
	[self performSelector:@selector(ShakeImageDisappear) withObject:nil afterDelay:2.0];

	m_nEyeKind = -1;
	m_nMouthKind = -1;
	
}
-(void) onShake:(id)sender
{
	
}
-(void) onShakeClick:(id)sender
{
}
-(void) onTheme:(id)sender
{
	UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:@"Themes" delegate:self 
											 cancelButtonTitle:nil 
										destructiveButtonTitle:nil 
											 otherButtonTitles:@"None", @"Tungsten", @"Sepia", @"Grayscale",@"Cancel", nil];
	sheet.destructiveButtonIndex = 4;
	[sheet showInView:self.view];
	[sheet release];
}
-(void) onSave:(id)sender
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	UIImage* pSourceImage;
	
	pSourceImage = pTempResult;
	
	UIImage* pFrameImage;
	pFrameImage = [UIImage imageNamed:@"frame.png"];
	
	CGColorSpaceRef colorSpace;
	CGImageRef ref;
	CGContextRef context;
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
		return;
	
	//croped Image generation
	context = CGBitmapContextCreate (NULL,
									 224,
									 224,
									 8,      
									 224*4,
									 colorSpace,
									 kCGImageAlphaPremultipliedLast);
	
	
	float nSourceImageWidth, nSourceImageHeight;
	nSourceImageWidth = pSourceImage.size.width;
	nSourceImageHeight = pSourceImage.size.height;
	
	float rScale;
	
	rScale = MAX((float)224 / nSourceImageWidth, (float)(224) / nSourceImageHeight);
	
	CGContextTranslateCTM(context, 112, 112);
	CGContextDrawImage(context, CGRectMake(- (nSourceImageWidth / 2) * rScale, -( nSourceImageHeight / 2) * rScale, nSourceImageWidth * rScale, nSourceImageHeight * rScale), [pSourceImage CGImage]);
	CGContextTranslateCTM(context, -112, -112);
	
	CGImageRef cropedRef =  CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);
	
	
	//Frame Image generation
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	int nSrcImageWidth, nSrcImageHeight;

	
	nSrcImageWidth = [pFrameImage size].width;
	nSrcImageHeight = [pFrameImage size].height;
	
	bitmapBytesPerRow   = (nSrcImageWidth * 4);
	bitmapByteCount   = (bitmapBytesPerRow * nSrcImageHeight);
	
	
	context = CGBitmapContextCreate (NULL,
												  nSrcImageWidth,
												  nSrcImageHeight,
												  8,      
												  bitmapBytesPerRow,
												  colorSpace,
												  kCGImageAlphaPremultipliedLast);
	
	
	CGContextDrawImage(context, CGRectMake(0, 0, nSrcImageWidth, nSrcImageHeight), [pFrameImage CGImage]);
	CGContextTranslateCTM(context,149, 160);
	
	CGContextDrawImage(context, CGRectMake(- 112, - 112, 224, 224), cropedRef);
	CGContextTranslateCTM(context, - 149, - 160);
	
	ref = CGBitmapContextCreateImage(context);
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGImageRelease(cropedRef);
	CGImageRelease(ref);
	CGContextRelease(context);
	

	//WaterMaked Image
	UIImage* pWarerMaking = [UIImage imageNamed:@"vampirizer-watermark.png"];
	pSourceImage = pTempResult;
	
	nSrcImageWidth = [pSourceImage size].width;
	nSrcImageHeight = [pSourceImage size].height;
	
	bitmapBytesPerRow   = (nSrcImageWidth * 4);
	bitmapByteCount   = (bitmapBytesPerRow * nSrcImageHeight);
	
	
	context = CGBitmapContextCreate (NULL,
									 nSrcImageWidth,
									 nSrcImageHeight,
									 8,      
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedLast);
	
	
	CGContextDrawImage(context, CGRectMake(0, 0, nSrcImageWidth, nSrcImageHeight), [pSourceImage CGImage]);

	rScale = (float)nSrcImageWidth / 320;
	
	
	CGContextDrawImage(context, CGRectMake(18 * rScale, 6 * rScale, 104 * rScale, 36 * rScale), [pWarerMaking CGImage]);
	
	
	ref = CGBitmapContextCreateImage(context);
	UIImage* pWatreMakedImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(ref);
	CGContextRelease(context);
	
	NSString* path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	Session* session = [[Session alloc] init];
	
	session.mResultImg = pWatreMakedImage;
	session.mThumbnailImg = newImage;
	
	[session saveResultImage:path];
	
	[session release];
	[newImage release];
	
	if (app.m_pProcessedImage)
	{
		[app.m_pProcessedImage release];
		app.m_pProcessedImage = nil;
	}
	app.m_pProcessedImage = pWatreMakedImage;
	
	[self.navigationController pushViewController:m_pMyClanManager animated:YES];
	m_pMyClanManager.m_nMode = Processed_Mode;
	
	[m_pMyClanManager Init];
	
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
//	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	
	if (buttonIndex != 4)
	{
		if (pTempResult)
		{
			[pTempResult release];
			pTempResult = nil;
		}
	}
	
	switch (buttonIndex)
	{
		case 0:
			pTempResult = [[UIImage alloc] initWithCGImage:[pTempOriginal CGImage]];
			break;
		case 1:
			pTempResult = Tangsten(pTempOriginal);
			break;
			
		case 2:
			pTempResult = Sepia(pTempOriginal);
			break;
			
		case 3:
			pTempResult = Grayscale(pTempOriginal);
			break;
		default:
			break;
	}
	m_pImageView.image = pTempResult;
}

- (BOOL)canBecomeFirstResponder 
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motion Began ============");
	if (event.type == (UIEventType)UIEventSubtypeMotionShake) 
	{
        NSLog(@"Make zombie by Motion");
		[self MakeZombie];
	}
    
    if ([super respondsToSelector:@selector(motionBegan:withEvent:)]) {
        [super motionBegan:motion withEvent:event];
    }
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motion cancel ============");
	if (event.type == (UIEventType)UIEventSubtypeMotionShake) 
	{
        [self MakeZombie];

	}
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motion end ============");
	if (event.type == (UIEventType)UIEventSubtypeMotionShake) 
	{
//        [self MakeZombie];
	}
}


-(void)animationView:(UIView*)view initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime
{
	[view setAlpha:sAlpha];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:rTime];
	[view setAlpha:eAlpha];
	[UIView commitAnimations];	
}

-(void) viewWillAppear:(BOOL)animated{
    [m_pShakeMeView becomeFirstResponder];
    [super viewWillAppear:animated];
}
-(void) viewWillDisappear:(BOOL)animated{
    [m_pShakeMeView resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(void) ShakeImageDisappear
{
	
	[self animationView:m_pShakeMeView initAlpha:1.0 endAlpha:0.0 animationtime:1.0];
}

-(void) onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
