

#import "WMTask.h"

@implementation WMTaskHandle

- (void)cancel{
    [self _setStatus:WMTaskStatusCanceled];
}

- (void)_setStatus:(WMTaskStatus)status{
    self.status = status;
}

@end

@protocol WMTaskProtocol

/// 任务处理
@property(nonatomic,readonly) WMTaskHandle *handle;
/// 任务状态
@property(nonatomic,readonly) WMTaskStatus status;
/// 执行任务
- (void)execute;

@end

@interface AppAsyncTask : NSObject<WMTaskProtocol>
/// 任务处理
@property(nonatomic,readonly) WMTaskHandle *handle;
/// 任务状态
@property(nonatomic,readonly) WMTaskStatus status;
/// 执行队列
@property(nonatomic,strong) dispatch_queue_t     queue;
/// 延迟时间
@property(nonatomic) double               afterSecs;
/// 执行完毕回调
@property(nonatomic) void(^task)(void);
/// 初始化
/// @param queue 队列
/// @param afterSecs 延迟
/// @param task 完成回调
- (instancetype)initWithQueue:(dispatch_queue_t)queue after:(double)afterSecs task:(void(^)(void))task;

- (void)execute;

@end

@interface AppAsyncTask() {
    WMTaskHandle *_handle;
}
@end

@implementation AppAsyncTask

- (WMTaskHandle*)handle{
    return _handle;
}

- (WMTaskStatus)status{
    return _handle.status;
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue after:(double)afterSecs task:(void(^)(void))task{
    self = [super init];
    if (!self)
        return nil;
    _handle = [[WMTaskHandle alloc] init];
    _queue = queue;
    _afterSecs = afterSecs;
    _task = task;
    return self;
}

- (void)execute{
    if (_handle.status == WMTaskStatusInitial) {
        _handle.status = WMTaskStatusExecuting;
        WMTaskHandle *hd = (WMTaskHandle *)_handle;
        void (^block)(void) = _task;
        void (^wrapperBlock)(void) = ^{
            if (hd.status == WMTaskStatusExecuting) {
                block();
                hd.status = WMTaskStatusCompleted;
            }
        };
        if (_afterSecs <= 0) {
            dispatch_async(_queue, wrapperBlock);
        }
        else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_afterSecs * NSEC_PER_SEC)), _queue, wrapperBlock);
        }
    }
}

@end


@implementation WMTask

+ (void)executeMain:(void(^)(void))task{
    if (NSThread.isMainThread) {
        task();
    }
    else{
        [self asyncMain:task];
    }
}

+ (void)asyncMain:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:dispatch_get_main_queue() task:task];
    [t execute];
}

+ (void)asyncGlobal:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) task:task];
    [t execute];
}

+ (void)async:(dispatch_queue_t)queue task:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:queue task:task];
    [t execute];
}

+ (WMTaskHandle*)asyncMainAfter:(double)seconds task:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:dispatch_get_main_queue() after:seconds task:task];
    [t execute];
    return t.handle;
}

+ (WMTaskHandle*)asyncGlobalAfter:(double)seconds task:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) after:seconds task:task];
    [t execute];
    return t.handle;
}

+ (WMTaskHandle*)async:(dispatch_queue_t)queue after:(double)seconds task:(void(^)(void))task{
    AppAsyncTask *t = [self _asyncTaskWithQueue:queue after:seconds task:task];
    [t execute];
    return t.handle;
}

+ (AppAsyncTask*)_asyncTaskWithQueue:(dispatch_queue_t)queue task:(void(^)(void))task{
    return [[AppAsyncTask alloc] initWithQueue:queue after:0 task:task];
}

+ (AppAsyncTask*)_asyncTaskWithQueue:(dispatch_queue_t)queue after:(double)seconds task:(void(^)(void))task{
    return [[AppAsyncTask alloc] initWithQueue:queue after:seconds task:task];
}


@end
