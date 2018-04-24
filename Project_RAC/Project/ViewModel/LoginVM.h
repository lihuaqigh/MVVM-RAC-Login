//
//  LoginVM.h
//  IGListDemo
//
//  Created by lhq on 2018/4/11.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVM : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) RACSignal *validLoginSignal;      // 合法的用户名和密码
@property (nonatomic, strong) RACCommand *loginCommand;         // RACCommand登录操作
@property (nonatomic, strong) RACSignal *loginSignal;           // RACSignal登录操作
@end

// RACCommand 1，执行一次操作为完成的时候，不能执行多次再次执行 2按钮的Enabled属性可以关联RACCommand，3按钮自带RACCommand信号。
