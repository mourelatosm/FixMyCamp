//
//  RootViewController.h
//  NavApp
//
//  Created by Marios Mourelatos on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewTwoController.h"
#import "MapsViewController.h"

@interface RootViewController : UIViewController
{
    ViewTwoController *viewTwoController;
    MapsViewController *mapsViewController;
    
    UITextField *currentTextField;
    
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *email;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    
    NSXMLParser *xmlParser;
    BOOL elementFound;
    BOOL keyboardIsShown;
}

@property (nonatomic, retain) ViewTwoController *viewTwoController;
@property (nonatomic, retain) MapsViewController *mapsViewController;


@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UITextField *email;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

-(IBAction) btnSaveUser:(id)sender;

-(IBAction)switchPage:(id)sender;
-(IBAction)switchMaps:(id)sender;

@end
