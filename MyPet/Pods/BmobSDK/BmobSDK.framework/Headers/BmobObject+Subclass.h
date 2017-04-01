//
//  BmobObject+Subclass.h
//  PushDemo
//
//  Created by Bmob on 15/5/27.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "BmobObject.h"
#import "BmobQuery.h"

@interface BmobObject (Subclass)

@property (copy, nonatomic) NSArray *selectedKeyArray;

@property (copy, nonatomic) NSArray *ignoredKeyArray;

+(BmobQuery *)query;
/**
 *  保存数据
 */
-(void)sub_saveInBackground;

/**
 *  保存数据
 *
 *  @param block 结果回调
 */
-(void)sub_saveInBackgroundWithResultBlock:(BmobBooleanResultBlock)block;

/**
 *  更新数据
 */
-(void)sub_updateInBackground;

/**
 *  更新数据
 *
 *  @param block 结果回调
 */
-(void)sub_updateInBackgroundWithResultBlock:(BmobBooleanResultBlock)block;



-(instancetype)initFromBmobObject:(BmobObject *)obj  ;


+(instancetype)convertWithObject:(BmobObject *)obj;

@end

