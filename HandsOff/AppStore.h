#import <Foundation/Foundation.h>
#import "HandsOffAttempt.h"
@interface AppStore : NSObject {
	HandsOffAttempt *currentAttempt;
	NSMutableArray *attempts;
	
	//this is private
}
@property(nonatomic,retain) HandsOffAttempt *currentAttempt;
@property(nonatomic, readonly) NSArray *attempts;
+ (id)sharedInstance;
- (void)addAttempt:(HandsOffAttempt*)attempt;
- (BOOL)archiveAttempts;


@end