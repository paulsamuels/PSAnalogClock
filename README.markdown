AnalogClockWithImages
---------------------

This project is a quick example of how to use `PSAnalogClockView` which is a class that allows you to create an analog style clock by providing your own images.

The class accepts images for:

- The clock face
- The hour hand
- The minute hand
- The second hand
- A center cap piece that covers the point where all the hands intercept

The class can be instantiated in two different ways:

1. By instantiating the class and then adding the images

    `PSAnalogClockView *analogClock = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];`
    `analogClock.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];`
    `analogClock.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];`
    `analogClock.secondHandImage = [UIImage imageNamed:@"clock_second_hand"];`
    `analogClock.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];`

    `[self.view addSubview:analogClock];`

    `[analogClock start];`
    
2. By instantiating the class and passing in an `NSDictionary` of images

    `PSAnalogClockView *analogClock3 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(220, 246, 80, 80) `
                                                                      ` andImages:[self images]];`

    `[self.view addSubview:analogClock3];`

    `[analogClock3 start];`
    
    