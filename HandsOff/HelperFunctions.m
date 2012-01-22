//
//  HelperFunctions.m
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelperFunctions.h"


#pragma mark Helper functions
NSString *timeStringFromTimeInterval(NSTimeInterval interval)
{
	int hours = (int)interval / 3600;
	int minutes = ((int)interval%3600) / 60;
	
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

NSString *pathInDocumentDirectory(NSString *fileName)
{
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentDirectory = [documentDirectories objectAtIndex:0];
	
	return [documentDirectory stringByAppendingPathComponent:fileName];
}