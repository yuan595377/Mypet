//
//  InfoModel.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel


- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        
    }
    
    return self;
    
}

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
