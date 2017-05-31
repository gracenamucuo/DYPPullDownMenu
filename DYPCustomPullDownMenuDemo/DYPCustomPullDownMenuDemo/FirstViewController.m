//
//  FirstViewController.m
//  DYPCustomPullDownMenuDemo
//
//  Created by 戴运鹏 on 2017/5/30.
//  Copyright © 2017年 戴运鹏. All rights reserved.
//

#import "FirstViewController.h"
extern NSString *const DYPUpdateMenuTitleNoti;
static NSString *const leftCellID = @"leftCellID";
static NSString *const rightCellID = @"rightCellID";
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;
@property (nonatomic,strong)NSString *selectedLeft;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)NSInteger rightSelectedIndex;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCellID];
    [self.rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCellID];
    self.leftTable.dataSource = self;
    self.leftTable.delegate = self;
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    self.leftTable.tableFooterView = [UIView new];
    self.rightTable.tableFooterView = [UIView new];
    _selectedIndex = 0;
    _rightSelectedIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    [self.leftTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.rightTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:_rightSelectedIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.leftTable didSelectRowAtIndexPath:indexPath];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTable) {
        return 5;
    }else{
        return 10;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellID];
        cell.textLabel.text = [NSString stringWithFormat:@"左%ld",indexPath.row];
        
        return cell;
    }
    
    if (tableView == self.rightTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellID];
        cell.textLabel.text = [NSString stringWithFormat:@"%@:右边%ld",_selectedLeft,indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _selectedLeft = cell.textLabel.text;
        _selectedIndex = indexPath.row;
        return;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter]postNotificationName:DYPUpdateMenuTitleNoti object:self userInfo:@{@"title":cell.textLabel.text}];
    _rightSelectedIndex = indexPath.row;
    
//    if (self.firstSelectBlock) {
//        self.firstSelectBlock(cell.textLabel.text);
//    }
    
    [self.rightTable reloadData];
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

























































