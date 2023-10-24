//
//  DatabaseManager.h
//  xSwiftlib
//
//  Created by pwrd on 2023/5/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (instancetype)shared;

- (void)createTables;

@end

NS_ASSUME_NONNULL_END
