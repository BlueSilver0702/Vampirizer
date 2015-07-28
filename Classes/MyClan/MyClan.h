//
//  MyClan.h
//  Vampirizer
//
//  Created by user on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSelectView.h"
#import "MyClanManager.h"

@interface MyClan : UIViewController <ImageSelectDelegate>
{
	IBOutlet MyClanManager* m_pMyClanManager;
	
	
	ImageSelectView* m_pImageSelection;
	UIScrollView* m_pScrollView;
	
    UIActivityIndicatorView *ActivityIndicator;
	
}
-(void) Init;
-(void) onBack:(id)sender;
-(void) refresh;

@end
