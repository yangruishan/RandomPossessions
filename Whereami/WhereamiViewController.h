//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Douglas Yang on 13-4-7.
//  Copyright (c) 2013年 Douglas Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    
}

- (void)findLocation;
- (void)foundLocation:(CLLocation *)loc;

@end
