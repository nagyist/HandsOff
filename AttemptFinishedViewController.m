//
//  AttemptFinishedViewController.m
//  HandsOff
//
//  Created by Matthew Holden on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AttemptFinishedViewController.h"

@implementation AttemptFinishedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAttempt:(HandsOffAttempt *)attempt
{
	self = [self initWithNibName:nil bundle:nil];
	//set local variable that represents our attempt
	myAttempt = attempt;
	
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//set the message label at the top
	if ([myAttempt wasSuccessful])
		[messageLabel setText:@"Nicely done!"];
	else
		[messageLabel setText:@"Epic fail!"];
	
	//set goal / actual labels
	[actualTimeLabel setText:timeStringFromTimeInterval([myAttempt completedLength])];
	[goalTimeLabel setText:timeStringFromTimeInterval([myAttempt attemptedLength])];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	messageLabel = nil;
	goalTimeLabel = nil;
	actualTimeLabel = nil;
	myAttempt = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-(void)userReturnedToAppFromAttempt:(HandsOffAttempt *)attempt
//{
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!" 
//													message:@"Best iPhoner ever"
//												   delegate:self
//										  cancelButtonTitle:@"I AM GOD" 
//										  otherButtonTitles:nil];
//	
//	//this sound shit isn't working!
//	// Converts the sound's file path to an NSURL object
//	//    NSURL *newURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error"
//	//																		   ofType:@"mp3"]];
//	//	
//	//	NSError *error;
//	//	AVAudioPlayer *errorSound = [[AVAudioPlayer alloc] initWithContentsOfURL:newURL error:&error];
//	//	
//	//	[errorSound prepareToPlay];
//	//	[errorSound setVolume:1.0];
//	//	[errorSound setDelegate:self];
//	//	[errorSound play];
//	//	[alert show];
//	
//	
//}

- (IBAction)doneButtonPressed:(id)sender;
{
	//shit-can myself ;-)
	[self dismissModalViewControllerAnimated:YES];
}

@end
