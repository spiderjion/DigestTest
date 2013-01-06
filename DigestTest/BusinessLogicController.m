//
//  BusinessLogicController.m
//  DigestTest
//
//  Created by sagles on 13-1-5.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#define kUserName @"admin"
#define kPassWord @"admin"

static NSString *baseURL = @"http://digest.boxfishedu.com";
static NSString *loginURL = @"http://digest.boxfishedu.com/auth";

#import "BusinessLogicController.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"

@interface BusinessLogicController ()

/*!
 @brief     <#abstract#>
 */
@property (nonatomic, retain) ASIHTTPRequest *request;

@end

@implementation BusinessLogicController

- (void)dealloc
{
    [super dealloc];
    [_request clearDelegatesAndCancel];
    [_request release];
}

+ (id)blController
{
    return [[[self alloc] init] autorelease];
}

/*!
 @brief     disgest 登陆
 @return    void
 */
- (void)digestLogin
{
    [self digestLoginWithURL:[NSURL URLWithString:loginURL] userName:nil passWord:nil];
}

/*!
 @brief     disgest 登陆
 @return    void
 */
- (void)digestLoginWithURL:(NSURL *)url
{
    [self digestLoginWithURL:url userName:nil passWord:nil];
}

- (void)digestLoginWithURL:(NSURL *)url userName:(NSString *)userName passWord:(NSString *)passWord
{
    [self.request cancel];
    self.request = [ASIHTTPRequest requestWithURL:url];
    if (userName.length > 0)
        [self.request setUsername:userName];
    if (passWord.length > 0)
        [self.request setPassword:passWord];
    [self.request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeDigest];
    self.request.delegate = self;
    
    [self.request startAsynchronous];
}

- (void)cleanCache
{
//    [ASIHTTPRequest clearSession];
    NSLog(@"credentials:\t\r%@",[NSURLCredentialStorage sharedCredentialStorage].allCredentials);
    [ASIHTTPRequest removeCredentialsForHost:@"digest.boxfishedu.com" port:80 protocol:@"http" realm:@"bebase"];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"headers:/t/r%@",responseHeaders);
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"成功");
    NSLog(@"%@",_request.responseString);
    NSLog(@"credentials:\t\r%@",[NSURLCredentialStorage sharedCredentialStorage].allCredentials);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"失败");
    NSLog(@"%@",_request.responseString);
}


// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
//- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
//{
//    //在这里干活
//}

//- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
//{
//    
//}

@end
