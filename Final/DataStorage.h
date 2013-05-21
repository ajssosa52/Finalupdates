//
//  DataStorage.h
//  Final
//
//  Created by unbounded on 5/19/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "SettingSingle.h"
@interface DataStorage : NSObject{
    sqlite3 *propertyDB;
}
@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) SettingSingle *Settings;

-(void)saveToDB:(NSArray *)propertyDetails;

-(NSMutableArray *)readBasicFromDataBase;
-(NSArray *)readDetailFromDataBase:(NSString *) propertyUrl;

@end
