//
//  HelperFunctions.m
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelperFunctions.h"


#pragma mark Helper functions
NSString *timeStringFromTimeIntervalWithSeconds(NSTimeInterval interval)
{
	NSLog(@"%d",interval);
	NSMutableString *time = [NSMutableString stringWithString:@""];
	
	int hours = (int)interval / 3600;
	int minutes = ((int)interval%3600) / 60;
	int seconds = ((int)interval%60);
	
	if (hours > 0)
		if (hours == 1)
			[time appendFormat:@"%d hour", hours];
		else
			[time appendFormat:@"%d hours", hours];
	
	if (minutes > 0)
		if (hours > 0)
			[time appendFormat:@", %d minutes", minutes];
		else
			[time appendFormat:@"%d minutes", minutes];
	if (seconds > 0)
		if (hours > 0 || minutes > 0)
			[time appendFormat:@", %d seconds", seconds];
		else 
			[time appendFormat:@"%d seconds", seconds];

	
	return [NSString stringWithString:time];		
}
//most of the time we call this method, we don't normally care about seconds
//it chops off seconds from the passed-in interval and calls timeStringFromTimeInterval
NSString *timeStringFromTimeInterval(NSTimeInterval interval)
{
	if ((int)interval < 60)
		return @"Less than one minute";
	
	//adjust interval to remove seconds.  above method omits "seconds" if the value is 0
	NSTimeInterval newInterval = (NSTimeInterval)( (int)interval - (int)interval%60);
	return timeStringFromTimeIntervalWithSeconds(newInterval);
}



NSString *pathInDocumentDirectory(NSString *fileName)
{
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	
	return [documentDirectory stringByAppendingPathComponent:fileName];
}