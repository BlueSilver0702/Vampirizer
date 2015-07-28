//
//  StartViewController.h
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "selectPhotoViewController.h"

@interface StartViewController : UIViewController 
{
	IBOutlet selectPhotoViewController* m_pSelectViewController;
	
	
	
}
-(void) onStart:(id)sender;

@end
