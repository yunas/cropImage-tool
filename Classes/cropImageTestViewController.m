//
//  cropImageTestViewController.m
//  cropImageTest
//
//  Created by YunasQazi on 2/18/11.
//  Copyright Yunas Qazi 2011. All rights reserved.
//

#import "cropImageTestViewController.h"


// 85 - 110 - 145 - 200


#define kLeft 85
#define kTop 110
#define kRight 230
#define kDown 310
#define ktapDiff 20
#define kWidthDifference 50
#define kHeightDifference 50
#define kMaxBottom 410
int ivAngle = 0;


@implementation cropImageTestViewController



-(IBAction) rotateLeft : (id)sender
{
	CGAffineTransform rotate = CGAffineTransformMakeRotation( --ivAngle / 180.0 * 3.14 );
	[scrollView setTransform:rotate];
}

-(IBAction) rotateRight : (id)sender
{
	CGAffineTransform rotate = CGAffineTransformMakeRotation( ++ivAngle / 180.0 * 3.14 );
	[scrollView setTransform:rotate];	
}


- (IBAction) sliderChanged: (id) sender
{
	UISlider * slider1 = (UISlider *)sender;
//	CGAffineTransform rotate = CGAffineTransformMakeRotation( ++ivAngle / 180.0 * 3.14 );
	CGAffineTransform rotate = CGAffineTransformMakeRotation( slider1.value / 180.0 * 3.14 );
	[scrollView setTransform:rotate];
}

-(void) setScrollView
{
	
	scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	scrollView.backgroundColor = [UIColor blackColor];
	scrollView.delegate = self;
	iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.JPG"]];
	scrollView.contentSize = iv.frame.size;
	[scrollView addSubview:iv];
	scrollView.minimumZoomScale = scrollView.frame.size.width / iv.frame.size.width;
	scrollView.maximumZoomScale = 2.0;
	[scrollView setZoomScale:scrollView.minimumZoomScale];
	[self.view addSubview:scrollView];	
	[self.view sendSubviewToBack:scrollView];
}


- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
	CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
	
	return frameToCenter;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollV {
	iv.frame = [self centeredFrameForScrollView:scrollV andUIView:iv];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return iv;
}


#pragma mark -



- (void)ControlCropView:(NSSet *)touches {
	

		CGPoint movedPoint = [[touches anyObject] locationInView:self.view];
	
		NSLog(@" movedPoint = (%f,%f)",movedPoint.x,movedPoint.y);

		if (((movedPoint.x<= commonCropL) && (commonCropL - movedPoint.x <= ktapDiff ) || (movedPoint.x >= commonCropL) && (movedPoint.x - commonCropL <= ktapDiff ))&& ((movedPoint.y <= commonCropT ) && (commonCropT - movedPoint.y <= ktapDiff) || (movedPoint.y >= commonCropT ) && (movedPoint.y - commonCropT <=ktapDiff)))
		{
			NSLog(@"Touched upper left corner");
			isTappedOnUpperLeftCorner = TRUE;
		}
		else if (((movedPoint.x<= commonCropR) && (commonCropR - movedPoint.x <= ktapDiff ) || (movedPoint.x >= commonCropR) && (movedPoint.x - commonCropR <= ktapDiff ))&& ((movedPoint.y <= commonCropT ) && (commonCropT - movedPoint.y <= ktapDiff) || (movedPoint.y >= commonCropT ) && (movedPoint.y - commonCropT <=ktapDiff)))
		{
			NSLog(@"Touched upper Right corner");
			isTappedOnUpperRightCorner = TRUE;
		}
		else if (((movedPoint.x<= commonCropL) && (commonCropL - movedPoint.x <= ktapDiff ) || (movedPoint.x >= commonCropL) && (movedPoint.x - commonCropL <= ktapDiff ))&& ((movedPoint.y <= commonCropB ) && (commonCropB - movedPoint.y <=ktapDiff) || (movedPoint.y >= commonCropB ) && (movedPoint.y - commonCropB <=ktapDiff)))
		{
			NSLog(@"Touched lower left corner");
			isTappedOnLowerLeftCorner = TRUE;
		}
		else if (((movedPoint.x<= commonCropR) && (commonCropR - movedPoint.x <= ktapDiff ) || (movedPoint.x >= commonCropR) && (movedPoint.x - commonCropR <= ktapDiff ))&& ((movedPoint.y <= commonCropB ) && (commonCropB - movedPoint.y <= ktapDiff) || (movedPoint.y >= commonCropB ) && (movedPoint.y - commonCropB <=ktapDiff)))
		{
			NSLog(@"Touched lower Right corner");
			isTappedOnLowerRightCorner = TRUE;				
		}
}

-(void) updateCropPoints
{
	[ivleftUp setFrame:CGRectMake(commonCropL - 10, commonCropT-10, 20, 20)];
	[ivRightUp setFrame:CGRectMake(commonCropR-10, commonCropT-10, 20, 20)];
	[ivleftDown setFrame:CGRectMake(commonCropL - 10, commonCropB-10, 20, 20)];
	[ivRightDown setFrame:CGRectMake(commonCropR-10, commonCropB-10, 20, 20)];
	
	
}

- (void)updateLabelsFromTouches:(NSSet *)touches {
    NSUInteger numTaps = [[touches anyObject] tapCount];
    NSString *tapsMessage = [[NSString alloc]
                             initWithFormat:@"%d taps detected", numTaps];
    [tapsMessage release];
    
    NSUInteger numTouches = [touches count];
    NSString *touchMsg = [[NSString alloc] initWithFormat:
                          @"%d touches detected", numTouches];
    [touchMsg release];
}


-(void) drawRects 
{
	[upperRect setFrame:CGRectMake(upperRect.frame.origin.x, upperRect.frame.origin.y, upperRect.frame.size.width, commonCropT)];
	[leftRect setFrame:CGRectMake(leftRect.frame.origin.x, commonCropT, commonCropL, commonCropH)]; 
	[rightRect setFrame:CGRectMake(commonCropR, commonCropT, rightRect.frame.size.width, commonCropH)];  
}

#pragma mark -
#pragma mark UITOUCHES Stuff 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self ControlCropView:touches];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	isTappedOnLowerLeftCorner = FALSE;
	isTappedOnLowerRightCorner = FALSE;
	isTappedOnUpperLeftCorner = FALSE;
	isTappedOnUpperRightCorner = FALSE;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    messageLabel.text = @"Touches Stopped.";
	isTappedOnLowerLeftCorner = FALSE;
	isTappedOnLowerRightCorner = FALSE;
	isTappedOnUpperLeftCorner = FALSE;
	isTappedOnUpperRightCorner = FALSE;
    [self updateLabelsFromTouches:touches];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	//    messageLabel.text = @"Drag Detected";
	
	CGPoint movedPoint = [[touches anyObject] locationInView:self.view];
	if (!(movedPoint.x >=15 && movedPoint.x <=305))
		return;
	if (!(movedPoint.y >=15 && movedPoint.x <=465)) {
		return;
	}
	
	commonCropT = leftRect.frame.origin.y; // left.y or Right.y or Top.H ek hi baat ha
	commonCropB = lowerRect.frame.origin.y;// left.H or Right.H or lower.y ek hi baat ha	
	commonCropL = leftRect.frame.size.width; //
	commonCropR = rightRect.frame.origin.x;//
	commonCropH = leftRect.frame.size.height;// left.width and right.width
	
	leftYT = leftRect.frame.origin.y;
	leftH = leftRect.frame.size.height;
	leftYB = roundf(leftYT + leftH);
	leftW = leftRect.frame.size.width; // leftXR
	
	
	rightXL = rightRect.frame.origin.x;
	rightW = rightRect.frame.size.width;
	rightXR = roundf(rightXL + rightW);
	rightYT = rightRect.frame.origin.y; 
	rightH = rightRect.frame.size.height;
	rightYB = roundf(rightH + rightYT);
	
	
	lowerYT = lowerRect.frame.origin.y;	
	lowerH = lowerRect.frame.size.height;
	lowerYB = roundf(lowerH + lowerYT);
	
	if (isTappedOnUpperLeftCorner)
	{
		if (commonCropR - movedPoint.x <= kWidthDifference)
			return;
			
		if (movedPoint.y < commonCropT )
		{
			commonCropH  = (commonCropH + roundf(commonCropT - movedPoint.y)); 
		}
		else if (movedPoint.y > commonCropT )
		{
			if (commonCropB - movedPoint.y <= kHeightDifference ) {
				return;
			}
			commonCropH  = (commonCropH - roundf(movedPoint.y - commonCropT)); 
		}
		
		commonCropL = movedPoint.x;
		commonCropT = movedPoint.y;
		
		NSLog(@" cropW = %f ",cropW);

		[upperRect setFrame:CGRectMake(upperRect.frame.origin.x, upperRect.frame.origin.y, upperRect.frame.size.width, commonCropT)];
		[leftRect setFrame:CGRectMake(leftRect.frame.origin.x, commonCropT, commonCropL, commonCropH)]; 
		[rightRect setFrame:CGRectMake(commonCropR, commonCropT, rightRect.frame.size.width, commonCropH)];  

	}
	else if (isTappedOnUpperRightCorner) {
		
		
		if (movedPoint.x < commonCropR) {
			if (movedPoint.x - commonCropL <= kWidthDifference)
				return;
		}
		
		if (movedPoint.y < commonCropT )
		{
			
			commonCropH  = roundf(commonCropH + (commonCropT - movedPoint.y)); 
		}
		else if (movedPoint.y > commonCropT )
		{
			if (commonCropB - movedPoint.y <= kHeightDifference ) {
				return;
			}
			commonCropH  = roundf(commonCropH - (movedPoint.y - commonCropT)); 
		}
		if (movedPoint.x < commonCropR )
		{
			rightW  = roundf(rightW + (commonCropR - movedPoint.x)); 
		}
		else if (movedPoint.x > commonCropR )
		{
			rightW  = roundf(rightW - (movedPoint.x - commonCropR)); 
		}
		
		commonCropR = movedPoint.x;
		commonCropT = movedPoint.y;
		NSLog(@" cropW = %f ",cropW);
		[upperRect setFrame:CGRectMake(upperRect.frame.origin.x, upperRect.frame.origin.y, upperRect.frame.size.width, commonCropT)];
		[leftRect setFrame:CGRectMake(leftRect.frame.origin.x, commonCropT, commonCropL, commonCropH)]; 
		[rightRect setFrame:CGRectMake(commonCropR, commonCropT, rightW, commonCropH)];  
		
		
	}
	else if (isTappedOnLowerLeftCorner) {
		
		if (commonCropR - movedPoint.x <= kWidthDifference)
			return;

		if (movedPoint.y  - commonCropT <= kHeightDifference)
			return;

		if (movedPoint.y  > kMaxBottom)
			return;

		if (movedPoint.y < commonCropB )
		{
			commonCropH  = commonCropH - (commonCropB - movedPoint.y); 
			lowerH = roundf(lowerH + (commonCropB - movedPoint.y));
		}
		else if (movedPoint.y > commonCropB )
		{
			commonCropH  = commonCropH + (movedPoint.y - commonCropB); 
			lowerH = roundf(lowerH - (commonCropB - movedPoint.y));
		}
		
		commonCropL = movedPoint.x;
		commonCropB = movedPoint.y;
		
		NSLog(@" cropW = %d ",cropW);
		[lowerRect setFrame:CGRectMake(upperRect.frame.origin.x, commonCropB, upperRect.frame.size.width, lowerH)];
		[leftRect setFrame:CGRectMake(leftRect.frame.origin.x, commonCropT, commonCropL, commonCropH)]; 
		[rightRect setFrame:CGRectMake(commonCropR, commonCropT, rightRect.frame.size.width, commonCropH)];  
	}
	else if (isTappedOnLowerRightCorner) {
		
		if (movedPoint.y  > kMaxBottom)
			return;

		if (movedPoint.x < commonCropR) {
			if (movedPoint.x - commonCropL <= kWidthDifference)
				return;
		}
		if (movedPoint.y  - commonCropT <= kHeightDifference)
			return;
		
		if (movedPoint.y < commonCropB )
		{
			commonCropH  = commonCropH - (commonCropB - movedPoint.y); 
			lowerH = roundf(lowerH + (commonCropB - movedPoint.y));
		}
		else if (movedPoint.y > commonCropB )
		{
			commonCropH  = commonCropH + (movedPoint.y - commonCropB); 
			lowerH = roundf(lowerH - (commonCropB - movedPoint.y));
		}
		if (movedPoint.x < commonCropR )
		{
			rightW  = roundf(rightW + (commonCropR - movedPoint.x)); 
		}
		else if (movedPoint.x > commonCropR )
		{
			rightW  = roundf(rightW - (movedPoint.x - commonCropR)); 
		}
		
		commonCropR = movedPoint.x;
		commonCropB = movedPoint.y;
		NSLog(@" cropW = %d ",cropW);
		[lowerRect setFrame:CGRectMake(upperRect.frame.origin.x, commonCropB, upperRect.frame.size.width, lowerH)];
		[leftRect setFrame:CGRectMake(leftRect.frame.origin.x, commonCropT, commonCropL, commonCropH)]; 
		[rightRect setFrame:CGRectMake(commonCropR, commonCropT, rightW, commonCropH)];  
		
	}
	
	[self updateCropPoints];
//	[self performSelector:@selector(updateCropPoints) withObject:self afterDelay:0.5];
    
}


#pragma mark -
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(void) setCropRectVals
{
	
//	cropXL = cropRect.frame.origin.x;
//	cropYT = cropRect.frame.origin.y;
//	cropXR = cropRect.frame.size.width + cropRect.frame.origin.x;
//	cropH = cropRect.frame.size.height;
//	cropW = cropRect.frame.size.width;
//	cropYB = cropH +cropRect.frame.origin.y;
	
	
	commonCropT = leftRect.frame.origin.y; // left.y or Right.y or Top.H ek hi baat ha
	commonCropB = lowerRect.frame.origin.y;// left.H or Right.H or lower.y ek hi baat ha	
	commonCropL = leftRect.frame.size.width; //
	commonCropR = rightRect.frame.origin.x;//
	commonCropH = leftRect.frame.size.height;// left.width and right.width
	
	leftYT = leftRect.frame.origin.y;
	leftH = leftRect.frame.size.height;
	leftYB = roundf(leftYT + leftH);
	leftW = leftRect.frame.size.width; // leftXR
	
	
	rightXL = rightRect.frame.origin.x;
	rightW = rightRect.frame.size.width;
	rightXR = roundf(rightXL + rightW);
	rightYT = rightRect.frame.origin.y; 
	rightH = rightRect.frame.size.height;
	rightYB = roundf(rightH + rightYT);
	
	
	lowerYT = lowerRect.frame.origin.y;	
	lowerH = lowerRect.frame.size.height;
	lowerYB = roundf(lowerH + lowerYT);
	
	
	UIImage * cropPointImg = [UIImage imageNamed:@"cropPoint.png"];
	ivleftUp = [[UIImageView alloc]initWithFrame:CGRectMake(commonCropL - 10, commonCropT-10, 20, 20)];
	ivRightUp = [[UIImageView alloc]initWithFrame:CGRectMake(commonCropR-10, commonCropT-10, 20, 20)];
	ivleftDown = [[UIImageView alloc]initWithFrame:CGRectMake(commonCropL - 10, commonCropB-10, 20, 20)];
	ivRightDown = [[UIImageView alloc]initWithFrame:CGRectMake(commonCropR-10, commonCropB-10, 20, 20)];
	
	ivleftUp.image = cropPointImg;
	ivleftDown.image = cropPointImg;
	ivRightUp.image = cropPointImg;
	ivRightDown.image = cropPointImg;
	
	[self.view addSubview:ivleftUp];
	[self.view addSubview:ivleftDown];
	[self.view addSubview:ivRightUp];
	[self.view addSubview:ivRightDown];
	
}


//-(void) setCropRectVals
//{
//
//	cropXL = cropRect.frame.origin.x;
//	cropYT = cropRect.frame.origin.y;
//	cropXR = cropRect.frame.size.width + cropRect.frame.origin.x;
//	cropH = cropRect.frame.size.height;
//	cropW = cropRect.frame.size.width;
//	cropYB = cropH +cropRect.frame.origin.y;
//	
//	
//	leftYT = leftRect.frame.origin.y;
//	leftH = leftRect.frame.size.height;
//	leftYB = leftYT + leftH;
//	leftW = leftRect.frame.size.width; // leftXR
//	
//	
//	rightXL = rightRect.frame.origin.x;
//	rightW = rightRect.frame.size.width;
//	rightXR = rightXL + rightW;
//	rightYT = rightRect.frame.origin.y; 
//	rightH = rightRect.frame.size.height;
//	rightYB = rightH + rightYT;
//	
//	
//	lowerYT = lowerRect.frame.origin.y;	
//	lowerH = lowerRect.frame.size.height;
//	lowerYB = lowerH + lowerYT;
//	
//
//	UIImage * cropPointImg = [UIImage imageNamed:@"cropPoint.png"];
//	UIImageView * ivleftUp = [[UIImageView alloc]initWithFrame:CGRectMake(leftW - 15, 0, 20, 20)];
//	UIImageView * ivleftDown = [[UIImageView alloc]initWithFrame:CGRectMake(leftW - 15, leftH, 20, 20)];
//	UIImageView * ivRightUp = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//	UIImageView * ivRightDown = [[UIImageView alloc]initWithFrame:CGRectMake(0, rightH, 20, 20)];
//	
//	ivleftUp.image = cropPointImg;
//	ivleftDown.image = cropPointImg;
//	ivRightUp.image = cropPointImg;
//	ivRightDown.image = cropPointImg;
//	
//	[leftRect addSubview:ivleftUp];
//	[leftRect addSubview:ivleftDown];
//	[rightRect addSubview:ivRightUp];
//	[rightRect addSubview:ivRightDown];
//
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self setScrollView];
	[self setCropRectVals];
	
//	UIButton *switchCameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	//	[switchCameraButton setImage:[UIImage imageNamed:@"switchcamera.png"] forState:UIControlStateNormal];
//	[switchCameraButton setFrame:CGRectMake(10, 60, 60, 34)];
//	[switchCameraButton addTarget:self action:@selector(rotateLeft:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:switchCameraButton];
//	
//	UIButton *switchCameraButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	//	[switchCameraButton setImage:[UIImage imageNamed:@"switchcamera.png"] forState:UIControlStateNormal];
//	[switchCameraButton1 setFrame:CGRectMake(250, 60, 60, 34)];
//	[switchCameraButton1 addTarget:self action:@selector(rotateRight:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:switchCameraButton1];
	
	[super viewDidLoad];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	leftRect.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	rightRect.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	upperRect.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	lowerRect.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
