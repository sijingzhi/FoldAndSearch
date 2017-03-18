//
//  HttpService.m
//  FHB
//
//  Created by JJT on 16/4/30.
//  Copyright © 2016年 SJZ. All rights reserved.
//

#import "HttpService.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>

@implementation HttpService



#pragma mark   不带文件POST
+ (void)postServiceWithMothedName:(NSString *)mothedName
                           params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
{
    NSString * isPerfection;
    NSString * userCode;
    NSString * auditStatus;
    NSString * userId;
    
    NSString * str = @"http://juhuobao.jjtvip.com/";
    NSString * requestUrl = [str stringByAppendingString:mothedName];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
   

    NSLog(@"%@+%@+%@+%@",isPerfection,userCode,auditStatus,userId);
    [session POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //停止动画
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:nil];
                if ([[responseObject objectForKey:@"success"] integerValue] == 0)
                {
                   

                    UIWindow * window = [UIApplication sharedApplication].keyWindow;
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = [responseObject objectForKey:@"message"];
                    hud.margin = 10.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:2];
                    return ;
                }
        
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"error:%@",error);
        //停止动画
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:nil];
        //停止刷新
         [[NSNotificationCenter defaultCenter] postNotificationName:@"endRefresh" object:nil];
        
                AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
                [manager startMonitoring];
        
                [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
                    if (status != AFNetworkReachabilityStatusNotReachable) {
        
                        UIWindow * window = [UIApplication sharedApplication].keyWindow;
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"服务器异常";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:2];
        
                    } else {
        
                        // 没网
                        UIWindow * window = [UIApplication sharedApplication].keyWindow;
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"网络异常";
                        hud.margin = 10.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES afterDelay:2];
                    }
                }];
                
                [manager stopMonitoring];
            }];
}



//get请求
+ (void)getServiceWithMothedName:(NSString *)mothedName params:(NSDictionary *)params succeed:(void (^)(id))success{
    
    
    NSString * isPerfection;
    NSString * userCode;
    NSString * auditStatus;
    NSString * userId;
    
    
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    if ([us objectForKey:@"isPerfection"]!= NULL)
    {
        isPerfection = [us objectForKey:@"isPerfection"];
    }else
    {
        isPerfection = @"";
    }
    if ([us objectForKey:@"userCode"] != NULL)
    {
        userCode = [us objectForKey:@"userCode"];
        
    }else
    {
        userCode = @"";
    }
    
    
    if ([us objectForKey:@"auditStatus"] != NULL)
    {
        auditStatus = [us objectForKey:@"auditStatus"];
        
    }else
    {
        auditStatus = @"";
    }
    
    if ([us objectForKey:@"userId"] != NULL)
    {
        userId = [us objectForKey:@"userId"];
        
    }else
    {
        userId = @"";
    }
    [us synchronize];
    
    
    NSString * str = @"http://juhuobao.jjtvip.com/";
    NSString * requestUrl = [str stringByAppendingString:mothedName];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [session.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"CLIENT-POINT"];
    [session.requestSerializer setValue:[NSString stringWithFormat:@"%@",isPerfection] forHTTPHeaderField:@"IsPerfection"];
    [session.requestSerializer setValue:userCode forHTTPHeaderField:@"USERCODE"];
    [session.requestSerializer setValue:[NSString stringWithFormat:@"%@",auditStatus]forHTTPHeaderField:@"auditStatus"];
    [session.requestSerializer setValue:userId forHTTPHeaderField:@"USERID"];

    [session GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        
        if ([[responseObject objectForKey:@"success"] integerValue] == 0)
        {
            
            
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [responseObject objectForKey:@"message"];
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            return ;
        }
        
        //停止动画
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:nil];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        //停止动画
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:nil];
        //停止刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endRefresh" object:nil];
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != AFNetworkReachabilityStatusNotReachable) {
                UIWindow * window = [UIApplication sharedApplication].keyWindow;
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"服务器异常";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
            } else {
                // 没网
                UIWindow * window = [UIApplication sharedApplication].keyWindow;
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络异常";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:2];
            }
            
        }];
        
        [manager stopMonitoring];
        
    }];
    
}



@end
