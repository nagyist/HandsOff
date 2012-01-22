//
//  HandsOffAttempt.m
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffAttempt.h"

@implementation HandsOffAttempt
@synthesize startDate, attemptedLength;


-(id)initWithStartDate:(NSDate *)start desiredLength:(NSTimeInterval)length
{
	self = [super init];
	
	startDate = start;
	attemptedLength = length;
	
	return self;
}

-(id)init
{
	[NSException raise:@"Do not call init method on class HandsOffAttempt" format:@""];
	return nil;
}

-(void)endAttempt
{
	endDate = [[NSDate alloc] init];
	completedLength = [endDate timeIntervalSinceDate:startDate];
	wasSuccessful = completedLength >= 0;
}



//NOT SYNTHESIZING
-(NSTimeInterval)completedLength 
{
	if (!completedLength)
		[NSException exceptionWithName:@"Error" reason:@"Cannot read \"Completed Length\" variable in an Attempt that has not finished." userInfo:nil];
	else
		return completedLength;
	//so compiler will stop warning me;	
	return 0;
}
//NOT SYNTHESIZING
-(BOOL)wasSuccessful
{
	if(!wasSuccessful)
		[NSException exceptionWithName:@"Error" reason:@"Cannot read \"Was Successful\" variable in an Attempt that has not finished." userInfo:nil];	
	else
		return wasSuccessful;

	//so compiler will stop warning me;
	return NO;
}
//NOT SYNTHESIZING
-(NSDate *)endDate
{
	if(!endDate)
		[NSException exceptionWithName:@"Error" reason:@"Cannot read \"End Date\" variable in an Attempt that has not finished." userInfo:nil];	
	else
		return endDate;
	
	//so compiler will stop warning me;
	return nil;
}

#pragma mark NSCoding protocol
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:startDate forKey:@"startDate"];
	[aCoder encodeDouble:attemptedLength forKey:@"attemptedLength"];
	[aCoder	encodeBool:wasSuccessful forKey:@"wasSuccessful"];
}
-(id)initWithCoder:(NSCoder*)decoder
{
	self = [self initWithStartDate:nil desiredLength:0];
	
	if (self)
	{
		startDate = [decoder decodeObjectForKey:@"startDate"];
		attemptedLength = [decoder decodeDoubleForKey:@"endDate"];
		wasSuccessful = [decoder decodeBoolForKey:@"wasSuccessful"];
	}
	
	return self;
}


@end
