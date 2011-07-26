//
//  AnalogClockWithImagesAppDelegate.h
//  AnalogClockWithImages
//
//  Created by Paul Samuels on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnalogClockWithImagesViewController;

@interface AnalogClockWithImagesAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AnalogClockWithImagesViewController *viewController;

@end
