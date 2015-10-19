//
//  JPTeacherList.h
//  dayi
//
//  Created by I Smile going on 15/9/4.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JPTeacherList : NSObject

/**
 *  老师ID
 */
@property(nonatomic,assign) NSNumber *teachid;
/**
 *  老师名字
 */
@property(nonatomic,copy)NSString *name;
/**
 *  老师头像
 */
@property(nonatomic,copy)NSString *iconurl;
/**
 *  老师评分
 */
@property(nonatomic,assign) CGFloat score;
/**
 *  老师回答数
 */
@property(nonatomic,assign) NSNumber *count;
/**
 *  老师描述
 */
@property(nonatomic,copy)NSString *teacherdesc;
//判断是否选中

@property(nonatomic,assign) BOOL isSelect;

@end
