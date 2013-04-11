//
//  HNNPMapPoint.m
//  Whereami
//
//  Created by Douglas Yang on 13-4-7.
//  Copyright (c) 2013年 Douglas Yang. All rights reserved.
//

#import "HNNPMapPoint.h"

@implementation HNNPMapPoint
@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self){
        coordinate = c;
        [self setTitle:t];
    }
    
    return self;
}

- (id)init{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"书呆子的老家"];
}

@end
