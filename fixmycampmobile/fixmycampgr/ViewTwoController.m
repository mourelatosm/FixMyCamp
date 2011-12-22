//
//  ViewTwoController.m
//  NavApp
//
//  Created by Marios Mourelatos on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewTwoController.h"
#import "ViewThreeController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonController.h"

@implementation ViewTwoController

@synthesize viewThreeController;
@synthesize controllers;

-(IBAction)switchPage:(id)sender
{
    if (viewThreeController == nil) 
    {
        ViewThreeController *viewThree = [[ViewThreeController alloc] initWithNibName:@"ViewThreeController" bundle:[NSBundle mainBundle]];
        self.viewThreeController = viewThree;
        [viewThree release];
    }
    
    [self.navigationController pushViewController:self.viewThreeController animated:YES];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"First Level";
    
    NSMutableArray *array = [[NSMutableArray alloc] init]; 
    
    // Disclosure Button
    DisclosureButtonController *disclosureButtonController = [[DisclosureButtonController alloc] initWithStyle:UITableViewStylePlain];
    disclosureButtonController.title = @"Disclosure Button"; 
    disclosureButtonController.rowImage = [UIImage imageNamed:@"traffic_lights_256.png"]; 
    [array addObject:disclosureButtonController]; 
    [disclosureButtonController release];
    
    self.controllers = array;
    [array release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //hide the navigation bar
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidUnload
{
    self.controllers = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.navigationController.navigationBarHidden=NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc 
{ 
    [controllers release]; 
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return [self.controllers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *FirstLevelCell= @"FirstLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: FirstLevelCell] autorelease];
    }
    // Configure the cell
    NSUInteger row = [indexPath row]; 
    SecondLevelViewController *controller =[controllers objectAtIndex:row]; 
    cell.textLabel.text = controller.title; 
    cell.imageView.image = controller.rowImage;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    NSUInteger row = [indexPath row];
    SecondLevelViewController *nextController = [self.controllers objectAtIndex:row]; 
    [self.navigationController pushViewController:nextController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end

