

#import <Foundation/Foundation.h>
#import "NSXMLElement.h"

@interface NSXMLDocument : NSObject<NSXMLParserDelegate> {
	NSXMLElement	*rootElement;
	NSMutableArray  *elementPath;
	
	NSString *parseURL;
}
@property(nonatomic,retain)NSXMLElement	*rootElement;
@property(nonatomic,retain)NSMutableArray  *elementPath;

- (id)initWithData:(NSData *)data;
- (id)initWithURLString:(NSString *)url;

@end
