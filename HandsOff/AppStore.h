#import <Foundation/Foundation.h>

@interface AppStore : NSObject {
	NSDate *currentFocusTargetDate;
}
@property(nonatomic,retain) NSDate *currentFocusTargetDate;
+ (id)sharedInstance;
@end