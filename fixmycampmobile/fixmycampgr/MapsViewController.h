//
//  MapsViewController.h
//  fixmycampgr
//
//  Created by Marios Mourelatos on 8/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "MyAnnotation.h"

@interface MapsViewController : UIViewController     <CLLocationManagerDelegate,MKMapViewDelegate>//adopting protocols <...>
{
    IBOutlet UIButton *btnShowLocation;
    IBOutlet UIButton *btnShowAnnotation;
    IBOutlet MKMapView *mapView;
    
    IBOutlet UITextField *accuracyTextField;
	IBOutlet UITextField *latitudeTextField;
	IBOutlet UITextField *longitudeTextField;
    CLLocationManager *lm;
    MKCoordinateRegion reg;
    MyAnnotation *annotation;
}

@property(nonatomic, retain) UIButton *btnShowLocation;
@property(nonatomic, retain) UIButton *btnShowAnnotation;
@property(nonatomic, retain) MKMapView *mapView;

@property (nonatomic) MKCoordinateRegion reg;
@property (retain, nonatomic) CLLocationManager *lm;
@property (retain, nonatomic) UITextField *accuracyTextField;
@property (retain, nonatomic) UITextField *latitudeTextField;
@property (retain, nonatomic) UITextField *longitudeTextField;

-(IBAction) showLocation:(id)sender;
-(IBAction) showAnnotation:(id)sender;

@end
