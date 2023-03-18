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
    
    [self addCell:@"YY直播小心形 - drawRect" class:@"XTLoveHeartViewController"];
    [self addCell:@"直播图片动画  " class:@"XTPictureViewController"];
    [self addCell:@"烟花动画展示" class:@"ViewController1"];
    [self addCell:@"粒子雪花动画" class:@"EmitterSnowController"];
    [self addCell:@"跑马灯动画" class:@"XTScrollLabelViewController"];
    [self addCell:@"POP实践" class:@"PopingViewController"];
    [self addCell:@"直播中动画" class:@"LivingViewController"];
    [self addCell:@"简单跑马灯" class:@"RunningViewController"];
    [self addCell:@"常用的排序算法" class:@"SortViewController"];
    [self addCell:@"CollectionView 复杂布局" class:@"CollectionViewLayoutDemoViewController"];

    [self.view addSubview:self.tableView];
    
    [_tableView reloadData];
}

#pragma mark -
- (void)addCell:(NSString *)title class:(NSString *)className;
{
    [self.classNames addObject:className];
    [self.titleNames addObject:title];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classNames.count;
}

#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld -- %@", (long)indexPath.row, self.titleNames[indexPath.row]];
    return cell;
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 5) {

        if (indexPath.row == 6) {

            LivingViewController *vc = [[LivingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        if (indexPath.row == 7) {
            RunningViewController *vc = [[RunningViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        if (indexPath.row == 8) {
            SortViewController *vc = [[SortViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        if (indexPath.row == 9) {
            CollectionViewLayoutDemoViewController *vc = [[CollectionViewLayoutDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        return;
    }
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
