//
//  EditViewController.h
//  Vampirizer
//
//  Created by user on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeZombieViewController.h"

@interface EditViewController : UIViewController 
{
	IBOutlet MakeZombieViewController* m_pMakeZombieController;
	
	
	UIImageView* m_pOriginalImageView;
	UIImageView* m_pBackImageView;
	UIImageView* m_pBloodFrame;
	UIImageView* m_pBloodLabel;
	UIImageView* m_pBloodView;
	
	
	//Blood Processing
	NSTimer* m_pBloodTimer;
	float m_rBloodPercent;
	
	//controll moving
	UIImageView* m_pFaceTagging[4];

	//Zooming factors
	float m_rFirstCenterX;
	float m_rFirstCenterY;
	float m_rFirstWidth;
	float m_rFirstHeight;
	float m_rInitDistance;
	
	float m_rFirstTouchX;
	float m_rFirstTouchY;
	
	float m_fFirstAngle;
	float m_fMouthAngle;
	
	float m_rMouthWidth;
	float m_rMouthHeight;
	
	float m_fChinAngle;
	
	float m_fVertical;
	
	bool m_fMultiTouched;
	bool m_fSingleTouched;
	
	int m_nSelectedIndex;
	
}
-(void) Init;

-(void) ProcessBlood:(id)sender;
-(void) GetSelectedIndex;

-(void) onBack:(id)sender;
-(void) onVampiraze:(id)sender;
-(void) ShowBloodControl:(bool) fShow;
-(void) SetTaggingPoint;
-(void) SetDefault;


@end
