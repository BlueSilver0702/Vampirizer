//
//  helpViewController.h
//  Vampirizer
//
//  Created by user on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class selectPhotoViewController;
@interface helpViewController : UIViewController 
{
	selectPhotoViewController* m_pPareantController;

}

@property(nonatomic, assign) 	selectPhotoViewController* m_pPareantController;

-(void) onBack:(id)sender;

@end
