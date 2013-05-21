//
//  DataStorage.m
//  Final
//
//  Created by unbounded on 5/19/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "DataStorage.h"

@implementation DataStorage


- (id) init{
    self = [super init];
    NSLog(@"hi");
    if (self) {
        NSLog(@"hi");

        NSString *docDirectory;
        NSArray *dirPath;
        
        dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docDirectory = [dirPath objectAtIndex:0];
        
        self.databasePath = [[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"recentproperties.db"]];
        
        NSFileManager *FileManager =[NSFileManager defaultManager];
        
        if ([FileManager fileExistsAtPath:self.databasePath] == NO) {
            const char *dbPath = [self.databasePath UTF8String];
            if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
                char *errMsg;
                
                const char *sql_start="CREATE TABLE IF NOT EXISTS RECENTPROPERTIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, PROPURL TEXT, PROPNAME TEXT, OWNERNAME TEXT, OWNERMAIL TEXT, OWNERMAILCITY TEXT, PARCELNUM TEXT, TAXDISTRICT TEXT, PCLASS TEXT, ACRES TEXT, CREATED DATETIME)";
                if (sqlite3_exec(propertyDB, sql_start, NULL, NULL, &errMsg) != SQLITE_OK) {
                    NSLog(@"Failed to create table");
                }sqlite3_close(propertyDB);
                
            }else{
                NSLog(@"Failed to open/create database");
            }
        }
    }
    return self;
    
}
-(void)saveToDB:(NSArray *)propertyDetails{
    sqlite3_stmt *statement;
    const char *dbPath = [self.databasePath UTF8String];
    //NSDateFormatter *dateform =[[NSDateFormatter alloc] init];
    //[dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString *date = [dateform stringFromDate:((NSDate *)[propertyDetails objectAtIndex:9])];
    //sqlite3_bind_text(statement, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
    
    if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
        NSString *insertSQL = [[NSString alloc]initWithFormat:
                               @"INSERT INTO RECENTPROPERTIES (propurl ,propname, ownername, ownermail, ownermailcity, parcelnum, taxdistrict, pclass, acres, created) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",
                               [propertyDetails objectAtIndex:0],[propertyDetails objectAtIndex:1],[propertyDetails objectAtIndex:2],[propertyDetails objectAtIndex:3],[propertyDetails objectAtIndex:4],[propertyDetails objectAtIndex:5],[propertyDetails objectAtIndex:6],[propertyDetails objectAtIndex:7],[propertyDetails objectAtIndex:8],[propertyDetails objectAtIndex:9]];
        NSLog(@"%@",insertSQL);
        const char *insert_start = [insertSQL UTF8String];
        sqlite3_prepare_v2(propertyDB, insert_start, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Contact added");

        }else{
            NSLog(@"Failed to add Contact");
        }
        
    }
    [self adjustDBtoSettings];
    
}

-(void) adjustDBtoSettings{
    self.Settings = [SettingSingle sharedInstance];
    NSLog(@"Selected %d",[self.Settings finishedreadingnewfromSingleton]);
    sqlite3_stmt *statement;
    const char *dbPath = [self.databasePath UTF8String];
    int count = 0;
    if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
        NSString *countSQL = [[NSString alloc]initWithFormat:
                               @"SELECT COUNT(*) FROM RECENTPROPERTIES"];
        NSLog(@"%@",countSQL);
        const char *count_start = [countSQL UTF8String];
        if(sqlite3_prepare_v2(propertyDB, count_start, -1, &statement, NULL)== SQLITE_OK){
            if(sqlite3_step(statement) == SQLITE_ROW){
                NSLog(@"ROWS %i",sqlite3_column_int(statement, 0));
                count =sqlite3_column_int(statement, 0);
            }else{
                NSLog(@"ERROR %s", sqlite3_errmsg(propertyDB));
            }
        }else{
            NSLog(@"ERROR");
        }

        
    }
    if (count != 0) {
        [self deleteOldest:(count-[self.Settings finishedreadingnewfromSingleton])];
    }
}

-(void) deleteOldest:(NSInteger)counter{
    NSLog(@"delete %d", counter );
    int i =0;
    while (i < counter) {
        sqlite3_stmt *statement;
        const char *dbPath = [self.databasePath UTF8String];
        NSString *oldestVal = @"";
        //NSDate *oldest;
        if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
            //NSString *deleteSQL = [[NSString alloc]initWithFormat:@"DELETE FROM RECENTPROPERTIES WHERE created=(SELECT MIN(created) FROM RECENTPROPERTIES)"];
            NSString *selectSQL = [[NSString alloc]initWithFormat:@"SELECT MIN(created) FROM RECENTPROPERTIES"];
            NSLog(@"%@",selectSQL);
            const char *insert_start = [selectSQL UTF8String];
            sqlite3_prepare_v2(propertyDB, insert_start, -1, &statement, NULL);
            if(sqlite3_step(statement) == SQLITE_ROW){
                
              
                NSLog(@"ROWS %s",sqlite3_column_text(statement, 0));
                oldestVal = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
               /* NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
                [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                NSDate *val= [dateFormater dateFromString:oldestVal];
                [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSLog(@"oldval %@  val %@",oldestVal,val);
                NSString *deleteSQL = [[NSString alloc]initWithFormat:@"DELETE FROM RECENTPROPERTIES WHERE created=\"%@\"",val];
            
                NSLog(@"%@",deleteSQL);
                const char *delete_start = [deleteSQL UTF8String];
                sqlite3_prepare_v2(propertyDB, delete_start, -1, &statement, NULL);
                if(sqlite3_step(statement) == SQLITE_ROW){
                    //NSLog(@"ROWS %s",sqlite3_column_text(statement, 0));
                    //oldestVal = (const char*)sqlite3_column_text(statement, 0);
                    NSLog(@"Contact Delete");
                }else{
                    NSLog(@"Failed to Delete Contact");
                }
                */
            }else{
                NSLog(@"Failed to Delete Contact");
            }
            
        }
        if (oldestVal != NULL) {
            sqlite3_stmt *statement2;
            const char *dbPath2 = [self.databasePath UTF8String];
            //NSDate *oldest;
            if (sqlite3_open(dbPath2, &propertyDB) == SQLITE_OK) {
 
                NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
                [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss zzzz"];
                //[dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                NSDate *val= [dateFormater dateFromString:oldestVal];
                NSLog(@"oldval %@  val %@",oldestVal,val);
                NSString *deleteSQL = [[NSString alloc]initWithFormat:@"DELETE FROM RECENTPROPERTIES WHERE created='%@'",val];
                     
                NSLog(@"%@",deleteSQL);
                const char *delete_start = [deleteSQL UTF8String];
                sqlite3_prepare_v2(propertyDB, delete_start, -1, &statement2, NULL);
                
                if(sqlite3_step(statement2) == SQLITE_DONE){
                     //NSLog(@"ROWS %s",sqlite3_column_text(statement, 0));
                     //oldestVal = (const char*)sqlite3_column_text(statement, 0);
                     NSLog(@"Contact Delete");
                }else{
                     NSLog(@"Failed to Delete Contact");
                }
                
                
            }

        }
        
        i++;
    }
}
-(NSMutableArray *)readBasicFromDataBase{
    sqlite3_stmt *statement;
    NSMutableArray *BasicInfoArray = [[NSMutableArray alloc] init];
    NSArray *BasicProp;
    const char *dbPath = [self.databasePath UTF8String];
    if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
        NSString *querySQL= [NSString stringWithFormat:@"SELECT propurl ,propname, ownername FROM RECENTPROPERTIES "];
        const char *query_start = [querySQL UTF8String];
        if(sqlite3_prepare_v2(propertyDB, query_start, -1, &statement, NULL)== SQLITE_OK){
            while(sqlite3_step(statement) == SQLITE_ROW){
                NSString *propurl= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *propname= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ownername= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];

                BasicProp = [[NSArray alloc] initWithObjects:propurl, propname, ownername, nil];
                [BasicInfoArray addObject:BasicProp];
                NSLog(@"Match Found");
            }//else{
            //    NSLog(@"Match Not Found");
            //}
            sqlite3_finalize(statement);
        }
        sqlite3_close(propertyDB);
        
    }
    return  BasicInfoArray;
}
-(NSArray *)readDetailFromDataBase:(NSString *) propertyUrl{
    sqlite3_stmt *statement;
    NSArray *detailInfo;
    const char *dbPath = [self.databasePath UTF8String];
    if (sqlite3_open(dbPath, &propertyDB) == SQLITE_OK) {
        NSString *querySQL= [NSString stringWithFormat:@"SELECT propname, ownername, ownermail, ownermailcity, parcelnum, taxdistrict, pclass, acres FROM RECENTPROPERTIES WHERE popurl=\"%@\"", propertyUrl];
        const char *query_start = [querySQL UTF8String];
        if(sqlite3_prepare_v2(propertyDB, query_start, -1, &statement, NULL)== SQLITE_OK){
            if(sqlite3_step(statement) == SQLITE_ROW){
                NSString *propname= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *ownername= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ownerMail= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *ownerMailCity= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *parcelNum= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *taxDist= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *pClass= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *acres= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                detailInfo = [[NSArray alloc] initWithObjects:propertyUrl, propname, ownername, ownerMail, ownerMailCity, parcelNum,taxDist,pClass,acres, nil];
                NSLog(@"Match Found");
            }else{
                NSLog(@"Match Not Found");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(propertyDB);
        
    }
    return detailInfo;
}


@end
