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

- (RACCommand *)loginCommand{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:self.loginSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@"网络请求回来的数据"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _loginCommand;
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
    
    self.loginSignal = [RACSignal combineLatest:@[self.validUsernameSignal, self.validPasswordSignal]
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
