//
//  SettingSingle.m
//  Final
//
//  Created by unbounded on 5/19/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "SettingSingle.h"

@implementation SettingSingle
static SettingSingle *sharedsingleton;

- (id) init{
    self = [super init];
    
    if (self) {
        [self registerDefaults];

    }
    return self;
    
}

+ (SettingSingle*)sharedInstance{
    @synchronized(self){
        if (sharedsingleton == Nil) {
            sharedsingleton = [[super allocWithZone:NULL]init];
        }
    }
    return sharedsingleton;
}
- (void) registerDefaults{
    
    NSString *settingBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(! settingBundle){
        return;
    }
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingBundle stringByAppendingPathComponent:@"Root.plist"]];
    //NSLog(@"settings%@",settings.allKeys);
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSDictionary *saveSettings = [preferences objectAtIndex:1];
    //NSLog(@"saveSettings%@",saveSettings);
    [[NSUserDefaults standardUserDefaults] registerDefaults:saveSettings];
    
}
- (NSInteger) finishedreadingnewfromSingleton{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    self.SavingCounter =[[NSUserDefaults standardUserDefaults] integerForKey:@"Lsetting"];
    
    return self.SavingCounter;
}
@end
