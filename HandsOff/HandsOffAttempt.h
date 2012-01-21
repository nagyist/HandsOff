//
//  HandsOffAttempt.h
//  HandsOff
//
//  Created by Matthew Holden on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandsOffAttempt : NSObject <NSCoding>
{
	NSDate *startDate;
	NSDate *endDate;
	BOOL wasSuccessful;
}
@property(nonatomic,readonly) NSDate *startDate;
@property(nonatomic,readonly) NSDate *endDate;
@property(nonatomic,readonly) BOOL wasSuccessful;

-(id)initWithStartDate:(NSDate *)start endDate:(NSDate *)end wasSuccessful:(BOOL)success;

@end
