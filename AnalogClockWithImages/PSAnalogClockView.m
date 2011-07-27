//
//  PSAnalogClock.m
//  AnalogClockWithImages
//
//  Created by Paul Samuels on 26/07/2011.
//  Copyright 2011 www.paul-samuels.com. All rights reserved.
//

#import "PSAnalogClockView.h"

#define degreesToRadians(deg) (deg / 180.0 * M_PI)

NSString * const PSAnalogClockViewClockFace  = @"clock_face";
NSString * const PSAnalogClockViewHourHand   = @"hour_hand";
NSString * const PSAnalogClockViewMinuteHand = @"minute_hand";
NSString * const PSAnalogClockViewSecondHand = @"second_hand";
NSString * const PSAnalogClockViewCenterCap  = @"center_cap";

@interface PSAnalogClockView ()

@property (nonatomic, retain) NSTimer *clockUpdateTimer;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, retain) NSDate *now;

@property (nonatomic, retain) UIImageView *secondHandImageView;
@property (nonatomic, retain) UIImageView *minuteHandImageView;
@property (nonatomic, retain) UIImageView *hourHandImageView;
@property (nonatomic, retain) UIImageView *clockFaceImageView;
@property (nonatomic, retain) UIImageView *centreCapImageView;

@property (nonatomic, assign) PSAnalogClockViewOption options;

- (void)updateHoursHand;
- (void)updateMinutesHand;
- (void)updateSecondsHand;
- (int)hours;
- (int)minutes;
- (int)seconds;
- (void)addImageViews;

@end

@implementation PSAnalogClockView

@synthesize secondHandImageView  = _secondHandImageView;
@synthesize minuteHandImageView  = _minuteHandImageView;
@synthesize hourHandImageView    = _hourHandImageView;
@synthesize clockFaceImageView   = _clockFaceImageView;
@synthesize centreCapImageView   = _centreCapImageView;

@synthesize clockUpdateTimer     = _clockUpdateTimer;
@synthesize calendar             = _calendar;
@synthesize now                  = _now;

@synthesize options              = _options;

#pragma mark -
#pragma mark Initializers

- (id)initWithFrame:(CGRect)frame
{
  return [self initWithFrame:frame andImages:nil withOptions:PSAnalogClockViewOptionNone];
}

- (id)initWithFrame:(CGRect)frame andImages:(NSDictionary *)images
{
  return  [self initWithFrame:frame andImages:images withOptions:PSAnalogClockViewOptionNone];
}

- (id)initWithFrame:(CGRect)frame andImages:(NSDictionary *)images withOptions:(PSAnalogClockViewOption)options
{
  self = [super initWithFrame:frame];
  if (self) {
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    _options  = options;
    
    CGRect imageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    _clockFaceImageView  = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _hourHandImageView   = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _minuteHandImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _secondHandImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    _centreCapImageView  = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    if (images) {      
      self.clockFaceImage  = [images objectForKey:PSAnalogClockViewClockFace];
      self.hourHandImage   = [images objectForKey:PSAnalogClockViewHourHand];
      self.minuteHandImage = [images objectForKey:PSAnalogClockViewMinuteHand];
      self.secondHandImage = [images objectForKey:PSAnalogClockViewSecondHand];
      self.centerCapImage  = [images objectForKey:PSAnalogClockViewCenterCap];
      
      [self addImageViews];
    }
  }
  return self;
}

- (void)dealloc
{
  [_secondHandImageView  release];
  [_minuteHandImageView  release];
  [_hourHandImageView    release];
  [_clockFaceImageView   release];
  [_centreCapImageView   release];
  
  [_clockUpdateTimer release];
  [_calendar         release];
  
  [super dealloc];
}

- (void)addImageViews
{  
  NSArray *subViews = [self subviews];
  
  if (self.clockFaceImageView.image && ![subViews containsObject:self.clockFaceImageView]) {
    [self addSubview:self.clockFaceImageView];
  }
  if (self.hourHandImageView.image && ![subViews containsObject:self.hourHandImageView]) {
    [self addSubview:self.hourHandImageView];
  }
  if (self.minuteHandImageView.image && ![subViews containsObject:self.minuteHandImageView]) {
    [self addSubview:self.minuteHandImageView];
  }
  if (self.secondHandImageView.image && ![subViews containsObject:self.secondHandImageView]) {
    [self addSubview:self.secondHandImageView];
  }
  if (self.centreCapImageView.image && ![subViews containsObject:self.centreCapImageView]) {
    [self addSubview:self.centreCapImageView];
  }
}

#pragma mark -
#pragma marl Start and Stop the clock

- (void)start
{
	self.clockUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClockTimeAnimated:) userInfo:nil repeats:YES];
  [self updateClockTimeAnimated:NO];
}

- (void)stop
{
	[self.clockUpdateTimer invalidate]; self.clockUpdateTimer = nil;
}

- (void)updateClockTimeAnimated:(BOOL)animated
{
  [self addImageViews];
  
  self.now = [NSDate date];
  
  if (animated) {
    [UIView beginAnimations:nil context:nil];
    
    if (PSAnalogClockViewOptionNone & self.options || PSAnalogClockViewOptionSmoothHands & self.options) {
      [UIView setAnimationDuration:1];
      [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    } else if (PSAnalogClockViewOptionClunkyHands & self.options) {
      [UIView setAnimationDuration:0.3];
      [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    }
    
  }
  
  [self updateHoursHand];
  [self updateMinutesHand];
  [self updateSecondsHand];
  
  if (animated) {
    [UIView commitAnimations];
  }
}

- (void)updateHoursHand
{
  if (nil == self.hourHandImage) {
    return;
  }
  
  int degreesPerHour   = 30;
  int degreesPerMinute = 0.5;
  
  int hours = [self hours];
  
  int hoursFor12HourClock = hours < 12 ? hours : hours - 12;
  
  float rotationForHoursComponent  = hoursFor12HourClock * degreesPerHour;
  float rotationForMinuteComponent = degreesPerMinute * [self minutes];
  
  float totalRotation = rotationForHoursComponent + rotationForMinuteComponent;
  
  double hourAngle = degreesToRadians(totalRotation);
  
  self.hourHandImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, hourAngle);
}

- (void)updateMinutesHand
{  
  if (nil == self.minuteHandImage) {
    return;  
  }
  
  int degreesPerMinute = 6;
  
  double minutesAngle = degreesToRadians([self minutes] * degreesPerMinute);
  
  self.minuteHandImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, minutesAngle);
}

- (void)updateSecondsHand
{    
  if (nil == self.secondHandImage) {
    return;
  }
  
  int degreesPerSecond = 6;
  
  double secondsAngle = degreesToRadians([self seconds] * degreesPerSecond);
  
  self.secondHandImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, secondsAngle);
}

- (int)hours
{
  return [[self.calendar components:NSHourCalendarUnit fromDate:self.now] hour];
}

- (int)minutes
{
  return [[self.calendar components:NSMinuteCalendarUnit fromDate:self.now] minute];
}

- (int)seconds
{
  return [[self.calendar components:NSSecondCalendarUnit fromDate:self.now] second];;
}

#pragma mark - 
#pragma mark Setters + getters for adding clock images

- (void)setSecondHandImage:(UIImage *)secondHandImage
{
  self.secondHandImageView.image = secondHandImage;
}

- (UIImage *)secondHandImage
{
  return self.secondHandImageView.image;
}

- (void)setMinuteHandImage:(UIImage *)minuteHandImage
{
  self.minuteHandImageView.image = minuteHandImage;
}

- (UIImage *)minuteHandImage
{
  return self.minuteHandImageView.image;
}

- (void)setHourHandImage:(UIImage *)hourHandImage
{
  self.hourHandImageView.image = hourHandImage;
}

- (UIImage *)hourHandImage
{
  return  self.hourHandImageView.image;
}

- (void)setCenterCapImage:(UIImage *)centerCapImage
{
  self.centreCapImageView.image = centerCapImage;
}

- (UIImage *)centerCapImage
{
  return  self.centreCapImageView.image;
}

- (void)setClockFaceImage:(UIImage *)clockFaceImage
{
  self.clockFaceImageView.image = clockFaceImage;
}

- (UIImage *)clockFaceImage
{
  return self.clockFaceImageView.image;
}

@end
