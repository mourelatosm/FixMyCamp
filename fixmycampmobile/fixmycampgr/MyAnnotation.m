//
//  MyAnnotation.m
//  fixmycampgr
//
//  Created by Marios Mourelatos on 15/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

-(NSString *)subtitle 
{
    return subtitle;
}

-(NSString *)title 
{
    return title;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
                  title:(NSString *) t
               subtitle:(NSString *) st 
{
    coordinate = c;
    self.title = t;
    self.subtitle = st;
    return self;
}

-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate
{
    coordinate = newCoordinate;
}

- (void) dealloc{
    [title release];
    [subtitle release];
    [super dealloc];
}

@end