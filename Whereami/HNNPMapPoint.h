//
//  HNNPMapPoint.h
//  Whereami
//
//  Created by Douglas Yang on 13-4-7.
//  Copyright (c) 2013年 Douglas Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HNNPMapPoint : NSObject <MKAnnotation>

//HNNPMapPoint的指定初始化方法
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

//必须的属性,源自MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//可选的属性,源自MKAnnotation
@property (nonatomic, copy) NSString *title;

@end
