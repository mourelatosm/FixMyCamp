//
//  DisclosureDetailController.h
//  Nav
//
//  Created by Marios Mourelatos on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoLibraryViewController.h"


@interface DisclosureDetailController : UIViewController 
{ 
    UILabel *label;
    NSString *message;
    PhotoLibraryViewController *photoLibraryViewController;
}

@property (nonatomic, retain) IBOutlet UILabel *label; 
@property (nonatomic, copy) NSString *message;
@property (nonatomic, retain) PhotoLibraryViewController *photoLibraryViewController;

-(IBAction)photoAction:(id)sender;


@end

