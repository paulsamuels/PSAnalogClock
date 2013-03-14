//
//  PSAnalogClock.h
//  AnalogClockWithImages
//
//  Created by Paul Samuels on 26/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const PSAnalogClockViewClockFace;
extern NSString * const PSAnalogClockViewHourHand;
extern NSString * const PSAnalogClockViewMinuteHand;
extern NSString * const PSAnalogClockViewSecondHand;
extern NSString * const PSAnalogClockViewCenterCap;

typedef enum {
    PSAnalogClockViewOptionNone        = 1 << 0, // Default to PSAnalogClockViewOptionSmoothHands
    PSAnalogClockViewOptionSmoothHands = 1 << 1, // Makes the second hand move in one continous smooth motion
    PSAnalogClockViewOptionClunkyHands = 1 << 2, // Makes the second hand move more like a classic analog clock
} PSAnalogClockViewOption;

@interface PSAnalogClockView : UIView

@property (nonatomic) BOOL isStarted;
@property (nonatomic, strong) UIImage *secondHandImage;
@property (nonatomic, strong) UIImage *minuteHandImage;
@property (nonatomic, strong) UIImage *hourHandImage;
@property (nonatomic, strong) UIImage *centerCapImage;
@property (nonatomic, strong) UIImage *clockFaceImage;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andImages:(NSDictionary *)images;
- (id)initWithFrame:(CGRect)frame andImages:(NSDictionary *)images withOptions:(PSAnalogClockViewOption)options;
- (void)start;
- (void)stop;
- (void)updateClockTimeAnimated:(BOOL)animated;

@end
