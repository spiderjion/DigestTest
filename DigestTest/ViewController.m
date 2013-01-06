//
//  ViewController.m
//  DigestTest
//
//  Created by sagles on 13-1-5.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import "ViewController.h"
#import "BusinessLogicController.h"

@interface ViewController ()

/*!
 @brief     业务逻辑层
 */
@property (nonatomic, retain) BusinessLogicController *blController;

@end

@implementation ViewController

- (void)dealloc
{
    [_loginURLTextField release];
    [_userNameTextField release];
    [_passWordTextField release];
    [_loginButton release];
    [_blController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.blController = [BusinessLogicController blController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digestLogin:(id)sender
{
    NSURL *url = nil;
    url = _loginURLTextField.text > 0 ?
    [NSURL URLWithString:_loginURLTextField.text] :
    [NSURL URLWithString:@"http://digest.boxfishedu.com/auth"];
    
    
    if (_userNameTextField.text.length == 0 || _passWordTextField.text.length == 0)
    {
        [_blController digestLoginWithURL:url];
    }
    else
    {
        [_blController digestLoginWithURL:url userName:_userNameTextField.text passWord:_passWordTextField.text];
    }
}
- (IBAction)logout:(id)sender
{
    [_blController cleanCache];
    NSLog(@"注销成功");
}
@end
