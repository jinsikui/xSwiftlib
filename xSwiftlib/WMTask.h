

#import <Foundation/Foundation.h>

typedef enum WMTaskStatus{
    WMTaskStatusInitial = 0,
    WMTaskStatusExecuting,
    WMTaskStatusCanceled,
    WMTaskStatusCompleted
} WMTaskStatus;

NS_ASSUME_NONNULL_BEGIN

@interface WMTaskHandle : NSObject
/// 任务状态
@property(nonatomic) WMTaskStatus status;
/// 取消
- (void)cancel;

@end

/**
 快捷调用方式
 **/
@interface WMTask : NSObject

/// 如果在主线程就同步执行，否则异步主线程执行
+ (void)executeMain:(void(^)(void))task;

/// 异步主线程，会立刻执行
+ (void)asyncMain:(void(^)(void))task;

/// 异步非主线程，会立刻执行
+ (void)asyncGlobal:(void(^)(void))task;

/// 异步，会立刻执行
/// @param queue 执行线程
/// @param task 任务
+ (void)async:(dispatch_queue_t)queue task:(void(^)(void))task;

/// 异步主线程延迟执行，会立刻开始算延迟
/// @param seconds 延迟秒数
/// @param task 任务
+ (WMTaskHandle*)asyncMainAfter:(double)seconds task:(void(^)(void))task;

/// 异步非主线程延迟执行，会立刻开始算延迟
/// @param seconds 延迟秒数
/// @param task 任务
+ (WMTaskHandle*)asyncGlobalAfter:(double)seconds task:(void(^)(void))task;

/// 异步queue延迟执行，会立刻开始算延迟
/// @param queue 执行线程
/// @param seconds 延迟秒数
/// @param task 任务
+ (WMTaskHandle*)async:(dispatch_queue_t)queue after:(double)seconds task:(void(^)(void))task;

@end

NS_ASSUME_NONNULL_END
