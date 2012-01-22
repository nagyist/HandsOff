//
//  HandsOffAppDelegate.h
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HandsOffMainViewController;
@class AttemptFinishedViewController;
@interface HandsOffAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HandsOffMainViewController *mainViewController;

@end
