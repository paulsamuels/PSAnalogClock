//
//  AnalogClockWithImagesViewController.m
//  AnalogClockWithImages
//
//  Created by Paul Samuels on 26/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "AnalogClockWithImagesViewController.h"
#import "PSAnalogClockView.h"

@interface AnalogClockWithImagesViewController ()

@property (nonatomic, strong) PSAnalogClockView *clockView;

@end

@implementation AnalogClockWithImagesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  /*
   * 4 different looks at instantiating the view
   */
  [self instantiateClockAndAddImagesAfterAndDoNotStartAnimation];
  
  [self instantiateClockAndAddImagesAfterWithSomeImagesMissing];
  
  [self instantiateClockUsingADictionaryOfImages];
  
  [self instantiateClockUsingADictionaryOfImagesAndOptionsForControllingSecondHandAnimation];
  
}


- (void)instantiateClockAndAddImagesAfterAndDoNotStartAnimation
{
  PSAnalogClockView *analogClock = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(220, 20, 80, 80)];
  analogClock.clockFaceImage  = [UIImage imageNamed:@"clock"];
  analogClock.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  analogClock.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
  analogClock.secondHandImage = [UIImage imageNamed:@"clock_second_hand"];
  analogClock.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  
  [self.view addSubview:analogClock];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateClock:)];
  [analogClock addGestureRecognizer:tap];
  
  self.clockView = analogClock;
  
  [analogClock updateClockTimeAnimated:YES];
}

- (void)updateClock:(id)sender
{
  [self.clockView updateClockTimeAnimated:YES];
}

- (void)instantiateClockAndAddImagesAfterWithSomeImagesMissing
{
  PSAnalogClockView *analogClock2 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(220, 138, 80, 80)];
  analogClock2.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  analogClock2.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
  analogClock2.secondHandImage = [UIImage imageNamed:@"clock_second_hand"];
  analogClock2.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  
  [self.view addSubview:analogClock2];
  
  [analogClock2 start];
}

- (void)instantiateClockUsingADictionaryOfImages
{  
  PSAnalogClockView *analogClock3 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(220, 246, 80, 80) 
                                                                   andImages:[self images]];
  
  [self.view addSubview:analogClock3];
  
  [analogClock3 start];
}

- (void)instantiateClockUsingADictionaryOfImagesAndOptionsForControllingSecondHandAnimation
{
  PSAnalogClockView *analogClock4 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(220, 350, 80, 80) 
                                                                   andImages:[self images]
                                                                 withOptions:PSAnalogClockViewOptionClunkyHands];
  
  [self.view addSubview:analogClock4];
  
  [analogClock4 start];
}

- (NSDictionary *)images
{
  return @{
            PSAnalogClockViewClockFace:  [UIImage imageNamed:@"clock"],
            PSAnalogClockViewHourHand:   [UIImage imageNamed:@"clock_hour_hand"],
            PSAnalogClockViewMinuteHand: [UIImage imageNamed:@"clock_minute_hand"],
            PSAnalogClockViewSecondHand: [UIImage imageNamed:@"clock_second_hand"],
            PSAnalogClockViewCenterCap:  [UIImage imageNamed:@"clock_centre_point"]
         };
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
