#import "AppStore.h"


@implementation AppStore
@synthesize currentAttempt;
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

#pragma Saving attempts!
- (NSString *)allAttemptsArchivePath
{
	return pathInDocumentDirectory(@"allAttempts.data");
}

- (void)fetchAttemptsIfNecessary
{
	//load allAttempts array if it doesn't already exist
	//don't have an attempt
	if (!attempts)
	{
		NSString *path = [self allAttemptsArchivePath];
		attempts = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	}
	
	//looks like we've never saved anything before
	if (!attempts)
	{
		attempts = [[NSMutableArray alloc] init];
	}
}

//not synthesizing attempts property.
//here we are returning a non-mutable copy of the attempts array
-(NSArray *)attempts
{
	[self fetchAttemptsIfNecessary];
	return [NSArray arrayWithArray:attempts];
}


- (BOOL)archiveAttempts
{
	[self fetchAttemptsIfNecessary];
	return [NSKeyedArchiver archiveRootObject:attempts 
									   toFile:[self allAttemptsArchivePath]];
}

- (void)addAttempt:(HandsOffAttempt *)attempt
{
	//theoretically, there is no need to fetch.  if we are coming back to the app, it means we 
	//already loaded the array.  however, just in case -- we'll load it here.
	[self fetchAttemptsIfNecessary];
	[attempts addObject:attempt];

	//set this as the app's current attempt
	[[AppStore sharedInstance] setCurrentAttempt:attempt];
}

//gives us the ability to cancel an attempt that's underway, and remove it from the AllAttempts array
-(void)cancelCurrentAttempt
{
	NSLog(@"cancel attemtp");
	if (currentAttempt)
	{
		NSLog(@"Attempt?");
		[attempts removeObjectIdenticalTo:currentAttempt];
		currentAttempt = nil;
	}
}

- (void)eraseAllAttempts
{

	NSError *error;
	NSString *storedPath = pathInDocumentDirectory(@"allAttempts.data");
	[[NSFileManager defaultManager] removeItemAtPath:storedPath error:&error];
	
	currentAttempt = nil;
	attempts = nil;
}
@end