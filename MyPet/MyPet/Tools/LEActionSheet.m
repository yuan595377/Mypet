//
//  LEActionSheet.m
//  LEActionSheet
//
//  Created by LEA on 15/9/28.
//  Copyright © 2015年 LEA. All rights reserved.
//

#import "LEActionSheet.h"
#import "NSString+Extension.h"

#define kWidth                      [UIScreen mainScreen].bounds.size.width
#define kHeight                     [UIScreen mainScreen].bounds.size.height
#define RGBColor(r,g,b,a)           ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define BASE_COLOR                  RGBColor(242.0, 242.0, 242.0, 1.0)
#define TABLEVIEW_BORDER_COLOR      RGBColor(231.0, 231.0, 231.0, 1.0)
#define ROW_HEIGHT                  50

@implementation LEActionSheet

- (LEActionSheet *)initWithTitle:(NSString *)title delegate:(id<LEActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        if (delegate) {
            self.delegate = delegate;
        }
        _title = title;
        _cancelButtonTitle = cancelButtonTitle;
        _destructiveButtonTitle = destructiveButtonTitle;
        _otherButtonTitles = [[NSMutableArray alloc] initWithArray:otherButtonTitles];
        if ([destructiveButtonTitle length]) {
            [_otherButtonTitles insertObject:destructiveButtonTitle atIndex:0];
        }
        if ([cancelButtonTitle length]) {
            [_otherButtonTitles addObject:cancelButtonTitle];
            self.cancelButtonIndex = [_otherButtonTitles count]-1;
        }
        
        _alphaView = [[UIView alloc] initWithFrame:self.bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.0;
        [self addSubview:_alphaView];
        [self sendSubviewToBack:_alphaView];
        
        //取消
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [_alphaView addGestureRecognizer:tapGesture];
        
        CGFloat addH = [_cancelButtonTitle length]?5:0;
        CGFloat viewH = [self tableHeadHeight]+ROW_HEIGHT*[_otherButtonTitles count]+addH;
        _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, viewH)];
        _sheetView.backgroundColor = BASE_COLOR;
        [self addSubview:_sheetView];
        [_sheetView addSubview:[self tableView]];
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.25
                     animations:^{
                         _alphaView.alpha = 0.5;
                         [_sheetView setFrame:CGRectMake(0, kHeight-_sheetView.frame.size.height, kWidth, _sheetView.frame.size.height)];
                     }];
}

-(void)tappedCancel
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         _alphaView.alpha = 0;
                         [_sheetView setFrame:CGRectMake(0, kHeight, kWidth, _sheetView.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - 初始化数据
-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:_sheetView.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = TABLEVIEW_BORDER_COLOR;
    _tableView.tableFooterView = [UIView new];
    [self addTableHead];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    return _tableView;
}

-(void)addTableHead
{
    UIView *tableHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [self tableHeadHeight])];
    tableHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = tableHead;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kWidth-40, [_title sizeWithFont:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(kWidth-40, kHeight)].height)];
    titleLab.text = _title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor grayColor];
    titleLab.font = [UIFont systemFontOfSize:14.0];
    titleLab.numberOfLines = 0;
    [tableHead addSubview:titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, tableHead.frame.size.height, kWidth, 0.5)];
    line.backgroundColor = TABLEVIEW_BORDER_COLOR;
    [tableHead addSubview:line];
}

-(CGFloat)tableHeadHeight
{
    CGFloat height = 0;
    if ([_title length]) {
        height += [_title sizeWithFont:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(kWidth-40, kHeight)].height+40;
    }
    return height;
}

#pragma mark - tableView delegate/dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_otherButtonTitles count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_cancelButtonTitle length] && indexPath.row == [_otherButtonTitles count]-1) {
        return 55;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, ROW_HEIGHT)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:18.0];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = [NSString stringWithFormat:@"%@",[_otherButtonTitles objectAtIndex:indexPath.row]];
    titleLab.backgroundColor = [UIColor whiteColor];
    [cell addSubview:titleLab];
    
    if ([_destructiveButtonTitle length] && indexPath.row == 0) {
        titleLab.textColor = [UIColor redColor];
    }
    if ([_cancelButtonTitle length] && indexPath.row == [_otherButtonTitles count]-1) {
        titleLab.frame = CGRectMake(0, 5, kWidth, ROW_HEIGHT);
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_cancelButtonTitle length] && indexPath.row == [_otherButtonTitles count]-1)
    {
        [self tappedCancel];
        [self.delegate actionSheet:self clickedButtonAtIndex:indexPath.row];
        return;
    }
    [self.delegate actionSheet:self clickedButtonAtIndex:indexPath.row];
    [self tappedCancel];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
