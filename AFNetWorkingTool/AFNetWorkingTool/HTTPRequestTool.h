//
//  HTTPRequestTool.h
//  AFNetWorking
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MJExtension.h"

@interface HTTPRequestTool : NSObject

//网络下载请求
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))sucess failure:(void(^)(NSError *error))failure;
//字典转模型类
+ (NSMutableArray *)ModelTransformationWithResponseObject:(id)responseObject modelClass:(Class)modelClass;



@end
