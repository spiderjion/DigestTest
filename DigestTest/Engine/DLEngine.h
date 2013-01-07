//
//  DLEngine.h
//  DigestTest
//
//  Created by sagles on 13-1-7.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLEngine;

@protocol DLEngineDelegate <NSObject>

- (void)engineDidLoginSuccess:(DLEngine *)egine;

- (void)engineDidLoginFail:(DLEngine *)engine;

/*!
 @brief The view will show when request catch 401 error.If the delegate do not respond this method,there will show
 an UIAlertView.
 */
- (UIView *)engineLoginPageView;

@end

@interface DLEngine : NSObject

/*!
 @brief     <#abstract#>
 */
@property (nonatomic, assign) id<DLEngineDelegate> delegate;

/*!
 @brief     userName
 */
@property (nonatomic, copy) NSString *username;

/*!
 @brief     password
 */
@property (nonatomic, copy) NSString *password;

/*!
 @brief     Singleton method
 @param     Delegate the delegate of the engine,it can be nil.
 @return    The singleton of the DLEngine
 */
+ (id)engine;
+ (id)engineWithDelegate:(id)delegate;

/*!
 @brief     Disgest login
 @return    void
 */
- (void)digestLoginWithURL:(NSURL *)url;

/*!
 @brief     This method should call when you have a custom view and user finish entering the account and password.
 @return    void
 */
- (void)restartRequest;

/*!
 @brief     Clear the session.In order to cancel the user info.
 @return    void
 */
- (void)clearSession;

@end
