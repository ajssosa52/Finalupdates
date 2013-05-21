//
//  AddressViewController.h
//  Final
//
//  Created by Thor on 5/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *AddressNum;
@property (weak, nonatomic) IBOutlet UITextField *AddressName;
@property (nonatomic) NSInteger validAddressNum;

@end
