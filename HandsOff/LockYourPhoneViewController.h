//
//  LockYourPhoneViewController.h
//  HandsOff
//
//  Created by Matthew Holden on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockYourPhoneViewController : UIViewController
{
	
	__weak IBOutlet UILabel *countdownLabel;
	__weak IBOutlet UILabel *dontComeBackLabel;
	
	HandsOffAttempt *attempt;
	
	//we'll give em' 10 seconds to lock their phone, or.. cancel
	NSTimer *lockPhoneCountdown;
	uint lockPhoneCountdownLength;
	
	NSUInteger timerTickCount;
}

-(id)initWithAttempt:(HandsOffAttempt *)attempt;
-(IBAction)cancelAttempt:(id)sender;
@end
