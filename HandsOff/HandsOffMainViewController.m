//
//  HandsOffMainViewController.m
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffMainViewController.h"
#import "AppStore.h"

@implementation HandsOffMainViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{

	btnTime1 = nil;
	btnTime2 = nil;
	btnTime3 = nil;
	btnTime4 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(HandsOffFlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    HandsOffFlipsideViewController *controller = [[HandsOffFlipsideViewController alloc] initWithNibName:@"HandsOffFlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

#pragma mark - my stuff
- (IBAction)startTime:(id)sender 
{
	UIButton *buttonPressed = (UIButton*)sender;
	//build a list of all the possible pause times
	NSMutableDictionary *times = [[NSMutableDictionary alloc] init];
	
	//dev mode: 5 second delay for 1st button
	[times setValue:[NSNumber numberWithFloat:0.0015] forKey:@"btnTime1"];

	//production. 30 minute delay
	//[times setValue:[NSNumber numberWithFloat:0.5] forKey:@"btnTime1"];
	[times setValue:[NSNumber numberWithFloat:1.0] forKey:@"btnTime2"];
	[times setValue:[NSNumber numberWithFloat:2.0] forKey:@"btnTime3"];
	[times setValue:[NSNumber numberWithFloat:4.0] forKey:@"btnTime4"];

	//declare an int that represents the number of desired seconds of focus time
	float desiredFocusTime;
	int desiredFocusTimeInSeconds;
	//declare an date that represents when the system will let you know that you've succeeded
	NSDate *timeToStop;
	
	if (buttonPressed == btnTime1) {
		desiredFocusTime = [[times objectForKey:@"btnTime1"] floatValue];
	} else if (buttonPressed == btnTime2) {
		desiredFocusTime = [[times objectForKey:@"btnTime2"] floatValue];		
	} else if (buttonPressed == btnTime3) {		
		desiredFocusTime = [[times objectForKey:@"btnTime3"] floatValue];
 	} else if (buttonPressed == btnTime4) {
		desiredFocusTime = [[times objectForKey:@"btnTime4"] floatValue];		
	}
	
	desiredFocusTimeInSeconds = (NSTimeInterval)(desiredFocusTime * 3600);
	
	//make an NSDate that schedules the notification
	timeToStop = [[[NSDate alloc] init] dateByAddingTimeInterval:desiredFocusTimeInSeconds];
	
	//build localNotification
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	if (localNotification == nil)
		return;
	
	[localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
	[localNotification setFireDate:timeToStop];
	
	[localNotification setAlertBody:@"Woo-Hoo! You can use your phone now."];
	[localNotification setAlertAction:@"OK"]; 
	[localNotification setSoundName:UILocalNotificationDefaultSoundName];
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
	
	//build a new attempt object and set it as the current Attempt
	HandsOffAttempt *newAttempt = [[HandsOffAttempt alloc] initWithDesiredLength:desiredFocusTimeInSeconds];
	
	//if there was a current attempt in memory already -- it's probably because we're in dev mode with only a 5-second timer
	//to make sure nothing is messed up, we'll close the current attempt.  Yay -- you won ;)
	if ([[AppStore sharedInstance] currentAttempt]){
		[[[AppStore sharedInstance] currentAttempt] endAttempt];
	}

	//add this new attempt to the Application Store
	[[AppStore sharedInstance] addAttempt:newAttempt];

	//tell user to lock their phone
	if (lockYourPhoneVC)
	{
		lockYourPhoneVC = nil;
	}
	//lock your phone
	lockYourPhoneVC = [[LockYourPhoneViewController alloc] initWithAttempt:newAttempt];
	//show this message modally.  it will get closed when the App resigns active focus

	[lockYourPhoneVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
	[self presentModalViewController:lockYourPhoneVC animated:YES];
}

//when the user get's the "LOCK YOUR PHONE" instruction, they cannot dismiss it.  However, when
//they lock their phone, ApplicationWillResignActive is called in the App Delegate.  we'll call this method
//from there to dismiss the view controller
-(void)dismissLockYourPhoneViewController
{
	if (lockYourPhoneVC)
	{
		[lockYourPhoneVC dismissModalViewControllerAnimated:NO];
		lockYourPhoneVC = nil;
	}
}

#pragma mark AVAudioPlayerDelegate methods
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{}

@end
