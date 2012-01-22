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
	
	//Sort that array from newest to oldest
	[attempts sortUsingComparator:^(id obj1, id obj2) {
		HandsOffAttempt *attempt1 = (HandsOffAttempt*)obj1;
		HandsOffAttempt *attempt2 = (HandsOffAttempt*)obj2;
		
		return [[attempt2 startDate] compare:[attempt1 startDate]];
	}];
	
	//get information about the attempt.  compile the data we'll need for a table cell
	HandsOffAttempt *attempt = [attempts objectAtIndex:[indexPath row]];
		
	//let's build up some date stringy things.
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.timeStyle = NSDateFormatterNoStyle;
	dateFormatter.dateStyle = NSDateFormatterShortStyle;

	//use the date formatter to get formatted startDateString
	NSString *attemptDateString = [dateFormatter stringFromDate:[attempt startDate]];
	
	//if they were successful, just display their Goal (i.e 4 hours). DON'T display the full time they were gone
	//(i.e. 4 hours, 27 minutes)
	NSMutableString *attemptLengthString = [NSMutableString stringWithString:@""];
	if ([attempt wasSuccessful])
		[attemptLengthString appendString:timeStringFromTimeInterval([attempt attemptedLength])];
	else
		[attemptLengthString appendString:timeStringFromTimeInterval([attempt completedLength])];
	
	//start to buld the table cell
	UITableViewCell *cell = 
	[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
									  reuseIdentifier:@"UITableViewCell"];
	//set text properties
	[[cell textLabel] setText:attemptLengthString];
	[[cell detailTextLabel] setText:attemptDateString];

	//chose an image based on success/fail
	if ([attempt wasSuccessful])
		[[cell imageView] 
			setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"checkmark" 
																					  ofType:@"jpg"]]];
	else
		[[cell imageView] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"redx"
																									ofType:@"jpg"]]];
	
	return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[AppStore sharedInstance] attempts] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Previous attempts";
}

-(void)clearHistory:(id)sender
{
	//erase all our previous attempts and 
	[[AppStore sharedInstance] eraseAllAttempts];
	[attemptsTable reloadData];
}


@end
