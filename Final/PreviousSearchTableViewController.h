//
//  PreviousSearchTableViewController.h
//  Final
//
//  Created by unbounded on 5/20/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStorage.h"
@interface PreviousSearchTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *DatebaseArray;

@property (strong, nonatomic) DataStorage *DataMang;

@end
