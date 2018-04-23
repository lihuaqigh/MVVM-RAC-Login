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
@property (nonatomic, strong) RACSignal *loginSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end
