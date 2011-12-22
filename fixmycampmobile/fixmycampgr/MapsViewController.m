//
//  MapsViewController.m
//  fixmycampgr
//
//  Created by Marios Mourelatos on 8/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapsViewController.h"


@implementation MapsViewController

@synthesize btnShowLocation;
@synthesize btnShowAnnotation;
@synthesize mapView;

@synthesize reg;
@synthesize lm;
@synthesize latitudeTextField;
@synthesize longitudeTextField;
@synthesize accuracyTextField;



-(IBAction)showLocation:(id)sender
{
    if([[btnShowLocation titleForState:UIControlStateNormal] isEqualToString:@"Show My Location"])
    {
        [btnShowLocation setTitle:@"Hide My Location"forState:UIControlStateNormal]; 
        mapView.showsUserLocation = YES;
        [mapView setRegion:reg animated:YES];
        NSLog(@"5");
        
    }
    else
    {
        [btnShowLocation setTitle:@"Show My Location" forState:UIControlStateNormal];
        mapView.showsUserLocation = NO;
    }
}

-(IBAction)showAnnotation:(id)sender
{
    if([[btnShowAnnotation titleForState:UIControlStateNormal] isEqualToString:@"Show My Annotations"])
    {
        [btnShowAnnotation setTitle:@"Hide My Annotations"forState:UIControlStateNormal];
        NSString *lat = [[NSString alloc] initWithFormat:@"%f", reg.center.latitude];
        latitudeTextField.text = lat; 
        
        //—-display longitude—-
        NSString *lng = [[NSString alloc] initWithFormat:@"%f", reg.center.longitude];
        longitudeTextField.text = lng;
        
        annotation = [[MyAnnotation alloc] initWithCoordinate:reg.center
                                                        title:@"coor place"
                                                     subtitle:[NSString	stringWithFormat:@"Lat: %@. Lng: %@",latitudeTextField.text, longitudeTextField.text]];
        [mapView addAnnotation:annotation];	
    }
    else
    {
        [btnShowAnnotation setTitle:@"Show My Annotations" forState:UIControlStateNormal];
       // [mapView removeAnnotations:self.mapView.annotations];
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
        for (id annotation1 in mapView.annotations)
            if (annotation1 != mapView.userLocation)
                [toRemove addObject:annotation];
        [mapView removeAnnotations:toRemove];
    }
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"view did load");
    
    self.lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm startUpdatingLocation];
    //---connect the delegate of MKMapView object to 
    // this view controller  programmatically; you can also connect
    // it via Interface Builder---
    mapView.delegate = self;
    mapView.mapType = MKMapTypeHybrid;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *lat = [[NSString alloc] initWithFormat:@"%f", reg.center.latitude];
    latitudeTextField.text = lat; 
    
    //—-display longitude—-
	NSString *lng = [[NSString alloc] initWithFormat:@"%f", reg.center.longitude];
	longitudeTextField.text = lng;
        
        annotation = [[MyAnnotation alloc] initWithCoordinate:reg.center
                                                        title:@"coor place"
                                                     subtitle:[NSString	stringWithFormat:@"Lat: %@. Lng: %@",latitudeTextField.text, longitudeTextField.text]];
        [mapView addAnnotation:annotation];	
        //[annotation moveAnnotation:reg.center];

    
}

//kaleitai opote dexetai nea dedomena apo to gps
- (void) locationManager:(CLLocationManager *) manager
     didUpdateToLocation:(CLLocation *) newLocatio
            fromLocation:(CLLocation *) oldLocation 
{
    NSLog(@"location manager");
    //—-display latitude—-
    NSString *lat = [[NSString alloc] initWithFormat:@"%f", newLocatio.coordinate.latitude];
    latitudeTextField.text = lat; 
    
    //—-display longitude—-
	NSString *lng = [[NSString alloc] initWithFormat:@"%f", newLocatio.coordinate.longitude];
	longitudeTextField.text = lng;
    
    //—-display accuracy—-
	NSString *acc = [[NSString alloc] initWithFormat:@"%f", newLocatio.horizontalAccuracy];
    accuracyTextField.text = acc;
    
    [acc release];
    [lat release];
    [lng release];
    
    //—-update the map—-
	NSLog(@"update the map");
    MKCoordinateSpan span;	
    span.latitudeDelta=.02;	
    span.longitudeDelta=.02;	
	reg.center = newLocatio.coordinate;
	reg.span = span;
//  [mapView setRegion:reg animated:YES];
//	[mapView setRegion:region animated:TRUE];

    
/*    //—-display an annotation here—-	
    if (annotation) 
    {		
        [annotation moveAnnotation:newLocatio.coordinate];				
    }	
    else 
    {		
        annotation = [[MyAnnotation alloc] initWithCoordinate:newLocatio.coordinate
                                                        title:@"You are here"
                                                     subtitle:[NSString	stringWithFormat:@"Lat: %@. Lng: %@",latitudeTextField.text, longitudeTextField.text]];
        [mapView addAnnotation:annotation];		
    }*/	

}


- (void) locationManager:(CLLocationManager *) manager
        didFailWithError:(NSError *) error 
{
    NSString *msg = [[NSString alloc] initWithString:@"Error obtaining location"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
													message:msg
												   delegate:nil
										  cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];	
    [alert show];	
    [msg release];	
    [alert release];	
}

//when the zoom level of the map changes the mapView:regionWillChangeAnimated: event is fired
-(void)mapView:(MKMapView *)mv regionWillChangeAnimated:(BOOL)animated 
{
    //—-print out the region span - aka zoom level—-
    MKCoordinateRegion region = mapView.region;
    NSLog(@"%f",region.span.latitudeDelta);
    NSLog(@"%f",region.span.longitudeDelta);
}


- (void)dealloc 
{
    [annotation release];
    [lm release];
    [latitudeTextField release];
    [longitudeTextField release];
    [accuracyTextField release];
	[mapView release];	
    [btnShowLocation release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
