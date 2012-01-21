//
//  HandsOffAppDelegate.m
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffAppDelegate.h"
#import "HandsOffMainViewController.h"

@implementation HandsOffAppDelegate

@synthesize window = _window;
@synthesize mainViewController = _mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.mainViewController = [[HandsOffMainViewController alloc] initWithNibName:@"HandsOffMainViewController" bundle:nil];
	self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */

	//if the user just started a timer, and locked their phone, we want to make sure the
	//"Lock your Phone" message is dismissed"
	[self.mainViewController forceCloseLockYourPhoneAlert];
	
	//save array of attempts in App Store
	[[AppStore sharedInstance] saveAttempts];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */

	
	//for lack of a better place, we're going to check to see if they FAIL here
	NSDate *currentFocusTargetDate = [[AppStore sharedInstance] currentFocusTargetDate];	
	if (currentFocusTargetDate) 
	{
		NSNumber *currentFocusTimeInSeconds = [[AppStore sharedInstance] currentFocusTimeInSeconds];
		
		NSDate *now = [[NSDate alloc] init];
		//we're only storing their target date. so we'll need to calculate the time they started,
		//which is Now - currentFocusTargetDate - currentFocusTimeInSeconds
		NSDate *startTime = [[NSDate alloc] initWithTimeInterval:-(int)currentFocusTimeInSeconds sinceDate:currentFocusTargetDate];
		NSDate *endTime = now;
		
		//make new Attempt object
		bool success = [now timeIntervalSinceDate:currentFocusTargetDate] > 0;
		[[AppStore sharedInstance] addAttempt:
						[[HandsOffAttempt alloc] initWithStartDate:startTime
														   endDate:endTime 
													 wasSuccessful:success]];
		//write attempts to storage
		[[AppStore sharedInstance] saveAttempts];
		
		//now do logic to let user know if they blew it or not
		HandsOffMainViewController *rootVC = (HandsOffMainViewController *)[[self window] rootViewController];
		
		if (success)
			[rootVC userReturnedToAppVictorious];
		else
			[rootVC userReturnedToAppEarly];			
	}
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */

}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */

}

@end
