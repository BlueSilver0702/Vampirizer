

#import "NSXMLDocument.h"


@implementation NSXMLDocument
@synthesize rootElement;
@synthesize elementPath;

- (id)initWithData:(NSData *)data {
	self = [super init];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
	[xmlParser setDelegate:self];
	[xmlParser parse];
	
	[xmlParser release];
	
	return self;
}

- (id)initWithURLString:(NSString *)url {
	self = [super init];
	parseURL = [[NSString alloc] initWithString:url];
	NSURL *nsUrl = [NSURL URLWithString:[parseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:nsUrl];

	[xmlParser setDelegate:self];
	[xmlParser parse];
	
	[xmlParser release];
	
	return self;
}
- (void)dealloc {
	[rootElement release];
	[elementPath release];
	[parseURL release];
	[super dealloc];
}

#pragma mark -
#pragma mark NSXMLParser delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (rootElement == nil) {
		
		rootElement = [[NSXMLElement alloc]init];
		
		[rootElement setName:elementName];
		[rootElement setAttribute:attributeDict];
		
		rootElement.Childs = [[NSMutableArray alloc]init];
		
		if (elementPath==nil) {
			elementPath = [[NSMutableArray alloc]init];
		}
		
		[elementPath addObject:rootElement];
	}
	else {
		NSXMLElement *thisElement = [[NSXMLElement alloc]init];
		[thisElement setName:elementName];
		[thisElement setAttribute:attributeDict];
		NSXMLElement *parentElement = (NSXMLElement *)[elementPath objectAtIndex:[elementPath count]-1];
		[thisElement setParent:parentElement];
		if (parentElement.Childs == nil) {
			parentElement.Childs = [[NSMutableArray alloc]init];
		}
		[parentElement.Childs addObject:thisElement];
		[elementPath addObject:thisElement];
		[thisElement release];
	}
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSXMLElement *nowElement = (NSXMLElement *)[elementPath objectAtIndex:[elementPath count]-1];
	if (string != nil) {
		
		NSString *bString;
		if ([nowElement Value] != nil) {
			bString = [[NSString alloc] initWithFormat:@"%@%@",[nowElement Value],
					   [string stringByTrimmingCharactersInSet:
						[NSCharacterSet whitespaceAndNewlineCharacterSet]]
					   ];

		}else {
			bString = [[NSString alloc] initWithFormat:@"%@",
					   [string stringByTrimmingCharactersInSet:
						[NSCharacterSet whitespaceAndNewlineCharacterSet]]
					   ];
		}
		[nowElement setValue:bString];
		
		[bString release];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {								  
	[elementPath removeLastObject];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	NSLog(@"parseError - %d",[parseError code]);
}
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
	NSLog(@"validationError - %d",[validationError code]);
}

@end
