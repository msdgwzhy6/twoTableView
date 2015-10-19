//
//  ViewController.m
//  twoTableView
//
//  Created by I Smile going on 15/10/19.
//  Copyright © 2015年 dong. All rights reserved.
//

#import "ViewController.h"
#import "UIView+XL.h"
#import "JPTeacherList.h"
#import "MJExtension.h"
#import "JPTeacherCell.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView *teacherView;

@property(nonatomic,weak)UITableView *teacherOlView;
@property(nonatomic,weak)UITableView *askedTeachView;
@property(nonatomic,strong)NSArray *teachLists;
@property(nonatomic,strong)NSArray *askTeachLists;
//提示文本
@property(nonatomic,weak)UILabel *textL1;
@property(nonatomic,weak)UILabel *textL2;
//上次选中的在线老师
@property(nonatomic,strong)JPTeacherList *preTeacherList1;
@property(nonatomic,strong)JPTeacherList *preTeacherList2;

@end

@implementation ViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clickBtn:(UIButton *)sender {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *teacherView = [[UIView alloc]init];//创建老师列表的view
    
    self.teacherView = teacherView;
    
    teacherView.backgroundColor = [UIColor grayColor];
    
    teacherView.y = 20;
    
    teacherView.x = window.width;
    
    teacherView.width = window.width *5 /6;
    
    teacherView.height = window.height - teacherView.y;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        teacherView.x = window.width - teacherView.width;
        
    }];

    
    UITableView *teacherOlView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, teacherView.width, teacherView.height*2/3)];
    
    teacherOlView.delegate = self;
    teacherOlView.dataSource = self;
    
    self.teacherOlView = teacherOlView;
    
    UITableView *askedTeachView = [[UITableView alloc]initWithFrame:CGRectMake(0, teacherOlView.height, teacherView.width, teacherView.height/3)];
    
    askedTeachView.delegate = self;
    askedTeachView.dataSource = self;
    
    self.askedTeachView = askedTeachView;
    
    [teacherView addSubview:teacherOlView];
    [teacherView addSubview:askedTeachView];
    
    [self.view addSubview:teacherView];
    
    teacherOlView.sectionFooterHeight = 0;
    
    teacherOlView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    teacherOlView.showsVerticalScrollIndicator = NO;
    
    teacherOlView.userInteractionEnabled = YES;
    
    askedTeachView.sectionFooterHeight = 0;
    
    askedTeachView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    askedTeachView.showsVerticalScrollIndicator = NO;
    
    askedTeachView.userInteractionEnabled = YES;
    
}
- (NSArray *)teachLists
{
    if (!_teachLists) {
        
        _teachLists = [JPTeacherList objectArrayWithFilename:@"teacherList.plist"];
    }
    
    return _teachLists;
}

- (NSArray *)askTeachLists
{
    if (!_askTeachLists) {
        
        _askTeachLists = [JPTeacherList objectArrayWithFilename:@"teacherList1.plist"];
    }
    return _askTeachLists;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.teacherOlView]) {
        
        return self.teachLists.count;
    }else
    {
        return self.askTeachLists.count;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.teacherOlView]) {
        
        JPTeacherCell *cell = [JPTeacherCell cellWithTableView:tableView];
        
        JPTeacherList *teachList = self.teachLists[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.teachList = teachList;

        return cell;
        
    }else
    {
        JPTeacherCell *cell = [JPTeacherCell cellWithTableView:tableView];
        
        JPTeacherList *teachList = self.askTeachLists[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.teachList = teachList;
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([tableView isEqual:self.teacherOlView])
    {
        return ((kScreenH - 64 - 44)*2/3 - 35)/4;
    }
    else
    {
        return ((kScreenH - 64 - 44)/3 - 35)/2;
    }
    
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    if ([tableView isEqual:self.teacherOlView] ) {
        
        return @"在线老师";
    }else
    {
        return @"我找过的老师";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.teacherOlView]) {
        
        self.preTeacherList2.isSelect = NO;
        
        [self.askedTeachView reloadData];
        
        JPTeacherList *teachList = self.teachLists[indexPath.row];
        
        if ([self.preTeacherList1 isEqual:teachList]) {
            
            teachList.isSelect = !teachList.isSelect;
            
            [tableView reloadData];
            
            
        }else{
            
            self.preTeacherList1.isSelect = NO;
            
            teachList.isSelect = YES;
            
            self.preTeacherList1 = teachList;
            
            
            
            [tableView reloadData];
        }
        
    }else if ([tableView isEqual:self.askedTeachView])
    {
        self.preTeacherList1.isSelect = NO;
        
        [self.teacherOlView reloadData];
        
        JPTeacherList *teachList = self.askTeachLists[indexPath.row];
        
        if ([self.preTeacherList2 isEqual:teachList]) {
            
            teachList.isSelect = !teachList.isSelect;
            
            [tableView reloadData];
            
            
        }else{
            
            self.preTeacherList2.isSelect = NO;
            
            teachList.isSelect = YES;
            
            self.preTeacherList2 = teachList;
            
            [tableView reloadData];
        }
        
    }
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.25 animations:^{
        
        
        self.teacherView.x = kScreenW;
       
        
    } completion:^(BOOL finished) {
        
        
        [self.teacherView removeFromSuperview];
    }];

}




@end
