//
//  RootViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/14.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "RootViewController.h"
#import "XTLoveHeartViewController.h"
#import "ViewController.h"

#define cellIdentifier @"cell"
@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleNames;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation RootViewController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.classNames = @[].mutableCopy;
    self.titleNames = @[].mutableCopy;
    
    [self addCell:@"YY直播小心形" class:@"XTLoveHeartViewController"];
    [self addCell:@"烟花展示" class:@"ViewController"];
    
    [self.view addSubview:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellIdentifier];
    
    
    [_tableView reloadData];
}
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
    cell.textLabel.text = self.titleNames[indexPath.row];
    return cell;
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titleNames[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
