//
//  cropImageTestAppDelegate.h
//  cropImageTest
//
//  Created by YunasQazi on 2/18/11.
//  Copyright Yunas Qazi 2011. All rights reserved.
//

#import <UIKit/UIKit.h>


@class cropImageTestViewController;

@interface cropImageTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    cropImageTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet cropImageTestViewController *viewController;

@end

