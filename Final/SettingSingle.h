//
//  SettingSingle.h
//  Final
//
//  Created by unbounded on 5/19/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingSingle : NSObject
+ (SettingSingle*)sharedInstance;

@property (nonatomic) NSInteger SavingCounter;

- (NSInteger) finishedreadingnewfromSingleton;

@end
