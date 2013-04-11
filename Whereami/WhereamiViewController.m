//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Douglas Yang on 13-4-7.
//  Copyright (c) 2013年 Douglas Yang. All rights reserved.
//

#import "WhereamiViewController.h"
#import "HNNPMapPoint.h"

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self){
        
        //创建CLLocationManager对象
        locationManager = [[CLLocationManager alloc] init];
        
        //这行代码会产生一处编译警告，先忽略
        [locationManager setDelegate:self];
        
        //不考虑会花费的时间和电力,要求CLLocationManager对象返回尽可能精确的数据
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        
        //要求CLLocationManager对象立刻开始工作,定位设备位置
        //[locationManager startUpdatingLocation];
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"定位：%@", newLocation);
    
    //该新位置是在多少秒之前创建的？
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    //CLLocationManager对象会先返回最近一次找到的设备位置,但是Whereami不应该使用缓存的数据.所以如果位置信息是在三分钟前得到的，就将其忽略.
    if (t < -180){
        //
        return;
    }
    
    double distance = [locationManager distanceFilter];
    if (distance < 50){
        return;
    }
    
    [self foundLocation:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"无法进行定位操作:%@",error);
}

- (void)dealloc
{
    //将locationManager的delegate设置为nil，这样，locationManager就不会向本对象发送委托消息
    [locationManager setDelegate:nil];
}

- (void)viewDidLoad
{
    [worldView setMapType:MKMapTypeStandard];
    [worldView setShowsUserLocation:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //应该在这里放大地图，但怎么实现呢？
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 2000, 2000);
    [worldView setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //findLocation方法尚未实现（很快就会）
    [self findLocation];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    //根据现有的数据创建HNNPMapPoint实例
    HNNPMapPoint *mp = [[HNNPMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    //将MapPoint实例加入worldView
    [worldView addAnnotation:mp];
    
    //根据指定位置放大地图
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 2000, 2000);
    [worldView setRegion:region animated:YES];
    
    //重置界面
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

@end
