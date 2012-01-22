//
//  HandsOffFlipsideViewController.m
//  HandsOff
//
//  Created by Matthew Holden on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HandsOffFlipsideViewController.h"

@implementation HandsOffFlipsideViewController

@synthesize delegate = _delegate;

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
	attemptsTable = nil;
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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

#pragma mark "UITableView protocol stuff"

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//get attempts array (make a mutable copy)
	NSMutableArray *attempts = [NSMutableArray arrayWithArray:[[AppStore sharedInstance] attempts]];

	[attempts sortUsingComparator:^(id obj1, id obj2) {
		HandsOffAttempt *attempt1 = (HandsOffAttempt*)obj1;
		HandsOffAttempt *attempt2 = (HandsOffAttempt*)obj2;

		//compare.  we don't need to worry about the two values being equal
		if([attempt1 startDate] > [attempt2 startDate])
			return (NSComparisonResult)NSOrderedDescending;
		
		return (NSComparisonResult)NSOrderedAscending;
	}];
	
	//get information about the attempt.  compile the data we'll need for a table cell
	HandsOffAttempt *attempt = [attempts objectAtIndex:[indexPath row]];
	NSLog(@"NOW I HAVE ONE %@", attempt);
	NSLog(@"With startDate: %@, and endDate: %@, and successful:%@
	
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	//get formatted startDateString
	NSString *startDateString = [dateFormatter stringFromDate:[attempt startDate]];
	//get attempt's Succesfully completed time as string with sweet-ass helper function
	NSTimeInterval actualAttemptLength = [[attempt endDate] timeIntervalSinceDate:[attempt startDate]];
	NSString *attemptLengthString = timeStringFromTimeInterval(actualAttemptLength);
	
	UITableViewCell *cell = 
	[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:@"UITableViewCell"];
	[[cell textLabel] setText:attemptLengthString];
	[[cell detailTextLabel] setText:startDateString];
	
	return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}


@end
