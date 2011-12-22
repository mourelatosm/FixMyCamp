//
//  ViewTwoController.h
//  NavApp
//
//  Created by Marios Mourelatos on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewThreeController.h"

@interface ViewTwoController : UIViewController
{
    ViewThreeController *viewThreeConroller;
    NSArray *controllers;
}

@property (nonatomic, retain) ViewThreeController *viewThreeController;
@property (nonatomic, retain) NSArray *controllers;

-(IBAction)switchPage:(id)sender;


@end
