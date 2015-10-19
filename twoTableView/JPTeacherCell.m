//
//  JPTeacherCell.m
//  dayi
//
//  Created by I Smile going on 15/8/31.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "JPTeacherCell.h"
#import "JPTeacherList.h"
//下载图片
#import "UIImageView+WebCache.h"
//16进制颜色转换
#import "UIColor+Extension.h"
#import "UIView+XL.h"
@interface JPTeacherCell ()

@property (weak, nonatomic) IBOutlet UIImageView *teachIcon;
@property (weak, nonatomic) IBOutlet UILabel *teachName;

@property (weak, nonatomic) IBOutlet UILabel *teachScore;
@property (weak, nonatomic) IBOutlet UILabel *answerCount;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end

@implementation JPTeacherCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *reuseID = @"teacher";
    
    JPTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JPTeacherCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}


- (void)setTeachList:(JPTeacherList *)teachList
{
    _teachList = teachList;
    
    NSURL *url = [NSURL URLWithString:teachList.iconurl];
    
    [self.teachIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"header_default_img"]];
    
    //设置圆角
    self.teachIcon.layer.cornerRadius = self.teachIcon.width/2;
    
    self.teachIcon.layer.borderWidth = 0.5;
    
    self.teachIcon.layer.borderColor = [UIColor colorWithHexString:@"dfdfdd"].CGColor;
    
    self.teachIcon.layer.masksToBounds = YES;
    
    self.teachName.text = teachList.name;
  
    self.teachScore.text = [NSString stringWithFormat:@"评分%.1f",teachList.score];
    
    self.answerCount.text =[NSString stringWithFormat:@"回答数%zd",[teachList.count intValue]];
    
    if (teachList.isSelect) {
        
        self.selectedBtn.selected = YES;
        
    }else
    {
        self.selectedBtn.selected = NO;
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.selectedBtn setBackgroundImage:[UIImage imageNamed:@"choice_select_icon"] forState:UIControlStateSelected];
        
        [self.selectedBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    return self;
}

@end
