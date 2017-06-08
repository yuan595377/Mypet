//
//  Times+CoreDataProperties.m
//  MyPet
//
//  Created by 袁立康 on 17/6/8.
//  Copyright © 2017年 袁立康. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Times+CoreDataProperties.h"

@implementation Times (CoreDataProperties)

+ (NSFetchRequest<Times *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Times"];
}

@dynamic label;
@dynamic music;
@dynamic week;
@dynamic minutes;
@dynamic hour;

@end
