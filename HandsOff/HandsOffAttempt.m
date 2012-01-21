//
//  HandsOffAttempt.m
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffAttempt.h"

@implementation HandsOffAttempt
@synthesize wasSuccessful, startDate, endDate;


-(id)initWithStartDate:(NSDate *)start endDate:(NSDate *)end wasSuccessful:(BOOL)success
{
	self = [super init];
	
	startDate = start;
	endDate = end;
	wasSuccessful = success;
	
	//add to appstore collection of attempts
	return self;
}

-(id)init
{
	[NSException raise:@"Do not call init method on class HandsOffAttempt" format:@""];
	return nil;
}

#pragma mark NSCoding protocol
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:startDate forKey:@"startDate"];
	[aCoder encodeObject:endDate forKey:@"endDate"];
	[aCoder	encodeBool:wasSuccessful forKey:@"wasSuccessful"];
}
-(id)initWithCoder:(NSCoder*)decoder
{
	self = [self initWithStartDate:nil endDate:nil wasSuccessful:NO];
	
	if (self)
	{
		startDate = [decoder decodeObjectForKey:@"startDate"];
		endDate = [decoder decodeObjectForKey:@"endDate"];
		wasSuccessful = [decoder decodeBoolForKey:@"wasSuccessful"];
	}
	
	return self;
}


@end
