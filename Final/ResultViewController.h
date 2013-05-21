//
//  ResultViewController.h
//  Final
//
//  Created by Thor on 5/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "Contributor.h"
//#import "SettingSingle.h"
#import "DataStorage.h"

@interface ResultViewController : UIViewController

@property (strong,nonatomic) DataStorage *DataMang;
@property (strong,nonatomic) NSArray *dataToStore;

@property (strong, nonatomic) NSString *url;
//@property (strong, nonatomic) SettingSingle *Settings;

@property (weak, nonatomic) IBOutlet UILabel *StatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ONameLabel;
@property (weak, nonatomic) IBOutlet UILabel *OMailingLabel;
@property (weak, nonatomic) IBOutlet UILabel *OMailngCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *PropertyLocation;
@property (weak, nonatomic) IBOutlet UILabel *PropertyTDist;
@property (weak, nonatomic) IBOutlet UILabel *RefNum;
@property (weak, nonatomic) IBOutlet UILabel *AcreageVal;
@property (weak, nonatomic) IBOutlet UILabel *propertyClassVal;

@end
