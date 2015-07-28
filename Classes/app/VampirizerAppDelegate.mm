//
//  VampirizerAppDelegate.m
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VampirizerAppDelegate.h"

#import "SendMessage.h"
#import "TwitterLoginDialog.h"
#import "Config.h"
#import "SImage.h"

#import "ShareDialog.h"

#define FB_APP_ID @"296757910346369"
#define FB_API_KEY @"3269fff9ef3b6fc13255e670ebb44c4d"
#define FB_APP_SECRET @"dc6da1a9a7bd35027f2f48649f067415"



@implementation VampirizerAppDelegate

@synthesize window;
@synthesize m_pStartViewController;
@synthesize m_pOrgImage, m_pProcessedImage;
@synthesize m_fCapturedFromCamera;
@synthesize m_pSelectPhotoController, m_pSelectFromCameraAndAlbum;
@synthesize m_pMyClanManager;
@synthesize m_pShareSetting;
@synthesize m_fFromUpLoad;
@synthesize facebook;
@synthesize m_szTwitUserName;
@synthesize m_szTwitPass;
@synthesize m_fTwitterSigned;
@synthesize m_rMouthWidth, m_rMouthHeight ,m_rMouthAngle;

@synthesize  m_pTwitterEngine;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
	[self.window addSubview:m_pMainNavigationController.view];
    

	
	_permissions = [NSArray arrayWithObjects:@"publish_stream",nil];
    
    facebook = [[Facebook alloc] init];
	
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSDate *exp = [[NSUserDefaults standardUserDefaults] objectForKey:@"exp_date"];
    
    if (token != nil && exp != nil && [token length] > 2)
	{
		//        isLoggedIn = YES;
        facebook.accessToken = token;
        facebook.expirationDate = [NSDate distantFuture];
    }
	
	m_fTwitterSigned = FALSE;
	
	m_pTwitterEngine = [[Twitter alloc] init];
	m_pTwitterEngine.delegate = self;
    
    m_pLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    m_pLogo.image = [UIImage imageNamed:@"Default.png"];
    
    [self.window addSubview:m_pLogo];
    [self performSelector:@selector(removeLogo) withObject:nil afterDelay:2.0f];

	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc
{
    [window release];
    [super dealloc];
	[facebook release];
	[m_pTwitterEngine release];
}

-(UIImage *)CropImage:(UIImage*) pSourceImage x:(int) nX y:(int) nY width:(int) nWidth height:(int) nHeight
{
	CGColorSpaceRef colorSpace;
	
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	size_t pixelsWidth, pixelsHight;
	
	pixelsWidth = nWidth;
	pixelsHight = nHeight;
	
	bitmapBytesPerRow   = (pixelsWidth * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHight);
	
	int nSrcImageWidth, nSrcImageHeight;
	
	nSrcImageWidth = [pSourceImage size].width;
	nSrcImageHeight = [pSourceImage size].height;
	
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
		return NULL;
	
	CGContextRef context = CGBitmapContextCreate (NULL,
												  pixelsWidth,
												  pixelsHight,
												  8,      
												  bitmapBytesPerRow,
												  colorSpace,
												  kCGImageAlphaPremultipliedLast);
	
	
	
	CGContextTranslateCTM(context, -nX , -(nSrcImageHeight - (nY + nHeight)));
	CGContextDrawImage(context, CGRectMake(0, 0, nSrcImageWidth, nSrcImageHeight), [pSourceImage CGImage]);
	
	CGImageRef ref = CGBitmapContextCreateImage(context);
	
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(ref);
	CGContextRelease(context);
	
	return newImage;
	
}

-(void) ProcessView:(UIImageView*) bloodView rect:(CGRect) backgroudRect percent:(float) rPercent
{
	float backgroudRectX, backgroudRectY, backgroudRectWidth, backgroudRectHeight;
	backgroudRectX = backgroudRect.origin.x;
	backgroudRectY = backgroudRect.origin.y;
	backgroudRectWidth = backgroudRect.size.width;
	backgroudRectHeight = backgroudRect.size.height;
	
	UIImage* bloodImage = [UIImage imageNamed:@"loading-blood.png"];
	
	float rScaleX, rScaleY;
	float bloodWith, bloodImageWidth, bloodImageHeight;
	
	rScaleX = backgroudRectWidth / 479;
	rScaleY = backgroudRectHeight / 199;
	if (rPercent > 1.0)
	{
		rPercent = 1.0;
	}
	bloodWith = 325 * rPercent + 52;
	bloodImageWidth = bloodImage.size.width;
	bloodImageHeight = bloodImage.size.height;
	
	
	UIImage* cropedImage = [self CropImage:bloodImage x:bloodImageWidth - bloodWith y:0 width:bloodWith height:bloodImageHeight];
	
	bloodView.image = cropedImage;
	[cropedImage release];
	
	bloodView.frame = CGRectMake(backgroudRectX + 76 * rScaleX, backgroudRectY + 10 * rScaleY, bloodWith * rScaleX, bloodImageHeight * rScaleY);
	
	
	return;
}

-(CGRect) GetViewRect:(CGRect) backgroudRect
{
	float backgroudRectX, backgroudRectY, backgroudRectWidth, backgroudRectHeight;
	backgroudRectX = backgroudRect.origin.x;
	backgroudRectY = backgroudRect.origin.y;
	backgroudRectWidth = backgroudRect.size.width;
	backgroudRectHeight = backgroudRect.size.height;
	
	float rScaleX, rScaleY;
	
	rScaleX = backgroudRectWidth / 479;
	rScaleY = backgroudRectHeight / 199;

	return 	 CGRectMake(backgroudRectX + 76 * rScaleX, backgroudRectY + 10 * rScaleY, 328 * rScaleX, 65 * rScaleY);
	
}


-(void) SetFaceTaggingRect:(int) nIndex rect:(CGRect) rect
{
	m_pFaceTaggingRect[nIndex] = rect;
}
-(CGRect) GetFaceTaggingRect:(int) nIndex
{
	return m_pFaceTaggingRect[nIndex];
}

-(void) SetScale:(float) rScale
{
	m_rScale = rScale;
}
-(float) GetScale
{
	return m_rScale;
}

#pragma mark FaceBook

- (void)    FacebookLogin
{
    NSArray * szPermissions = [NSArray arrayWithObjects:
							   @"publish_stream",
							   nil];
    [facebook authorize:FB_APP_ID permissions:szPermissions delegate:self];	
    //    [facebook authorize:FB_APP_ID permissions:permissions delegate:self];
}

- (void)    FacebookLogOut
{
    [facebook logout:self];
    [m_pMyClanManager dismissModalViewControllerAnimated:YES];
}

- (void)    UploadPhotoToFacebook:(NSString*)szMessage
{
    [m_pMyClanManager dismissModalViewControllerAnimated:YES];

    UIImage* UploadImage;
    
	int nImageWidth,nImageHeight;
	
	
	nImageHeight = m_pProcessedImage.size.height;
	nImageWidth = m_pProcessedImage.size.width;
	
	float rScale = MIN(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
	
	UploadImage = ScaleUIImage(m_pProcessedImage, rScale);
	
	
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    NSString* graphPath = @"me/photos";
    [params setObject:UploadImage forKey:@"source"];
    [params setObject:szMessage forKey:@"message"];
    [facebook requestWithGraphPath:graphPath andParams:params andHttpMethod:@"POST" andDelegate:self];
	[UploadImage release];
    
    //gold
    [m_pMyClanManager BloodProcessing:0];

}

#pragma mark FaceBookDelegate Method

-(void)fbDidLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:facebook.accessToken forKey:@"access_token"];
	[[NSUserDefaults standardUserDefaults] setObject:facebook.expirationDate forKey:@"exp_date"];
	[[NSUserDefaults standardUserDefaults] synchronize];
//    [self ShowSenMessageView];
	
	if (m_fFromUpLoad)
	{
		[m_pMyClanManager SendMessage:MessageFaceBook];
	}
	else
	{
		[m_pShareSetting SetFacebookSign:TRUE];
	}

	
}

-(void)fbDidLogout
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"access_token"];
	[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"exp_date"];
	[[NSUserDefaults standardUserDefaults] synchronize];

	if (!m_fFromUpLoad)
	{
		[m_pShareSetting SetFacebookSign:FALSE];
	}
	
	
}

-(void)fbDidNotLogin:(BOOL)cancelled
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"access_token"];
	[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"exp_date"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	if (m_fFromUpLoad) 
	{
		//[m_pMyClanManager ShowLastOneThink:YES];
	}
    
    ShareDialog *dlg = [[ShareDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

    [self.window addSubview:dlg];
    [self.window bringSubviewToFront:dlg];
    
    [dlg release];
	
}

#pragma mark FBRequestDelegate
-(void) request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"ResponseFailed: %@", error);
	
	[m_pMyClanManager ShowOhNo:YES];
	//	if ([self.delegate respondsToSelector:@selector(failedToPublishPost:)])
	//		[self.delegate failedToPublishPost:self];    
}

-(void)request:(FBRequest *)request didLoad:(id)result
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"Parsed Response: %@", result);
	
	[m_pMyClanManager SharingComplete];
	
}

-(void)request:(FBRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    //    if(m_fIsUploadingFB == NO)
    //        return;
    //    m_pProgressView.hidden = NO;
    CGFloat rProgress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
	[m_pMyClanManager BloodProcessing:rProgress];
    NSLog(@"%d bytes out of %d sent.", totalBytesWritten, totalBytesExpectedToWrite);
}

-(void) ShowSetting
{
	[m_pSelectPhotoController onSetting:nil];
}

-(void) TwitterLogIn
{
//	[m_pSelectPhotoController TwitterLogIn];
	
	[m_pTwitterEngine TwitterLogin];

	
}

-(void) TwitterLogOut
{
	[m_pTwitterEngine Logout];
	if (!m_fFromUpLoad)
	{
		[m_pShareSetting SetTwitterSign];
	}
}
-(void) UploadPhotoToTwitter:(NSString*)szMessage
{
	UIImage* pImageToUpload;
	
	[m_pMyClanManager StartLoding];
	
	int nImageWidth,nImageHeight;
	

	nImageHeight = m_pProcessedImage.size.height;
	nImageWidth = m_pProcessedImage.size.width;
	
	float rScale = MIN(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
	
	pImageToUpload = ScaleUIImage(m_pProcessedImage, rScale);
	
	[m_pTwitterEngine twitMessageWithTwipic:szMessage Image:pImageToUpload];
	[pImageToUpload release];
	
    //gold
    [m_pMyClanManager BloodProcessing:0];
    
    curValue = 0.0f;
    maxValue = (((float)rand()) / RAND_MAX) / 3.0f + 0.5f;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerCallback:) userInfo:nil repeats:YES];
    
}

- (void)timerCallback:(id)sender {
    
    if (curValue >= maxValue) {
        
        [timer invalidate];
        timer = nil;
        return;
    }
    
    curValue += 0.03;
    [m_pMyClanManager BloodProcessing:curValue];

}

-(void) ConnectTwitter
{
	m_fTwitterSigned = TRUE;
//	if (m_fFromUpLoad)
//	{
//		[m_pMyClanManager SendMessage:MessageTwitter];
//	}
//	else
//	{
//		[m_pShareSetting SetTwitterSign];
//	}
	
//	[m_pTwitterEngine Login:m_szTwitUserName Password:m_szTwitPass];
	
}

#pragma mark TwitterDelegate
- (void)twloginDidSucceed
{
	if (!m_fFromUpLoad)
	{
		[m_pShareSetting SetTwitterSign];
	}
	else
	{
		[m_pMyClanManager SendMessage:MessageTwitter];
	}
}
- (void)twloginDidFailWithError
{
	if (!m_fFromUpLoad)
	{
		[m_pShareSetting SetTwitterSign];
	}
	else
	{
		//[m_pMyClanManager ShowLastOneThink:YES];
	}

}
- (void)twmessagingDidSucceed
{
	[m_pMyClanManager CompleteLoading];
}
- (void)twmessagingDidFailWithError
{
	[m_pMyClanManager StopLoading];
}

-(void) removeLogo
{
    [m_pLogo removeFromSuperview];
    [m_pLogo release];
}
@end
