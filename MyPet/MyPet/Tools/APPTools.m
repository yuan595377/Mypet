//
//  APPTools.m
//  TableView&CollectionView
//
//  Created by 陈传奇 on 15/12/18.
//  Copyright © 2015年 陈传奇. All rights reserved.
//

#import "APPTools.h"
#import "AFNetworking.h"


@implementation APPTools

+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void (^)(id))responseObj filed:(void (^)(NSError *))err
{

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    // 有的返回的数据格式，AFN不支持解析，所以我们要设置一下。让AFN支持。
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [man GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObj(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        err(error);

    }];
}

+ (void)POSTWithURL:(NSString *)urlStr
                par:(NSDictionary *)dic
            success:(void (^)(id))response filed:(void (^)(NSError *))err
{
    

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
     urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [man POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        response(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);

    }];
    
 
}




@end
