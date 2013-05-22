//
//  AddressViewController.m
//  Final
//
//  Created by Thor on 5/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "AddressViewController.h"
#import "ResultTableViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController
@synthesize  validAddressNum;

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
    validAddressNum = 0;
    self.AddressName.delegate = self;
    self.AddressNum.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AddressSearch"]) {
        /*if ([self.AddressNum.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound ) {
            
            return;
        }*/
        ResultTableViewController *secondVC= (ResultTableViewController *)segue.destinationViewController;
        secondVC.searchmethod = 0;
        if (self.AddressName.text == NULL) {
            secondVC.streetName =@"";
        }else{
            secondVC.streetName = self.AddressName.text;
        }
        if (![self.AddressNum.text isEqualToString:@""]) {
            secondVC.addressNumber = [self.AddressNum.text intValue];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
@end
