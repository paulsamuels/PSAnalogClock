//
//  AnalogClockWithImagesAppDelegate.h
//  AnalogClockWithImages
//
//  Created by Paul Samuels on 26/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnalogClockWithImagesViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet AnalogClockWithImagesViewController *viewController;

@end
