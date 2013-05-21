//
//  ResultTableViewController.h
//  Final
//
//  Created by Thor on 5/12/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "Contributor.h"
#import "propertyData.h"
#import "ResultViewController.h"

@interface ResultTableViewController : UITableViewController

@property (strong, nonatomic) NSString *streetName;

@property (nonatomic) NSInteger addressNumber;

@property (strong, nonatomic) NSNumber *locatLat;

@property (strong, nonatomic) NSNumber *locatLong;

@property (strong, nonatomic) NSString *county;

@property (nonatomic) NSInteger searchmethod;

@property (strong, nonatomic) NSMutableArray *searchTable;

@property (strong, nonatomic) NSString *currentelement;
@property (strong, nonatomic) NSString *pastelement;


@end
