//
//  DLEngine.m
//  DigestTest
//
//  Created by sagles on 13-1-7.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import "DLEngine.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"

@interface DLEngine ()<UIAlertViewDelegate>

/*!
 @brief     <#abstract#>
 */
@property (nonatomic, retain) ASIHTTPRequest *request;

@end

@implementation DLEngine

static DLEngine *engineSingleton = nil;

- (void)dealloc
{
    self.delegate = nil;
    [_request clearDelegatesAndCancel];
    [_request release];
    [_username release];
    [_password release];
    [super dealloc];
}

+ (id)engine
{
    return [self engineWithDelegate:nil];
}

+ (id)engineWithDelegate:(id)delegate
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ { engineSingleton = [[DLEngine alloc] init]; });
    
    if (delegate)
        engineSingleton.delegate = delegate;
    
    return engineSingleton;
}

+ (id)copyWithZone:(NSZone *)zone
{
    return engineSingleton;
}

- (id)retain
{
    return engineSingleton;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (void)digestLoginWithURL:(NSURL *)url
{
    [self.request clearDelegatesAndCancel];
    self.request = [ASIHTTPRequest requestWithURL:url];
    [self.request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeDigest];
    self.request.delegate = self;
    
    [self.request startAsynchronous];
}

- (void)restartRequest
{
    [self.request setUsername:_username];
    [self.request setPassword:_password];
    
    [self.request retryUsingSuppliedCredentials];
    
    //clear the username and password after request send.
    self.username = nil;
    self.password = nil;
}

- (void)clearSession
{
    [ASIHTTPRequest clearSession];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    //get the website information.
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"login did finish!\t\r%@",request.responseString);
    
    if ([_delegate respondsToSelector:@selector(engineDidLoginSuccess:)])
        [_delegate engineDidLoginSuccess:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"login did fail!\t\r%@",request.responseString);
    
    if ([_delegate respondsToSelector:@selector(engineDidLoginFail:)])
        [_delegate engineDidLoginFail:self];
}

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
    if ([_delegate respondsToSelector:@selector(engineLoginPageView)])
    {
        UIView *view = [_delegate engineLoginPageView];
        
        if ([_delegate isKindOfClass:[UIViewController class]])
        {
            [[(UIViewController *)_delegate view] addSubview:view];
        }
        else if ([_delegate isKindOfClass:[UIView class]])
        {
            [((UIView *)_delegate) addSubview:view];
        }
        //otherwise nothing will happend.
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [self.request cancelAuthentication];
    }
    else// ok button
    {
        UITextField *usernameTextField = [alertView textFieldAtIndex:0];
        UITextField *passwordTextField = [alertView textFieldAtIndex:1];
        
        self.username = usernameTextField.text;
        self.password = passwordTextField.text;
        
        [self restartRequest];
    }
    
}

@end
