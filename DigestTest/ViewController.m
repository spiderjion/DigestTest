//
//  ViewController.m
//  DigestTest
//
//  Created by sagles on 13-1-5.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import "ViewController.h"
#import "DLEngine.h"

@implementation ViewController

- (void)dealloc
{
    [_loginURLTextField release];
    [_loginButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    
    [[DLEngine engineWithDelegate:self] digestLoginWithURL:url];
}
- (IBAction)logout:(id)sender
{
    [[DLEngine engine] clearSession];
    NSLog(@"注销成功");
}
@end
