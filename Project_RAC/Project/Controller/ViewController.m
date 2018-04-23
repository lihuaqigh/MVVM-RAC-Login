//
//  ViewController.m
//  Project
//
//  Created by lhq on 2018/4/20.
//  Copyright © 2018年 lhq. All rights reserved.
//

#import "ViewController.h"
#import "LoginVM.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) NSMutableDictionary *mDict;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"One";
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.usernameTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordTextField];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@100);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@200);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.usernameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输出A：%@",x);
    }];
    
    [[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        NSString *text = value;
        return text.length > 3;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输出B：%@",x);
    }];
    
    [[[self.usernameTextField.rac_textSignal map:^id(NSString*text){
        return @(text.length);
    }] filter:^BOOL(NSNumber*length){
        return[length integerValue] > 3;
    }] subscribeNext:^(id x){
        NSLog(@"输出C：%@", x);
    }];
    
    RAC(self.passwordTextField,text) = [self.passwordTextField.rac_textSignal map:^id(NSString*text){
        return [NSString stringWithFormat:@"拼接一下：%@",text];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
