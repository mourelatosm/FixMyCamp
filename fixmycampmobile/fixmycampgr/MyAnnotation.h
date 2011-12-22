//
//  MyAnnotation.h
//  fixmycampgr
//
//  Created by Marios Mourelatos on 15/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
                  title:(NSString *) t
               subtitle:(NSString *) st;
-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate;


-(NSString *)subtitle;
-(NSString *)title;


@end
