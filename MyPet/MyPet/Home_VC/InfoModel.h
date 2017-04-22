//
//  InfoModel.h
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *time;


- (instancetype)initWithDataSource:(NSDictionary *)dataSource;
@end
