//
//  NewModel.h
//  MyPet
//
//  Created by 袁立康 on 17/4/11.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *edittime;
@property (nonatomic, retain)NSString *thumb;

@property (nonatomic, assign)NSUInteger ID;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
