//
//  cropImageTestViewController.h
//  cropImageTest
//
//  Created by YunasQazi on 2/18/11.
//  Copyright Yunas Qazi 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cropImageTestViewController : UIViewController<UIScrollViewDelegate> {

	int cLeft;
	int cRight;
	int cTop;
	int cDown;
	
	
	IBOutlet UIView * leftRect;
	IBOutlet UIView * upperRect;
	IBOutlet UIView * rightRect;
	IBOutlet UIView * lowerRect;
	IBOutlet UIView * cropRect;
	
	bool isTappedInCropView;
	bool isTappedOnUpperLeftCorner;
	bool isTappedOnUpperRightCorner;
	bool isTappedOnLowerLeftCorner;
	bool isTappedOnLowerRightCorner;	
	
	UIImageView *iv;
	IBOutlet UIScrollView *scrollView;
	
	
	
	
	
	
	CGFloat cropXL ;
	CGFloat cropYT ;
	CGFloat cropXR ;
	CGFloat cropH ;
	CGFloat cropW ;
	CGFloat cropYB ;
	
	
	CGFloat leftYT ;
	CGFloat leftH ;
	CGFloat leftYB ;
	CGFloat leftW ; // leftXR
	
	
	CGFloat rightXL;
	CGFloat rightW ;
	CGFloat rightXR ;
	CGFloat rightYT ;
	CGFloat rightH ;
	CGFloat rightYB ;
	
	
	CGFloat lowerYT ;
	CGFloat lowerH ;
	CGFloat lowerYB ;
	
	
	CGFloat commonCropT;
	CGFloat commonCropB;
	CGFloat commonCropL;
	CGFloat commonCropR;
	CGFloat commonCropH;
	CGFloat commonCropW;
	
	
	UIImageView * ivleftUp ;
	UIImageView * ivRightUp ;
	UIImageView * ivleftDown ;
	UIImageView * ivRightDown;
	
	
}


-(IBAction) rotateLeft : (id)sender;
-(IBAction) rotateRight : (id)sender;
- (IBAction) sliderChanged: (id) sender;


@end

