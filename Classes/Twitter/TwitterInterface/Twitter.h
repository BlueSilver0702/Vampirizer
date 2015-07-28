

#import <Foundation/Foundation.h>
#import "NSXMLDocument.h"
#import "TwitterLoginDialog.h"
#import "ASIFormDataRequest.h"

extern NSString * const CONSUMER_KEY;
extern NSString * const CONSUMER_SECRET;

enum {
	doLogin = 1,
	doMessaging = 2,
};

@protocol TwitterDelegate;

@interface Twitter : NSObject <TwitterLoginDialogDelegate>
{
	id<TwitterDelegate> delegate;
	

	NSString *userID;
	NSString *userPS;
	NSString *timestamp;
	
    int actionIndex;
    
	TwitterLoginDialog* m_pLoginDialog;
	

}
@property (nonatomic, assign) id<TwitterDelegate> delegate;
- (id)init;
- (void)Login:(NSString *)name Password:(NSString *)password;
- (void)Logout;
- (BOOL)isLogin;
- (void)twitMessage:(NSString *)message;
- (BOOL)twitMessageWithTwipic:(NSString *)message Image:(UIImage *)image;
//- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error;
- (void)TwitterLogin;


@end
#pragma mark method to call after response
@protocol TwitterDelegate <NSObject>
@optional
- (void)twloginDidSucceed;
- (void)twloginDidFailWithError;
- (void)twmessagingDidSucceed;
- (void)twmessagingDidFailWithError;
@end