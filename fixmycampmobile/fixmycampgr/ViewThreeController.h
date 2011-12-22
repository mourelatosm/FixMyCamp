//
//  ViewThreeController.h
//  NavApp
//
//  Created by Marios Mourelatos on 24/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewThreeController : UIViewController
{
    BOOL             _hasRegisteredObservers;
	MKMapView       *_myGreatMapView;
	UIToolbar       *_locationToolbar;
	UIBarButtonItem *_locationButton;
	BOOL             _isFollowingLocation;
}

@property (nonatomic, retain, readwrite) IBOutlet MKMapView       *myGreatMapView;
@property (nonatomic, retain, readwrite) IBOutlet UIToolbar       *locationToolbar;
@property (nonatomic, retain, readwrite) IBOutlet UIBarButtonItem *locationButton;
@property (nonatomic, assign, readwrite) BOOL                      isFollowingLocation;

- (void)followChangesToUserLocation:(BOOL)newState;
- (IBAction)setMapViewToCurrentLocation:(id)sender;

@end
