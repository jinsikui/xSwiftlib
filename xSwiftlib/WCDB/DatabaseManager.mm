//
//  DatabaseManager.m
//  xSwiftlib
//
//  Created by pwrd on 2023/5/1.
//

#import "DatabaseManager.h"
#import "LearntWord.h"
#import <WCDB/WCDB.h>


@interface DatabaseManager ()

@property(nonatomic, strong) WCTDatabase* database;

@end

@implementation DatabaseManager

+ (instancetype)shared {
    static DatabaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DatabaseManager alloc] init];
    });
    return instance;
}

- (WCTDatabase*)database {
    if (!_database) {
        _database = [[WCTDatabase alloc] initWithPath:[self databasePath]];
    }
    return _database;
}

- (NSString*)databasePath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [documentPath stringByAppendingPathComponent:@"xSwiftlib.db"];
    return databasePath;
}

- (void)createTables {
    [self.database createTableAndIndexesOfName:@"learnt_table" withClass:LearntWord.class];
}


@end
