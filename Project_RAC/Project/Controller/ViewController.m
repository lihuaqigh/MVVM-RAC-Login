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
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) LoginVM *loginVM;
@end

@implementation ViewController
- (LoginVM *)loginVM {
    if (_loginVM == nil) {
        _loginVM = [[LoginVM alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
    [self bindModel];
}

- (void)setUpViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录界面";
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.usernameTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
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
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
}

- (void)bindModel {
    RAC(self.loginVM, username)             = self.usernameTextField.rac_textSignal;
    RAC(self.loginVM, password)             = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, backgroundColor) = [self.loginVM.loginSignal map:^id(NSNumber *valid){
        return[valid boolValue] ? [UIColor orangeColor]:[UIColor lightGrayColor];
    }];

    self.loginButton.rac_command = self.loginVM.loginCommand;
    
    [self.loginButton.rac_command.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"login..");
        } else {
            NSLog(@"end logining");
        }
    }];

    [self.loginButton.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录按钮点击：%@",x);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
