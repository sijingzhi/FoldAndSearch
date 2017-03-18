//
//  HttpService.h
//  FHB
//
//  Created by JJT on 16/4/30.
//  Copyright © 2016年 SJZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpService : NSObject



#pragma mark   不带文件POST
+ (void)postServiceWithMothedName:(NSString *)mothedName
                           params:(NSDictionary *)params
                          succeed:(void (^)(id response))success;


//get请求(测试)
+(void)getServiceWithMothedName:(NSString *)mothedName
params:(NSDictionary *)params
                        succeed:(void (^)(id response))success;

@end
