//
//  RootViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/14.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "RootViewController.h"
#import "XTLoveHeartViewController.h"
#import "ViewController1.h"
#import "EmitterSnowController.h"
#import "PopingViewController.h"
#import "XTPictureViewController.h"
#import "XTAnimations-Swift.h"

@import UIKit;

#define cellIdentifier @"cell"

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleNames;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"XTAnimations";
    self.classNames = @[].mutableCopy;
    self.titleNames = @[].mutableCopy;
    
    [self addCell:@"直播点赞动画 - drawRect" class:@"XTLoveHeartViewController"];
    [self addCell:@"直播点赞动画 - 图片  " class:@"XTPictureViewController"];
    [self addCell:@"烟花动画展示" class:@"ViewController1"];
    [self addCell:@"粒子雪花动画" class:@"EmitterSnowController"];
    [self addCell:@"跑马灯动画" class:@"XTScrollLabelViewController"];
    [self addCell:@"简单POP" class:@"PopingViewController"];
    // 在 ObjC 中字符串转成 swift 类需要加模块名字 eg: MyModule.MyClass
    [self addCell:@"直播中动画, PK 进度条" class:@"XTAnimations.LivingViewController"];
    [self addCell:@"简单跑马灯" class:@"XTAnimations.RunningViewController"];
    [self addCell:@"常用的排序算法" class:@"XTAnimations.SortViewController"];
    [self addCell:@"连麦 16 宫格布局" class:@"XTAnimations.CollectionViewLayoutDemoViewController"];
    [self addCell:@"类似于直播间竖直滚动" class:@"XTAnimations.PageViewController"];
    [self addCell:@"画中画-浮窗-视频" class:@"XTAnimations.PipViewController"];
    [self addCell:@"画中画-浮窗-Timer" class:@"XTAnimations.PipTimerViewController"];
    [self addCell:@"0.1s倒计时" class:@"XTAnimations.DoubleCardViewController"];
    [self addCell:@"3D效果的 CollectionView" class:@"XTAnimations.XTCircleCollectionViewTestVC"];
    [self addCell:@"地球围绕太阳转" class:@"XTAnimations.Transform3DVC"];

    [self.view addSubview:self.tableView];
    
    [_tableView reloadData];
}

- (void)addCell:(NSString *)title class:(NSString *)className;
{
    [self.classNames addObject:className];
    [self.titleNames addObject:title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld -- %@", (long)indexPath.row, self.titleNames[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titleNames[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 55;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellIdentifier];
    }
    return _tableView;
}
@end
