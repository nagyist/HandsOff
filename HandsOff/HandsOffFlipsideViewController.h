//
//  HandsOffFlipsideViewController.h
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HandsOffFlipsideViewController;

@protocol HandsOffFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(HandsOffFlipsideViewController *)controller;
@end

@interface HandsOffFlipsideViewController : UIViewController
{
	
}

@property (weak, nonatomic) IBOutlet id <HandsOffFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
