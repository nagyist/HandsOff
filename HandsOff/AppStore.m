#import "AppStore.h"

@implementation AppStore
@synthesize currentFocusTargetDate;
static AppStore *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (AppStore *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
	
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
	
    if (self) {
        // Work your initialising magic here as you normally would
    }
	
    return self;
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end