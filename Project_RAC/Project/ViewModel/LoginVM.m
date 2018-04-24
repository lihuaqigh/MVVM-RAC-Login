//
//  LoginVM.m
//  IGListDemo
//
//  Created by lhq on 2018/4/11.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import "LoginVM.h"

@interface LoginVM ()
@property (nonatomic, strong) RACSignal *validUsernameSignal;
@property (nonatomic, strong) RACSignal *validPasswordSignal;
@end

@implementation LoginVM

// 网络请求（登录按钮被点击）
- (RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:self.validLoginSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@"网络请求回来的数据"];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
        
//        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [subscriber sendNext:@"网络请求回来的数据"];
//                    [subscriber sendCompleted];
//                });
//                return nil;
//            }];
//        }];
    }
    return _loginCommand;
}

- (RACSignal *)loginSignal {
    if (_loginSignal == nil) {
        _loginSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"网络请求回来的数据二"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }
    return _loginSignal;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    @weakify(self);
    self.validUsernameSignal = [RACObserve(self, username) map:^id(NSString *value) {
        @strongify(self);
        return @([self isValidUsername:value]);
    }];
    
    self.validPasswordSignal = [RACObserve(self, password) map:^id(NSString *value) {
        @strongify(self);
        return @([self isValidPassword:value]);
    }];
    
    self.validLoginSignal = [RACSignal combineLatest:@[self.validUsernameSignal, self.validPasswordSignal]
                                         reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
}

- (BOOL)isValidUsername:(NSString *)text {
    if (text.length > 3) return YES;
    return NO;
}

- (BOOL)isValidPassword:(NSString *)text {
    if (text.length > 3) return YES;
    return NO;
}

@end
