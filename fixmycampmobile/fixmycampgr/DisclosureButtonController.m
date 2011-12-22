//
//  DisclosureButtonController.m
//  Nav
//
//  Created by Marios Mourelatos on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisclosureButtonController.h"
#import "NavAppAppDelegate.h"
#import "DisclosureDetailController.h"

@implementation DisclosureButtonController

@synthesize list;

- (void)viewDidLoad {
    NSLog (@"viewDidLoad");
    NSArray *array = [[NSArray alloc] initWithObjects:@"Grafiti", @"Aporimata", @"Xalasmeno Fanari", @"Provlimata simanshs", @"Kakos Fotismos", @"Lakouves Sto Odostroma", @"Katestrameno Odostroma", @"Katestrameno Pezodromio", @"Voulomena Freatia", @"Ladia Ston Dromo", @"Spasmenos Agogos Idreushs", nil];
    self.list = array; [array release]; [super viewDidLoad];
}

- (void)viewDidUnload 
{ 
    NSLog (@"viewDidUnload");
    self.list = nil;
    [childController release], childController = nil;
}

- (void)dealloc 
{ 
    NSLog (@"dealloc");
    [list release]; 
    [childController release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    NSLog (@"numberOfRowsInSection:");
    return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSLog (@"cellForRowAtIndexPath:");
    static NSString * DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DisclosureButtonCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonCellIdentifier] autorelease];
    }
    NSUInteger row = [indexPath row];
    NSString *rowString = [list objectAtIndex:row];
    cell.textLabel.text = rowString;//edw einai pou ginetai h emfanish sthn othonh tou kimenou sto label
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; //auto kathorizei to velaki deksia
    [rowString release];
    return cell;
}

#pragma mark -
#pragma mark Table Data Source Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSLog (@"didSelectRowAtIndexPath:");
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle: @"Hey, do you see the disclosure button?" message:@"If you're trying to drill down, touch that instead" 
                          delegate:nil 
                          cancelButtonTitle:@"Won't happen again" 
                          otherButtonTitles:nil]; 
    [alert show];
    [alert release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 
     NSLog (@"accessoryButtonTappedForRowWithIndexPath:");
    
    if (childController == nil)
    {
        childController = [[DisclosureDetailController alloc] initWithNibName:@"DisclosureDetail" bundle:nil];
    }
    
    childController.title = @"Disclosure Button Pressed";
    
    NSUInteger row = [indexPath row];
    NSString *selectedMovie = [list objectAtIndex:row]; 
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"You pressed the disclosure button for %@.", selectedMovie];
    childController.message = detailMessage; 
    childController.title = selectedMovie;
    [detailMessage release];
    [self.navigationController pushViewController:childController animated:YES];
}



@end