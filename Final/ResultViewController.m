//
//  ResultViewController.m
//  Final
//
//  Created by Thor on 5/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property dispatch_queue_t globalQ;
@end

@implementation ResultViewController
@synthesize url;
@synthesize DataMang;
@synthesize dataToStore;

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
    // Do any additional setup after loading the view.
    self.DataMang = [[DataStorage alloc] init];
    
    
    _globalQ =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSURL *htmlURL = [NSURL URLWithString:self.url];
    NSLog(@"url :%@",self.url);
    
    NSData *data = [NSData dataWithContentsOfURL:htmlURL];
    
    TFHpple *tableparser = [TFHpple hppleWithHTMLData:data];
    NSString *queryString = @"//table[@class='table_class']/tr/td";
    
    NSArray *propertyvals = [tableparser searchWithXPathQuery:queryString];
    //NSLog(@"Array%@",propertyvals);
    int i =0;
    int counter =-1;
    //int test =-1;
    for (TFHppleElement *element in propertyvals) {
        //NSLog(@"element%@",element.children);
        int x=0;
        if (i<75) {
            
            while (x<element.children.count) {
                //NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                if ([[[((TFHppleElement *)[element.children objectAtIndex:x]) firstChild] content] isEqualToString: @" Owner Name "]) {
                   // NSLog(@"elements values for  %d :%@",i,[element.children objectAtIndex:x]);
                   // NSLog(@"elements values for  :%@:",[[((TFHppleElement *)[element.children objectAtIndex:x]) firstChild] content]);
                    counter = 0;
                }
                if (counter>=0) {
                   // NSLog(@"counter %d", counter);
                   // NSLog(@"elements values for  %d :%@",i,[element.children objectAtIndex:x]);
                    if(counter==2){
                        self.ONameLabel.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==8){
                    //    NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.OMailingLabel.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==10){
                      //  NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.RefNum.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==12){
                        //NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.OMailngCityLabel.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==14){
                       // NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.PropertyTDist.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==16){
                        //NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.PropertyLocation.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==22){
                        //NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.AcreageVal.text = [[element.children objectAtIndex:x] content];
                        //self.
                    }else if (counter==25){
                        //NSLog(@"elements values for  %d :%@",i,[[element.children objectAtIndex:x] content]);
                        self.propertyClassVal.text = [[element.children objectAtIndex:x] content];
                    }else if (counter==36){
                        //optional map
                        self.dataToStore = [[NSArray alloc] initWithObjects:self.url,
                                            self.PropertyLocation.text, self.ONameLabel.text, self.OMailingLabel.text, self.OMailngCityLabel.text, self.RefNum.text, self.PropertyTDist.text,self.propertyClassVal.text, self.AcreageVal.text, [NSDate date ] , nil];
                        //NSTimeInterval *s = [[NSTimeInterval alloc] i:0];
                        NSLog(@"array to send %@", dataToStore);
                        [self.DataMang saveToDB:dataToStore];
                    }
                    counter++;
                }
                i++;
                x++;
            }
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
