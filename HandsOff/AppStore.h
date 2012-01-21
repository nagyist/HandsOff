#import <Foundation/Foundation.h>
#import "HandsOffAttempt.h"
@interface AppStore : NSObject {
	NSDate *currentFocusTargetDate;
	NSNumber *currentFocusTimeInSeconds;
	NSMutableArray *attempts;
	
	//this is private
}
@property(nonatomic,retain) NSDate *currentFocusTargetDate;
@property(nonatomic,retain) NSNumber *currentFocusTimeInSeconds;
@property(nonatomic, readonly) NSArray *attempts;
+ (id)sharedInstance;
- (BOOL)saveAttempts;
- (void)addAttempt:(HandsOffAttempt*)attempt;


@end