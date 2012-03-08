//
//  CropImageScreen.m
//  cropImageTest
//
//  Created by YunasQazi on 2/23/11.
//  Copyright 2011 Yunas Qazi. All rights reserved.
//

#import "CropImageScreen.h"
int ivAngle1 = 0;

@implementation CropImageScreen



-(IBAction) rotateLeft : (id)sender
{
	
	CGAffineTransform rotate = CGAffineTransformMakeRotation( --ivAngle1 / 180.0 * 3.14 );
	[iv  setTransform:rotate];
//	scroll.minimumZoomScale = scroll.frame.size.width / image.frame.size.width;
//	scroll.maximumZoomScale = 2.0;
//	[scroll setZoomScale:scroll.minimumZoomScale];
}


-(IBAction) rotateRight : (id)sender
{
	CGAffineTransform rotate = CGAffineTransformMakeRotation( ++ivAngle1 / 180.0 * 3.14 );
	[iv setTransform:rotate];
//	scroll.minimumZoomScale = scroll.frame.size.width / image.frame.size.width;
//	scroll.maximumZoomScale = 2.0;
//	[scroll setZoomScale:scroll.minimumZoomScale];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	myScrollView.contentSize = CGSizeMake(500, 500);
    myScrollView.minimumZoomScale = myScrollView.frame.size.width / iv.frame.size.width;
	myScrollView.maximumZoomScale = 2.0;
	[myScrollView setZoomScale:myScrollView.minimumZoomScale];
	[super viewDidLoad];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
