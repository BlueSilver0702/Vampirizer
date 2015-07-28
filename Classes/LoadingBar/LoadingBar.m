//
//  LoadingBar.m
//  Vampirizer
//
//  Created by user on 11/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadingBar.h"


@implementation LoadingBar


- (id)initWithFrame:(CGRect)frame 
{
    
    self = [super initWithFrame:frame];
	
	float rScale;
	
    if (self) 
	{
		m_rPercent = 0;
		UIImage* pLoadingPieceImage = [UIImage imageNamed:@"loading_piece.png"];
		
		m_rBarWidth = frame.size.width;
		m_rBarHeight = frame.size.height;
		
		m_rPieceHeight = pLoadingPieceImage.size.height;
		m_rPieceWidth = pLoadingPieceImage.size.width;
		
		rScale = m_rPieceHeight / m_rBarHeight;
		
		m_rPieceHeight /= rScale;
		m_rPieceWidth /= rScale;
		
		m_pLoadingPiece = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_rPieceWidth, m_rPieceHeight)];
		m_pLoadingPiece.image = pLoadingPieceImage;
		
		[self addSubview:m_pLoadingPiece];
		[self setPiecePlace];
		
		self.clipsToBounds = YES;
//		[self setHidden:YES];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc 
{
    [super dealloc];
	[m_pLoadingPiece release];
}

-(void) startAnimation
{
	m_pAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(movingPiece:) userInfo:nil repeats:YES];
//	[self setHidden:NO];

}
-(void) stopAnimation
{
	[m_pAnimationTimer invalidate];
	m_pAnimationTimer = nil;
//	[self setHidden:YES];

}
-(void) movingPiece:(id)sender
{
	m_rPercent += 0.02;
	if (m_rPercent > 1.0)
	{
		m_rPercent = 0;
	}
	[self setPiecePlace];
}

-(void) setPiecePlace
{
	float rPosX;
	rPosX = (m_rBarWidth + 2 * m_rPieceWidth) * m_rPercent -  (m_rPieceWidth * 1.5);
	
	m_pLoadingPiece.frame = CGRectMake(rPosX, 0, m_rPieceWidth, m_rPieceHeight);
	
}

@end
