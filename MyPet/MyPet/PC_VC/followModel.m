//
//  followModel.m
//  MyPet
//
//  Created by 袁立康 on 17/5/28.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "followModel.h"

@implementation followModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    //    if ([key isEqualToString:@"name"]) {
    //        self.name = [NSString stringWithFormat:@"favorite%@", value];
    //    }
    
}

// 当model的属性没有字典的key值相匹配时
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    //    [super setValue:value forUndefinedKey:key];
    
}




@end
