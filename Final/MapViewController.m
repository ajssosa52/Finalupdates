//
//  MapViewController.m
//  Final
//
//  Created by Thor on 4/28/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapURL;
/*
#define lat 51.434783
#define longat -0.213428
//span (zoom)

#define spans 0.01f;
*/
//@synthesize MyLocalMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
/*    MKCoordinateRegion myRegion;
    CLLocationCoordinate2D center;
    center.latitude = lat;
    center.longitude = longat;
    
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = spans;
    zoom.longitudeDelta =spans;
    
    myRegion.center = center;
    myRegion.span = zoom;
    
    [MyLocalMap setRegion:myRegion animated:YES];
    NSLog(@"test%@", MyLocalMap.overlays);
	// Do any additional setup after loading the view.
 */
}
- (void)viewWillAppear:(BOOL)animated{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.mapURL];
    self.UIWeb.scalesPageToFit = YES;
    [self.UIWeb loadRequest:request];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
