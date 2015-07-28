//
//  ImageSelectView.m
//  WakeMe
//
//  Created by OCH-Mac on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageSelectView.h"
#import "VampirizerAppDelegate.h"
#import "sessionMgr.h"
#define ROW_COUNT		2
#define IMAGE_WIDTH		130
#define IMAGE_HEIGHT	143
#define SCREEN_WIDTH			[[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT			[[UIScreen mainScreen] bounds].size.height
#define SCALE_SCREEN_WIDTH		(SCREEN_WIDTH / 320)
#define SCALE_SCREEN_HEIGHT		(SCREEN_HEIGHT / 480)



@implementation ImageSelectView

@synthesize delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
	if (self) 
	{
        // Initialization code.
		m_arrayButton = [[NSMutableArray alloc] init];
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) refresh
{
	for(UIButton* btn in m_arrayButton) 
	{
		[btn removeFromSuperview];
	}
	[m_arrayButton removeAllObjects];
	
	NSString* path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	Session* session = [[Session alloc] init];
	int nCount = [session getResultNum:path];
	CGRect rect = self.frame;
	const CGSize size = CGSizeMake(IMAGE_WIDTH * SCALE_SCREEN_WIDTH, IMAGE_HEIGHT * SCALE_SCREEN_WIDTH);
	rect.size.height = (size.height + 15) * ((nCount + 1) / ROW_COUNT);
	self.frame = rect;
	
	int i;
	for(i = 0; i < nCount; i++) 
	{
		int row = i / ROW_COUNT;
		int col = i % ROW_COUNT;
		UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
		
		float nOffset = 10;
		
		if (col == 0)
		{
			btn.frame = CGRectMake(SCREEN_WIDTH / 2 - IMAGE_WIDTH - nOffset, (size.height + 15) * row + 15, size.width, size.height);
		}
		else
		{
			btn.frame = CGRectMake(SCREEN_WIDTH / 2 + nOffset, (size.height + 15) * row + 15, size.width, size.height);
		}

	
		[btn addTarget:self action:@selector(actionBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
		
		UIImage* image = [session loadThumbnailImage:path index:i];

		[btn setBackgroundImage:image forState:UIControlStateNormal];
		[image release];
		

		
		[m_arrayButton addObject:btn];
	}
	[session release];
}

- (void)actionBtnSelect:(id)sender {
	NSUInteger i = 0;
	for(UIButton* btn in m_arrayButton) 
	{
		if(sender == btn) 
		{
			[delegate ReturnImageIndex:i];
			return;
		}
		i++;
	}
}

- (void)dealloc {
	[m_arrayButton removeAllObjects];
	[m_arrayButton release];
    [super dealloc];
}

@end
