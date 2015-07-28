//
//  EditViewController.mm
//  Vampirizer
//
//  Created by user on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "VampirizerAppDelegate.h"

#import "Config.h"

@implementation EditViewController

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

// Image Tagging Controlls
	m_pOriginalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:m_pOriginalImageView];
	[m_pOriginalImageView release];
	
	UIImageView* pTopView;
	pTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	pTopView.image = [UIImage imageNamed:@"top-bar.png"];
	[self.view addSubview:pTopView];
	[pTopView release];

	UIImageView* pTipView;
	pTipView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
	pTipView.image = [UIImage imageNamed:@"tip-text.png"];
	[self.view addSubview:pTipView];
	[pTipView release];
	
	
	
	UIImageView* pBottomBar;
	pBottomBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 432, 320, 48)];
	pBottomBar.image = [UIImage imageNamed:@"bottom-bar.png"];
	[self.view addSubview:pBottomBar];
	[self.view addSubview:pBottomBar];
	[pBottomBar release];
	
	UIButton* pBtnBack = [[UIButton alloc] initWithFrame:CGRectMake(17,438,69,31)];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-up.png"] forState:UIControlStateNormal];
	[pBtnBack setBackgroundImage:[UIImage imageNamed:@"but-back-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnBack addTarget:self action:@selector(onBack:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnBack];
	[pBtnBack release];
	
	
	UIButton* pBtnNext = [[UIButton alloc] initWithFrame:CGRectMake(202,438,105,31)];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but-vampirizer-up.png"] forState:UIControlStateNormal];
	[pBtnNext setBackgroundImage:[UIImage imageNamed:@"but-vampirizer-click.png"] forState:UIControlStateHighlighted];
	
	[pBtnNext addTarget:self action:@selector(onVampiraze:) forControlEvents: UIControlEventTouchUpInside];
	[self.view addSubview:pBtnNext];
	[pBtnNext release];
	
	
	m_pFaceTagging[0] = [[UIImageView alloc] initWithFrame:CGRectMake(100, 174, 23, 23)];
	m_pFaceTagging[0].image = [UIImage imageNamed:@"guide-eye.png"];
	[self.view addSubview:m_pFaceTagging[0]];
	[m_pFaceTagging[0] release];	
	
	m_pFaceTagging[1] = [[UIImageView alloc] initWithFrame:CGRectMake(207, 174, 23, 23)];
	m_pFaceTagging[1].image = [UIImage imageNamed:@"guide-eye.png"];
	[self.view addSubview:m_pFaceTagging[1]];
	[m_pFaceTagging[1] release];	
	
	m_pFaceTagging[2] = [[UIImageView alloc] initWithFrame:CGRectMake(115, 283, 95, 32)];
	m_pFaceTagging[2].image = [UIImage imageNamed:@"guide-mouth.png"];
	[self.view addSubview:m_pFaceTagging[2]];
	[m_pFaceTagging[2] release];	
	
	m_pFaceTagging[3] = [[UIImageView alloc] initWithFrame:CGRectMake(83, 328, 155, 50)];
	m_pFaceTagging[3].image = [UIImage imageNamed:@"guide-chin.png"];
	[self.view addSubview:m_pFaceTagging[3]];
	[m_pFaceTagging[3] release];	
	

//Blood Processing Controller	
	m_pBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	m_pBackImageView.image = [UIImage imageNamed:@"darkbg.png"];
	[self.view addSubview:m_pBackImageView];

	[m_pBackImageView release];
	
	m_pBloodView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[self.view addSubview:m_pBloodView];
	[m_pBloodView release];
	
	m_pBloodFrame = [[UIImageView alloc] initWithFrame:CGRectMake(41, 181, 244, 101)];
	m_pBloodFrame.image = [UIImage imageNamed:@"loading-vial.png"];
	[self.view addSubview:m_pBloodFrame];
	[m_pBloodFrame release];	
	
	m_pBloodLabel = [[UIImageView alloc] initWithFrame:CGRectMake(104, 264, 123, 44)];
	m_pBloodLabel.image = [UIImage imageNamed:@"ImageLoading.png"];
	[self.view addSubview:m_pBloodLabel];
	[m_pBloodLabel release];
	
	[self Init];
	
	[self.view setMultipleTouchEnabled:YES];
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(void) Init
{
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	float rBloodTimerInterval = 0.05;
	m_pBloodTimer = [NSTimer scheduledTimerWithTimeInterval:rBloodTimerInterval target:self selector:@selector(ProcessBlood:) userInfo:nil repeats:YES];
	[self ShowBloodControl:YES];
	
	m_rBloodPercent = 0;
	
	m_nSelectedIndex = -1;
	
	int nImageWidth,nImageHeight;
	
	m_pOriginalImageView.image = app.m_pOrgImage;

	nImageHeight = app.m_pOrgImage.size.height;
	nImageWidth = app.m_pOrgImage.size.width;
	
	
	
	float rScale = MAX(ScreenViewHeight / nImageHeight, ScreenWidth / nImageWidth);
	[app SetScale:rScale];
	m_pOriginalImageView.frame = CGRectMake(0, 0, nImageWidth * rScale, nImageHeight * rScale);
	
	
	m_pOriginalImageView.center = CGPointMake(ScreenWidth / 2, ScreenViewHeight/2);
	
	[self SetDefault];
	
}

-(void) ProcessBlood:(id)sender
{
	m_rBloodPercent += 0.01;
	
	if (m_rBloodPercent > 1.2)
	{
		[m_pBloodTimer invalidate];
		m_pBloodTimer = nil;
		
		[self ShowBloodControl:NO];
		
	}
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	[app ProcessView:m_pBloodView rect:m_pBloodFrame.frame percent:m_rBloodPercent];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	NSSet* allTouch = [event touchesForView:self.view];
	CGPoint point;
	
	if ([allTouch count] == 2)
	{
		
		NSArray *twoTouch = [allTouch allObjects];
		UITouch *tOne = [twoTouch objectAtIndex:0];
		UITouch *tTwo = [twoTouch objectAtIndex:1];
		
		CGPoint firstPoint = [tOne locationInView:[tOne view]];
		CGPoint secondPoint = [tTwo locationInView:[tTwo view]];
		
		point.x = (firstPoint.x + secondPoint.x) / 2;
		point.y = (firstPoint.y + secondPoint.y) / 2;
		
		float nDeltaX, nDeltaY;
		nDeltaX = secondPoint.x - firstPoint.x;
		nDeltaY = secondPoint.y - firstPoint.y;
		
		m_rInitDistance = sqrt(pow(nDeltaX, 2.0f) + pow(nDeltaY, 2.0f));
		m_fMultiTouched = true;
		m_fSingleTouched = false;
		
		m_rFirstTouchX = point.x;
		m_rFirstTouchY = point.y;
		
		[self GetSelectedIndex];
		
		
		if (m_nSelectedIndex >= 2)
		{
			m_fFirstAngle = atan2(nDeltaY, nDeltaX);
		}
		if (m_nSelectedIndex == 2)
		{
			float touchAngle = m_fFirstAngle;
			
			if (touchAngle < 0) 
			{
				touchAngle += M_PI * 2;
			}
			
			if (((touchAngle > M_PI * 5 / 4)&&(touchAngle > M_PI * 7 / 4)) || ((touchAngle > M_PI * 3 / 4)&&(touchAngle > M_PI / 4)))
			{
				m_fVertical = true;
			}
			else
			{
				m_fVertical = false;
			}

		}
		
	}
	else
	{
		UITouch *touch = [allTouch anyObject];
		CGPoint touchPoint= [touch locationInView:self.view];	
		m_rFirstTouchX = touchPoint.x;
		m_rFirstTouchY = touchPoint.y;
		m_fSingleTouched = true;
		m_fMultiTouched = false;
		
		[self GetSelectedIndex];
	}
	
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (m_nSelectedIndex == -1)
	{
		return;
	}
	
	NSSet* allTouch = [event touchesForView:self.view];
	if ([allTouch count] == 2)
	{
		if(m_fMultiTouched)
		{
			NSArray *twoTouch = [allTouch allObjects];
			UITouch *tOne = [twoTouch objectAtIndex:0];
			UITouch *tTwo = [twoTouch objectAtIndex:1];
			
			CGPoint firstPoint = [tOne locationInView:[tOne view]];
			CGPoint secondPoint = [tTwo locationInView:[tTwo view]];
			
			float nCenterX, nCenterY;
			
			nCenterX = (firstPoint.x + secondPoint.x) / 2;
			nCenterY = (firstPoint.y + secondPoint.y) / 2;
			
			float nDeltaX, nDeltaY;
			nDeltaX = secondPoint.x - firstPoint.x;
			nDeltaY = secondPoint.y - firstPoint.y;
			
			
			float nNewDistance;
			nNewDistance = sqrt(pow(nDeltaX, 2.0f) + pow(nDeltaY, 2.0f));
			
			float rScaleRate = nNewDistance / m_rInitDistance;
			
			m_rInitDistance = nNewDistance;
			
			float rDeltaX, rDeltaY;
			rDeltaX = nCenterX - m_rFirstTouchX;
			rDeltaY = nCenterY - m_rFirstTouchY;
			m_pFaceTagging[m_nSelectedIndex].center = CGPointMake(m_rFirstCenterX + rDeltaX, m_rFirstCenterY + rDeltaY);

	
			float rCurrentAngle, rDeltaAngle;
			
			rCurrentAngle = atan2(nDeltaY, nDeltaX);

			
			//Scaleing Eye and chin
			if (m_nSelectedIndex != 2)
			{
				m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform,CGAffineTransformMakeScale(rScaleRate, rScaleRate));
			}
			
			if (m_nSelectedIndex == 3)
			{
				rDeltaAngle = rCurrentAngle - m_fFirstAngle;
				m_fChinAngle += rDeltaAngle;
				m_fFirstAngle = rCurrentAngle;
				m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform,CGAffineTransformMakeRotation(rDeltaAngle));
			}
			
			if (m_nSelectedIndex == 2)
			{
//				float rViewHeight0, rViewWidth0, rViewHeight1, rViewWidth1;
//				
//				rViewWidth0 = m_rMouthWidth * cos(m_fMouthAngle) + m_rMouthHeight * sin(m_fMouthAngle);
//				rViewHeight0 =m_rMouthWidth * sin(m_fMouthAngle) + m_rMouthHeight * cos(m_fMouthAngle); 
				
				rDeltaAngle = rCurrentAngle - m_fFirstAngle;
				m_fMouthAngle += rDeltaAngle;
				m_fFirstAngle = rCurrentAngle;
				
	//			if (m_fVertical)
//				{
//					m_rMouthHeight *= rScaleRate;
//				}
//				else
//				{
//					m_rMouthWidth *= rScaleRate;
//				}
//				float tempFaceAngle;
//				tempFaceAngle = m_fMouthAngle;
				
				m_rMouthWidth *= rScaleRate;
				m_rMouthHeight *= rScaleRate;
				
                
                
                m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform, CGAffineTransformMakeScale(rScaleRate, rScaleRate));
				m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform, CGAffineTransformMakeRotation(rDeltaAngle));

			}
            
			CGRect rect = m_pFaceTagging[m_nSelectedIndex].frame;
			
			float rRectX, rRectY, rectWidth, rectHeight;
            
            float rOffsetX, rOffsetY;
            float rOffsetScale;
            
          
			rectWidth = rect.size.width;
			rectHeight = rect.size.height;
           
            rOffsetScale = MIN(MIN(rectWidth, (float)320) / rectWidth, MIN(rectHeight, (float)387) / rectHeight);        
			
            
            m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform, CGAffineTransformMakeScale(rOffsetScale, rOffsetScale));

            m_rMouthWidth *= rOffsetScale;
            m_rMouthHeight *= rOffsetScale;

            rect = m_pFaceTagging[m_nSelectedIndex].frame;
            
            rOffsetX = 0;
            rOffsetY = 0;
            
			rectWidth = rect.size.width;
			rectHeight = rect.size.height;
            
            rRectX = rect.origin.x;
            rRectY = rect.origin.y;
            
            if (rRectX < 0)
            {
                rOffsetX = - rRectX;
            }
            else
            {
                if (rRectX + rectWidth > 320)
                {
                    rOffsetX = 320 - (rRectX + rectWidth);
                }

            }
            
            if (rRectY < 45) 
            {
                rOffsetY = 45 - rRectY;
            }
            else
            {
                if (rRectY + rectHeight > 432) 
                {
                    rOffsetY = 432 - (rRectY + rectHeight);
                }
            }
            m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform, CGAffineTransformMakeTranslation(rOffsetX, rOffsetY));



		}
		else 
		{
			NSArray *twoTouch = [allTouch allObjects];
			UITouch *tOne = [twoTouch objectAtIndex:0];
			UITouch *tTwo = [twoTouch objectAtIndex:1];
			
			CGPoint firstPoint = [tOne locationInView:[tOne view]];
			CGPoint secondPoint = [tTwo locationInView:[tTwo view]];
			
			CGPoint point;
			
			point.x = (firstPoint.x + secondPoint.x) / 2;
			point.y = (firstPoint.y + secondPoint.y) / 2;
			
			float nDeltaX, nDeltaY;
			nDeltaX = secondPoint.x - firstPoint.x;
			nDeltaY = secondPoint.y - firstPoint.y;
			
			m_rInitDistance = sqrt(pow(nDeltaX, 2.0f) + pow(nDeltaY, 2.0f));
			m_fMultiTouched = true;
			m_fSingleTouched = false;
			
			m_rFirstTouchX = point.x;
			m_rFirstTouchY = point.y;
			[self GetSelectedIndex];
			
		
			if (m_nSelectedIndex >= 2)
			{
				m_fFirstAngle = atan2(nDeltaY, nDeltaX);
			}
			if (m_nSelectedIndex == 2)
			{
				float touchAngle = m_fFirstAngle;
				
				if (touchAngle < 0) 
				{
					touchAngle += M_PI * 2;
				}
				
				if (((touchAngle > M_PI * 5 / 4)&&(touchAngle > M_PI * 7 / 4)) || ((touchAngle > M_PI * 3 / 4)&&(touchAngle > M_PI  / 4)))
				{
					m_fVertical = true;
				}
				else
				{
					m_fVertical = false;
				}
				
			}
			
		}
		m_fSingleTouched = false;
		
	}
	else
	{
		m_fMultiTouched = false;
		if (m_fSingleTouched)
		{
			int nCenterX, nCenterY;
			NSArray *twoTouch = [allTouch allObjects];
			
			UITouch *tOne = [twoTouch objectAtIndex:0];
			
			CGPoint firstPoint = [tOne locationInView:[tOne view]];
			
			nCenterX = (firstPoint.x );
			nCenterY = (firstPoint.y );
			
			float rDeltaX, rDeltaY;
			rDeltaX = nCenterX - m_rFirstTouchX;
			rDeltaY = nCenterY - m_rFirstTouchY;
			
			m_pFaceTagging[m_nSelectedIndex].center = CGPointMake(m_rFirstCenterX + rDeltaX, m_rFirstCenterY + rDeltaY);
			
			
			CGRect rect = m_pFaceTagging[m_nSelectedIndex].frame;
			
			float rRectX, rRectY, rectWidth, rectHeight;
            
            float rOffsetX, rOffsetY;
            
			rectWidth = rect.size.width;
			rectHeight = rect.size.height;
            
            rOffsetX = 0;
            rOffsetY = 0;
            
			rectWidth = rect.size.width;
			rectHeight = rect.size.height;
            
            rRectX = rect.origin.x;
            rRectY = rect.origin.y;
            
            if (rRectX < 0)
            {
                rOffsetX = - rRectX;
            }
            else
            {
                if (rRectX + rectWidth > 320)
                {
                    rOffsetX = 320 - (rRectX + rectWidth);
                }
                
            }
            
            if (rRectY < 45) 
            {
                rOffsetY = 45 - rRectY;
            }
            else
            {
                if (rRectY + rectHeight > 432) 
                {
                    rOffsetY = 432 - (rRectY + rectHeight);
                }
            }
            m_pFaceTagging[m_nSelectedIndex].transform = CGAffineTransformConcat(m_pFaceTagging[m_nSelectedIndex].transform, CGAffineTransformMakeTranslation(rOffsetX, rOffsetY));
			
		}
		else
		{
			UITouch *touch = [allTouch anyObject];
			CGPoint touchPoint= [touch locationInView:self.view];	
			m_rFirstTouchX = touchPoint.x;
			m_rFirstTouchY = touchPoint.y;
			m_fSingleTouched = true;
			m_fMultiTouched = false;
			[self GetSelectedIndex];
		}
		
		
	}
	
	
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	m_fSingleTouched= false;
	m_fMultiTouched = false;
}

-(void) GetSelectedIndex
{
	int i;
	float rMinDistance = 1000;
	int nResult = -1;
	
	
	for (i = 0; i < 4; i++)
	{
		CGPoint center;
		center = m_pFaceTagging[i].center;
		
		float nDeltaX, nDeltaY;
		nDeltaX = center.x - m_rFirstTouchX;
		nDeltaY = center.y - m_rFirstTouchY;
		
		float rDistance = sqrt(pow(nDeltaX, 2.0f) + pow(nDeltaY, 2.0f));
		if (rDistance < 100 && rDistance < rMinDistance)
		{
			rMinDistance = rDistance;
			nResult = i;
			
			m_rFirstCenterX = m_pFaceTagging[i].center.x;
			m_rFirstCenterY = m_pFaceTagging[i].center.y;
			m_rFirstWidth = m_pFaceTagging[i].bounds.size.width;
			m_rFirstHeight = m_pFaceTagging[i].bounds.size.height;
			
			
		}
	}
	m_nSelectedIndex = nResult;
}

-(void) onBack:(id)sender
{
//    SelectFromCameraAndAlbum *viewController = [[SelectFromCameraAndAlbum alloc] init];
//    [self.navigationController popToViewController:viewController animated:YES];
//    [viewController release];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];

    
//	[self.navigationController popViewControllerAnimated:YES];
}
-(void) onVampiraze:(id)sender
{
	[self SetTaggingPoint];
	[self.navigationController pushViewController:m_pMakeZombieController animated:YES];
	[m_pMakeZombieController Init];
}

-(void) ShowBloodControl:(bool) fShow
{
	m_pBackImageView.hidden = !fShow;
	m_pBloodFrame.hidden = !fShow;
	m_pBloodLabel.hidden = !fShow;
	m_pBloodView.hidden = !fShow;
}

-(void) SetTaggingPoint
{
	int nImageWidth,nImageHeight;
	
	VampirizerAppDelegate* app = (VampirizerAppDelegate *)[UIApplication sharedApplication].delegate;
	
	
	nImageHeight = app.m_pOrgImage.size.height;
	nImageWidth = app.m_pOrgImage.size.width;
	
	float rScale = [app GetScale];
	
	int i;
	for (i = 0; i < 4; i++)
	{
		float rCenterX, rCenterY;
		float rSourceX, rSourceY, rSourceWidth, rSourceHeight;

		float rDesCenterX, rDesCenterY;
		float rDesSourceX, rDesSourceY, rDesSourceWidth, rDesSourceHeight;

		
		rSourceX = m_pFaceTagging[i].frame.origin.x;
		rSourceY = m_pFaceTagging[i].frame.origin.y;
		rSourceWidth = m_pFaceTagging[i].frame.size.width;
		rSourceHeight = m_pFaceTagging[i].frame.size.height;
		
		rCenterX = rSourceX + rSourceWidth / 2;
		rCenterY = rSourceY + rSourceHeight / 2;
		
		rDesCenterX = (rCenterX - ScreenWidth / 2) / rScale + nImageWidth / 2;
		rDesCenterY = (rCenterY - ScreenViewHeight / 2) / rScale + nImageHeight / 2;
		
		rDesSourceWidth = rSourceWidth / rScale;
		rDesSourceHeight = rSourceHeight / rScale;
		
		rDesSourceX = rDesCenterX - rDesSourceWidth / 2;
		rDesSourceY = rDesCenterY - rDesSourceHeight / 2;
		
		[app SetFaceTaggingRect:i rect:CGRectMake(rDesSourceX, rDesSourceY, rDesSourceWidth, rDesSourceHeight)];
	}
	
//	m_rMouthWidth /= rScale;
//	m_rMouthHeight /= rScale;
	app.m_rMouthWidth = m_rMouthWidth / rScale;
	app.m_rMouthHeight = m_rMouthHeight / rScale;
	app.m_rMouthAngle = m_fMouthAngle;
}

-(void) SetDefault
{
	int i;
	
	for (i = 0; i < 4; i++)
	{
//		m_pFac eTagging[i].transform = CGAffineTransformConcat(m_pFaceTagging[i].transform, CGAffineTransformMakeRotation(0));
//		m_pFaceTagging[i].transform = CGAffineTransformConcat(m_pFaceTagging[i].transform, CGAffineTransformMakeScale(1, 1));
		
		m_pFaceTagging[i].transform = CGAffineTransformMakeRotation(0);
	
	}
	
//	m_pFaceTagging[2].transform = CGAffineTransformMakeRotation(0);
//	m_pFaceTagging[3].transform = CGAffineTransformMakeRotation(0);
	
	m_pFaceTagging[0].frame = CGRectMake(100, 174, 23, 23);
	
	m_pFaceTagging[1].frame = CGRectMake(207, 174, 23, 23);
	
	m_pFaceTagging[2].frame = CGRectMake(115, 283, 100, 46);
	
	m_pFaceTagging[3].frame = CGRectMake(83, 328, 155, 50);
	
	m_fMouthAngle = 0;
	m_fChinAngle = 0;
	m_rMouthWidth = 100;
	m_rMouthHeight = 46;
	
}

@end
