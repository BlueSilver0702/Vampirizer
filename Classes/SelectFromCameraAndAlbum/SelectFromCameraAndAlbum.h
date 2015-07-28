//
//  SelectFromCameraAndAlbum.h
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface SelectFromCameraAndAlbum : UIViewController <UIPopoverControllerDelegate, UINavigationControllerDelegate,
													UIImagePickerControllerDelegate>
{
	UIPopoverController*	m_popoverController;
	IBOutlet EditViewController* m_pEditViewController;
}

-(void) onBack:(id)sender;
-(void) onNext:(id)sender;


-(UIImage*)imageByScalingToSize:(UIImage*) sourceImage size:(CGSize)targetSize;
@end
