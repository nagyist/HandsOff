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
	
	//make an NSDate that schedules the notification
	timeToStop = [[[NSDate alloc] init] dateByAddingTimeInterval:desiredFocusTime * 3600];
	
	//build localNotification
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	if (localNotification == nil)
		return;
	
	[localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
	[localNotification setFireDate:timeToStop];
	
	[localNotification setAlertBody:@"Woo-Hoo! You can use your phone now."];
	[localNotification setAlertAction:@"OK"]; 
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
	
	//finally, store timeToStop as the global stop time
	[[AppStore sharedInstance] setCurrentFocusTargetDate:timeToStop];
}

-(void)userFailed{
	
}

-(void)userSucceeded {
	
}

@end
