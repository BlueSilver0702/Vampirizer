//
//  Twitter.m
//  
//
//  Created by Ki-Seok Kim. on 10. 11. 18..
//  Copyright 2010 Ki-Seok Kim. All rights reserved.
//

#import "Twitter.h"

#import "CustomAlertView.h"
#import "VampirizerAppDelegate.h"

NSString * const CONSUMER_KEY = @"ItSX1YYAQaJWxX7cZUGtLg";
NSString * const CONSUMER_SECRET = @"WxZXmPPeYtkBBKpKza1YAEc92YAuQiyN6XRizCNcQQ";


@implementation Twitter
@synthesize delegate;
- (id)init
{
	self = [super init];
//	twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
//	[twitterEngine setUsesSecureConnection:NO];
//	[twitterEngine setConsumerKey:CONSUMER_KEY
//						   secret:CONSUMER_SECRET];
//		
//
//	twToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:@"twittertoken" prefix:@"token"];
//
//	if (twToken!=nil) 
//	{
//		[twitterEngine setAccessToken:twToken];
//	}
	
	return self;
}
- (void)dealloc {
	[super dealloc];
//	[twitterEngine release];
//	[twToken release];
	
	if (m_pLoginDialog)
	{
		[m_pLoginDialog release];
	}
}
#pragma mark -
#pragma mark actions
- (void)TwitterLogin
{
	if (m_pLoginDialog)
	{
		[m_pLoginDialog release];
	}
	
	m_pLoginDialog = [[TwitterLoginDialog alloc] init];
	m_pLoginDialog.delegate = self;
	[m_pLoginDialog show];
	
	
	
}

- (void)Login:(NSString *)name Password:(NSString *)password
{
	actionIndex = doLogin;
	userID = [name retain];
	userPS = [password retain];


    NSURL *twitpicURL = [NSURL URLWithString:@"http://twitpic.com/api/uploadAndPost"];
	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:twitpicURL] autorelease];
	[request setPostValue:name forKey:@"username"];
	[request setPostValue:password forKey:@"password"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	[request startAsynchronous];
    
    
}
- (void)Logout 
{

    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    [database removeObjectForKey:@"twitter_username"];
    [database removeObjectForKey:@"twitter_password"];
    [database synchronize];


}
- (BOOL)isLogin 
{
//	
//	if (twToken==nil) {
//		twToken = [[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:@"twittertoken" prefix:@"token"];
//	}
//	
//	return twToken==nil ? NO : YES;

    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    NSString* username = [database objectForKey:@"twitter_username"];
    NSString* pass = [database objectForKey:@"twitter_password"];
    
    if (username == nil && pass == nil) {
        return NO;
    }
    
    return YES;
    
}
- (void)twitMessage:(NSString *)message
{
	actionIndex = doMessaging;
//	[twitterEngine sendUpdate:message];
}

- (void)setPostBody:(NSMutableData *)postBody Value:(NSString *)value ForKey:(NSString *)key {
	NSString *stringBoundary = @"--XdseFs3S12DfG3";
	
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	
}
- (BOOL)twitMessageWithTwipic:(NSString *)message Image:(UIImage *)image 
{

	NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"];
	NSString* password = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_password"];
	
    NSLog(@"username = %@  password = %@", username, password);
    
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
	NSURL *twitpicURL = [NSURL URLWithString:@"http://twitpic.com/api/uploadAndPost"];
	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:twitpicURL] autorelease];
    [request setUseSessionPersistence:NO];
    [request setUseKeychainPersistence:NO];
    [request setUseCookiePersistence:NO];
    [request setShouldAttemptPersistentConnection:NO];
	[request setData:data forKey:@"media"];
	[request setPostValue:username forKey:@"username"];
	[request setPostValue:password forKey:@"password"];
	[request setPostValue:message forKey:@"message"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	[request startAsynchronous];
    
    actionIndex = doMessaging;
    
    return YES;
}


- (void)requestDone:(ASIFormDataRequest*)request 
{
    if (actionIndex == doLogin)
    {
        NSString *response = [request responseString];
//        [activity stopAnimating];
        //	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if ([response rangeOfString:@"Invalid twitter username or password"].location != NSNotFound) 
        {
/*            UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
                                                         message:NSLocalizedString(@"Invalid twitter username or password." ,@"")
                                                        delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
            [msg show];
            [msg release];
*/         
            CustomAlertView* alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [alert setTitleText:@"Information" : @"Invalid twitter username or password."];
            
            VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
            [app.window addSubview:alert];
            [alert release];

            
            [m_pLoginDialog stopAnimation];
            
            return;
        }
        //login success
        int statuscode = [request responseStatusCode];
        NSLog(@"staus = %d \n%@", statuscode, response);
        
        NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
        [database setObject:userID forKey:@"twitter_username"];
        [database setObject:userPS forKey:@"twitter_password"];
        [database synchronize];
        
        //    if (delegate && [delegate respondsToSelector:@selector(didLogIn:)]) {
        //        [delegate didLogIn:self];
        //    }
        [delegate twloginDidSucceed];
        [m_pLoginDialog dismiss:YES];

    }
    else
    {
        [delegate twmessagingDidSucceed];
    }
}

- (void)requestFailed:(ASIFormDataRequest*)request 
{
	if (actionIndex == doLogin)
    {
        NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
        [database removeObjectForKey:@"twitter_username"];
        [database removeObjectForKey:@"twitter_password"];
        [database synchronize];
        
        //	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        [delegate twloginDidFailWithError];
/*        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil 
                                                        message:@"Can't login Twitter" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
*/
        CustomAlertView* alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [alert setTitleText:@"" : @"Can't login Twitter"];
        
        VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
        [app.window addSubview:alert];
        [alert release];

        
        [m_pLoginDialog stopAnimation];
        
    }
    else
    {
        [delegate twmessagingDidFailWithError];
    }
}


#pragma mark delegate
-(void) SetUserName:(NSString *) szUserName Password:(NSString* ) szPassword
{
	[self Login:szUserName Password:szPassword];
}

@end
