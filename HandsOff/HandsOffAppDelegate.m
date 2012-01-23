//
//  HandsOffAppDelegate.m
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffAppDelegate.h"
#import "HandsOffMainViewController.h"
#import "AttemptFinishedViewController.h"

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
	[self.mainViewController dismissLockYourPhoneViewController];
	
	//save array of attempts in App Store
	[[AppStore sharedInstance] archiveAttempts];
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

	
	//we're going to check for a FAIL or WIN here.
	HandsOffAttempt *currentAttempt = [[AppStore sharedInstance] currentAttempt];	
	if (currentAttempt)
	{
		//close the attempt object. this will set teh appStore 'currentAttempt' to nil
		//and also re-archive all of our data
		[currentAttempt endAttempt];
		
		//now do logic to let user know if they blew it or not
		HandsOffMainViewController *rootVC = (HandsOffMainViewController *)[[self window] rootViewController];
		
		//call this method, which will show their totally awesome feedback
		AttemptFinishedViewController *afvc = [[AttemptFinishedViewController alloc] initWithAttempt:currentAttempt];
		[rootVC presentModalViewController:afvc animated:YES];
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
	
	[[AppStore sharedInstance] archiveAttempts];

}

@end
