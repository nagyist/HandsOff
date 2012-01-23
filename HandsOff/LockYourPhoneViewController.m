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
	//we set in here how long we want this timer to be;
	//RIGHT HERE
	//THIS IS WHERE THAT PIECE OF INFORMATION YOU ARE LOOKING FOR IS
	int timerLength = 8;	
	//increment tick counter
	timerTickCount++;
	
	if (timerTickCount == timerLength)
	{
		[timer invalidate];
		NSLog(@"timer ticked dowN");
		
		//cancel this screen.
		[self cancelAttempt];
	} 
	else 
	{
		//update the view
		[countdownLabel setText:[NSString stringWithFormat:@"%d", timerLength - timerTickCount]];
	}
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

	//use this attempt object to set the text
	NSString *dontComeBackString = [NSString stringWithFormat:@"Don't come back for %@", timeStringFromTimeInterval([attempt attemptedLength])];
	[dontComeBackLabel setText:dontComeBackString];	

	//start the time-ticking thing.  in X seconds (determined inside the method 'timerTick'),
	//we will cancel their attempt. obviously they weren't interested in using our app... ;(
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
