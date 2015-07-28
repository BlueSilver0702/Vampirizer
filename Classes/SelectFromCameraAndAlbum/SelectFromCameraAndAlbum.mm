//
//  SelectFromCameraAndAlbum.mm
//  Vampirizer
//
//  Created by user on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectFromCameraAndAlbum.h"
#import "VampirizerAppDelegate.h"
#import "UIImage+Resize.h"

@implementation SelectFromCameraAndAlbum

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	UIImageView* pBackground;
	pBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pBackground.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:pBackground];
	[self.view addSubview:pBackground];
	[pBackground release];
	
	UIImageView* pOkOrNot;
	pOkOrNot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	pOkOrNot.image = [UIImage imageNamed:@"ok-not_ok.png"];
	[self.view addSubview:pOkOrNot];
	[self.view addSubview:pOkOrNot];
	[pOkOrNot release];
	
	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(15,438,71,32)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
	
	UIButton* pBtnNext = [[UIButton alloc] initWithFrame:CGRectMake(234,438,71,32)];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but-next-up.png"] forState:UIControlStateNormal];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but-next-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnNext addTarget:self action:@selector(onNext:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnNext];
	[pBtnNext release];
	
	
}

- (void) viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
}

-(void) onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void) onNext:(id)sender
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	if (app.m_fCapturedFromCamera == TRUE)
	{
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ==  false)
		{
			[imagePicker release];
			return;
		}
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
			
		UIImageView* cameraView;
		cameraView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		cameraView.image = [UIImage imageNamed:@"camera-guide.png"];
		imagePicker.cameraOverlayView = cameraView;
		[cameraView release];
			
		}
	else
	{
		imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.allowsEditing = YES;


	}
		
		
	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
	{
		[self presentModalViewController:imagePicker animated:YES];
	}
	else
	{
		if(m_popoverController != nil)
			[m_popoverController release];
	
		m_popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
		m_popoverController.delegate = self;
		[m_popoverController presentPopoverFromRect:CGRectMake(0, 0, 200, 800) 
											 inView:sender
						   permittedArrowDirections:UIPopoverArrowDirectionAny 
										   animated:YES];
	}
		
	[imagePicker release];	
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo 
{
	if(m_popoverController != nil) 
	{
		[m_popoverController dismissPopoverAnimated:YES];
		m_popoverController = nil;
	}
	else
	{
		[self dismissModalViewControllerAnimated:YES];
	}
	
	VampirizerAppDelegate* appDelegate = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
    int scale = [[UIScreen mainScreen] scale];
    appDelegate.m_pOrgImage = [selectedImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit
                                                    bounds:CGSizeMake(320*scale, 480*scale)
                                      interpolationQuality:kCGInterpolationHigh];
    
    
    NSLog( @"width = %d, height = %d, scale = %f, orientation = %d", (int)appDelegate.m_pOrgImage.size.width, (int)appDelegate.m_pOrgImage.size.height,  appDelegate.m_pOrgImage.scale, appDelegate.m_pOrgImage.imageOrientation);
//	//Image Size Changing
//	//	if (m_fCamera)
//	{
//		CGSize mySize = selectedImage.size;
//		
//		if (selectedImage.imageOrientation == UIImageOrientationLeft || selectedImage.imageOrientation == UIImageOrientationRight) 
//		{
//			int nTemp = mySize.width;
//			mySize.width = mySize.height;
//			mySize.height = nTemp;
//			
//			
//			UIImage* myimage = [self imageByScalingToSize:selectedImage size:mySize]; 
//			
//			appDelegate.m_pOrgImage = myimage;
//		}
//		else
//		{
//			appDelegate.m_pOrgImage = [[UIImage alloc] initWithCGImage:[selectedImage CGImage]];
//		}
//		
//	}

	[self.navigationController pushViewController:m_pEditViewController animated:YES];
	[m_pEditViewController Init];
//	//	[m_pFaceTaggingViewController InitScroll];
	
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		if(m_popoverController != nil) {
			[m_popoverController dismissPopoverAnimated:YES];
			m_popoverController = nil;
		}
	}
	else 
		[self dismissModalViewControllerAnimated:YES];
}





#define radians(a) ((a)*3.141592/180.0f)

-(UIImage*)imageByScalingToSize:(UIImage*) sourceImage size:(CGSize)targetSize
{
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGImageRef imageRef = [sourceImage CGImage];
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
	
	if (bitmapInfo == kCGImageAlphaNone) {
		bitmapInfo = kCGImageAlphaNoneSkipLast;
	}
	
	CGContextRef bitmap;
	
	if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
	} else {
		bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
	}       
	
	if (sourceImage.imageOrientation == UIImageOrientationLeft) {
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -targetHeight);
		
	} else if (sourceImage.imageOrientation == UIImageOrientationRight) {
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -targetWidth, 0);
		
	} else if (sourceImage.imageOrientation == UIImageOrientationUp) {
		// NOTHING
	} else if (sourceImage.imageOrientation == UIImageOrientationDown) {
		CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
		CGContextRotateCTM (bitmap, radians(-180.));
	}
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGImageRelease(ref);
	CGContextRelease(bitmap);
	
	return newImage; 
}


@end
