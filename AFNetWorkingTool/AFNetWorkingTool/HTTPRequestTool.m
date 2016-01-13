//
//  HTTPRequestTool.m
//  AFNetWorking
//
//  Created by Apple on 16/1/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HTTPRequestTool.h"

@implementation HTTPRequestTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //设置网络请求超时时间
    manger.requestSerializer.timeoutInterval = 10;
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //如果请求成功的话将responseObject保存在sucess Block中
        if (sucess)
        {
            sucess(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure)
        {
            failure(error);
        }
        
    }];
    
}
/**
 *  这个方法主要是将下载的responseObject转换为模型，这个方法可以基于自己JSON数据结构来写
 *
 *  @param responseObject 网络请求下来的数据
 *  @param model          模型
 *
 *  @return 返回一个转换后的模型
 */
+ (NSMutableArray *)ModelTransformationWithResponseObject:(id)responseObject modelClass:(Class)modelClass
{

    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *appcications = responseObject[@"applications"];
    for (NSDictionary *dict in appcications)
    {
        [array addObject:[modelClass mj_objectWithKeyValues:dict]];
    }

    return array;
}


@end
