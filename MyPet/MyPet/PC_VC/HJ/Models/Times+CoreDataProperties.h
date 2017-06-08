//
//  Times+CoreDataProperties.h
//  MyPet
//
//  Created by 袁立康 on 17/6/8.
//  Copyright © 2017年 袁立康. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Times+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Times (CoreDataProperties)

+ (NSFetchRequest<Times *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *label;
@property (nullable, nonatomic, copy) NSString *music;
@property (nullable, nonatomic, copy) NSString *week;
@property (nonatomic) int16_t minutes;
@property (nonatomic) int16_t hour;

@end

NS_ASSUME_NONNULL_END
