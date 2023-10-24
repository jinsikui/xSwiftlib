#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WordBase : NSObject

@property(nonatomic, assign) NSInteger wordId;
@property(nonatomic, retain) NSString *word;
@property(nonatomic, copy) NSString *_Nullable originId; // 单词涞源（词书id或阅读图书的id）
@property(nonatomic, assign) WordOriginType originType;  // 词书 或 用户上传的图书
@property(nonatomic, assign) NSInteger tagId;

@end

NS_ASSUME_NONNULL_END
