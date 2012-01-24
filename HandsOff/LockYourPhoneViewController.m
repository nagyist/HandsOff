//
//  LockYourPhoneViewController.m
//  HandsOff
//
//  Created by Matthew Holden on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LockYourPhoneViewController.h"

@implementation LockYourPhoneViewController


#pragma mark "Cancel attempt"
-(void)cancelAttempt
{
	//cancel the timer
	[lockPhoneCountdown invalidate];
	lockPhoneCountdown = nil;
	
	//tell teh application that the attempt current in question is null&void;
	[[AppStore sharedInstance] cancelCurrentAttempt];
	
	[self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
	[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)cancelAttempt:(id)sender
{
	[self cancelAttempt];
}

#pragma mark "boilerplate shizzle"
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAttempt:(HandsOffAttempt *)newAttempt
{
	self = [self initWithNibName:nil bundle:nil];
	attempt = newAttempt;
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)timerTick:(NSTimer *)timer
{
	timerTickCount++;
	
	if (timerTickCount == lockPhoneCountdownLength)
	{
		[timer invalidate];
		
		//cancel this screen.
		[self cancelAttempt];
	} 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	lockPhoneCountdownLength = 6;	
	
    // Do any additional setup after loading the view from its nib.

	//use this attempt object to set the text
	NSString *dontComeBackString = [NSString stringWithFormat:@"Don't come back for %@", timeStringFromTimeInterval([attempt attemptedLength])];
	[dontComeBackLabel setText:dontComeBackString];	


	// if they don't lock the phone in 5 seconds we'll cancel the attempt
	lockPhoneCountdown = [NSTimer scheduledTimerWithTimeInterval:1
														  target:self
														selector:@selector(timerTick:)
														userInfo:nil
														 repeats:YES];
}

- (void)viewDidUnload
{
    dontComeBackLabel = nil;
	countdownLabel = nil;
	attempt = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
