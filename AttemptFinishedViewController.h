//
//  AttemptFinishedViewController.h
//  HandsOff
//
//  Created by Matthew Holden on 1/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttemptFinishedViewController : UIViewController
{
	
	__weak IBOutlet UILabel *goalTimeLabel;
	__weak IBOutlet UILabel *messageLabel;
	__weak IBOutlet UILabel *actualTimeLabel;
	
	HandsOffAttempt *myAttempt;
}

- (IBAction)doneButtonPressed:(id)sender;
- (id)initWithAttempt:(HandsOffAttempt *)attempt;
@end
