//
//  DLCategoryController.m
//  TwoTableView
//
//  Created by dev on 16/6/13.
//  Copyright © 2016年 donglian@eastunion.net. All rights reserved.
//

#import "DLCategoryController.h"
#import "DLProductController.h"
//#define

static NSString *const cellID = @"headerCell";

@interface DLCategoryController ()<UITableViewDataSource, UITableViewDelegate, DLProductControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *headerArray;

@property (nonatomic, strong) DLProductController *productVC;

@end

@implementation DLCategoryController

- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        
        _headerArray = [[NSMutableArray alloc] init];
        
        NSArray *array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        
        [_headerArray addObjectsFromArray:array];
    }
    return _headerArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"模仿美团外卖的商品选择";
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    [self setupTableView];
    
    [self setupRightView];
}

- (void)setupTableView
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [[UIView alloc] init];
    
    
    tableView.backgroundColor = [UIColor redColor];
}

- (void)setupRightView
{
    self.productVC = [[DLProductController alloc] init];
    
    self.productVC.delegate = self;
    // 当前控制器一定添加产品的子控制器(否则会出现点击的view混乱)
    [self addChildViewController:self.productVC];
    
    [self.view addSubview:self.productVC.view];
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.headerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.headerArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.productVC) {
        [self.productVC scrollToSelectedIndexPath:indexPath];
    }
}


- (void)willDisplayHeaderView:(NSInteger)section
{

    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didEndDisplayingHeaderView:(NSInteger)section
{
//    NSLog(@"%ld", section);
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
