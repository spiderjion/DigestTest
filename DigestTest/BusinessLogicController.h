//
//  BusinessLogicController.h
//  DigestTest
//
//  Created by sagles on 13-1-5.
//  Copyright (c) 2013年 sagles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessLogicController : NSObject

/*!
 @brief     <#abstract#>
 @return    <#return#>
 */
+ (id)blController;

/*!
 @brief     disgest 登陆
 @return    void
 */
- (void)digestLogin;

/*!
 @brief     disgest 登陆
 @return    void
 */
- (void)digestLoginWithURL:(NSURL *)url;

/*!
 @brief     disgest 登陆
 @return    void
 */
- (void)digestLoginWithURL:(NSURL *)url userName:(NSString *)userName passWord:(NSString *)passWord;

/*!
 @brief 注销
 */
- (void)cleanCache;

@end
