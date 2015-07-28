

#import "NSXMLElement.h"


@implementation NSXMLElement
@synthesize Name;
@synthesize Value;
@synthesize Attribute;
@synthesize Parent;
@synthesize Childs;

- (void)dealloc {
	[Name release];
	[Value release];
	[Attribute release];
	[Parent release];
	[Childs release];
	[super dealloc];
}

#pragma mark -
#pragma mark 데이터 어레이 넘기기

- (NSMutableArray *)getChildrens:(NSString *)nodeName {
	NSMutableArray *myChildrens = [[[NSMutableArray alloc]init] autorelease];
	for(NSXMLElement *child in Childs)
	{
		
		if ([nodeName isEqualToString:[child Name]]) {		
			[myChildrens addObject:child];
		}
	}
	return myChildrens;
}
 
#pragma mark -
#pragma mark 검색 관련

- (NSXMLElement *)objectAtIndex:(NSInteger *)index {
	if ([Childs count] <= (NSUInteger)index) {
		return nil;
	}
	NSXMLElement *resultElement = (NSXMLElement *)[Childs objectAtIndex:(int)index];
	return resultElement;
}
- (NSXMLElement *)objectForKey:(NSString *)key {
	for (NSXMLElement *element in Childs) {
		//NSLog(@"name = %@, key = %@",[element Name],key);
		if ([[element Name] isEqualToString:key]) {
			return element;
		}
	}
	return nil;
}


@end
