//
//  HelperFunctions.m
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelperFunctions.h"


#pragma mark Helper functions
NSString *timeStringFromDesiredFocusTime(int desiredFocusTimeInSeconds)
{
	int hours = desiredFocusTimeInSeconds / 3600;
	int minutes = (desiredFocusTimeInSeconds%3600) / 60;
	
	NSLog(@"desiredfocustimeinseonds %d", desiredFocusTimeInSeconds);
	NSLog(@"hours and minutes:");
	NSLog(@"%d", hours);
	NSLog(@"%d", minutes);
	
	NSMutableString *time = [NSMutableString stringWithString:@""];
	
	if (hours > 0)
		if (hours == 1)
			[time appendFormat:@"%d hour", hours];
		else
			[time appendFormat:@"%d hours", hours];
	if (hours > 0 && minutes > 0)
		[time appendString:@", "];
	if (minutes > 0)
		if (minutes == 1)
			[time appendFormat:@"%d minute", minutes];
		else
			[time appendFormat:@"%d minutes", minutes];			

	return [NSString stringWithString:time];		
}