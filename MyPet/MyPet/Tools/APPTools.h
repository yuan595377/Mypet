//
//  APPTools.h
//  TableView&CollectionView
//
//  Created by 陈传奇 on 15/12/18.
//  Copyright © 2015年 陈传奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPTools : NSObject

+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void(^)(id responseObject))responseObj
             filed:(void(^)(NSError *error))error;

+ (void)POSTWithURL:(NSString *)urlStr
                par:(NSDictionary *)dic
            success:(void(^)(id responseObject))response
              filed:(void(^)(NSError *error))err;

@end
