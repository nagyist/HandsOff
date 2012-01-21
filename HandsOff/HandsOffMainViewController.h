//
//  HandsOffMainViewController.h
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffFlipsideViewController.h"

@interface HandsOffMainViewController : UIViewController <HandsOffFlipsideViewControllerDelegate>
{
	
	
	__weak IBOutlet UIButton *btnTime1;
	__weak IBOutlet UIButton *btnTime2;
	__weak IBOutlet UIButton *btnTime3;
	__weak IBOutlet UIButton *btnTime4;
}
- (IBAction)showInfo:(id)sender;
- (IBAction)startTime:(id)sender;
- (void)userFailed;
- (void)userSucceeded;
@end
