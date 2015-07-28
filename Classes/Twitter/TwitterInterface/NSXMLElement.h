
#import <Foundation/Foundation.h>


@interface NSXMLElement : NSObject {
	NSString *Name;
	NSString *Value;
	NSDictionary *Attribute;
	NSXMLElement *Parent;
	NSMutableArray *Childs;
}

@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Value;
@property(nonatomic,retain)NSDictionary *Attribute;
@property(nonatomic,retain)NSXMLElement *Parent;
@property(nonatomic,retain)NSMutableArray *Childs;


- (NSXMLElement *)objectAtIndex:(NSInteger *)index;
- (NSXMLElement *)objectForKey:(NSString *)key;
- (NSMutableArray *)getChildrens:(NSString *)nodeName;
@end
