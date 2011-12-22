//
//  DisclosureDetailController.m
//  Nav
//
//  Created by Marios Mourelatos on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisclosureDetailController.h"
#import "PhotoLibraryViewController.h"


@implementation DisclosureDetailController

@synthesize label;
@synthesize message;
@synthesize photoLibraryViewController;

-(IBAction)photoAction:(id)sender
{
    if (photoLibraryViewController == nil) 
    {
        PhotoLibraryViewController *photoLib = [[PhotoLibraryViewController alloc] initWithNibName:@"PhotoLibraryViewController" bundle:[NSBundle mainBundle]];
        self.photoLibraryViewController = photoLib;
        [photoLib release];
    }
    
    [self.navigationController pushViewController:self.photoLibraryViewController animated:YES];
}



- (void)viewWillAppear:(BOOL)animated 
{ 
    label.text = message;
    [super viewWillAppear:animated];
}

- (void)viewDidUnload 
{
    self.label = nil; 
    self.message = nil; 
    [super viewDidUnload];
}

- (void)dealloc 
{
    [label release]; 
    [message release]; 
    [super dealloc];
}
@end
