//
//  LoadingBar.h
//  Vampirizer
//
//  Created by user on 11/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingBar : UIView 
{
	UIImageView* m_pLoadingPiece;
	NSTimer* m_pAnimationTimer;
	
	float m_rPercent;

	float m_rBarWidth;
	float m_rBarHeight;
	float m_rPieceHeight;
	float m_rPieceWidth;
	
	
}

-(void) startAnimation;
-(void) stopAnimation;
-(void) movingPiece:(id)sender;
-(void) setPiecePlace;



@end
