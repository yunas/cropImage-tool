//
//  CropImageScreen.h
//  cropImageTest
//
//  Created by YunasQazi on 2/23/11.
//  Copyright 2011 Yunas Qazi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CropImageScreen : UIViewController {

	IBOutlet UIScrollView * myScrollView;
	IBOutlet UIImageView *iv;
	
}

-(IBAction) rotateLeft : (id)sender;
-(IBAction) rotateRight : (id)sender;

@end
