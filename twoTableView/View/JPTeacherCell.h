//
//  JPTeacherCell.h
//  dayi
//
//  Created by I Smile going on 15/8/31.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPTeacherList;
@interface JPTeacherCell : UITableViewCell

@property(nonatomic,strong) JPTeacherList *teachList;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
