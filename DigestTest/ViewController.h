//
//  ViewController.h
//  DigestTest
//
//  Created by sagles on 13-1-5.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/*!
 @brief 设置登陆URL的文本框
 */
@property (retain, nonatomic) IBOutlet UITextField *loginURLTextField;
/*!
 @brief 设置用户名
 */
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
/*!
 @brief 设置用户密码
 */
@property (retain, nonatomic) IBOutlet UITextField *passWordTextField;
/*!
 @brief 登陆用按钮
 */
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@end
