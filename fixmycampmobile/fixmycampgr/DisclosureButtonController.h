//
//  DisclosureButtonController.h
//  Nav
//
//  Created by Marios Mourelatos on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h" 
@class DisclosureDetailController;

@interface DisclosureButtonController : SecondLevelViewController
{
    NSArray *list;
    DisclosureDetailController *childController;
}

@property (nonatomic, retain) NSArray *list;

@end
