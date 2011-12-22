//
//  NavAppAppDelegate.h
//  NavApp
//
//  Created by Marios Mourelatos on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavAppAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end
