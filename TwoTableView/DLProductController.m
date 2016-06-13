//
//  DLProductController.m
//  TwoTableView
//
//  Created by dev on 16/6/13.
//  Copyright © 2016年 donglian@eastunion.net. All rights reserved.
//

#import "DLProductController.h"

static NSString *const cellID = @"productCell";

@interface DLProductController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *headerArray;

@property (nonatomic, strong) NSMutableArray *productArray;


@property(nonatomic, assign)BOOL isScrollUp;//是否是向上滚动
@property(nonatomic, assign)CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量

@end

@implementation DLProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTableView];
}
- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        
        _headerArray = [[NSMutableArray alloc] init];
        
        NSArray *array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        
        [_headerArray addObjectsFromArray:array];
    }
    return _headerArray;
}

- (NSMutableArray *)productArray
{
    if (!_productArray) {
        
        _productArray = [[NSMutableArray alloc] init];
        
        NSArray *array = @[@"鞋子",@"衣服",@"化妆品",@"饮用水",@"副食品",@"小吃",@"鞋子",@"衣服",@"化妆品",@"饮用水"];
        
        [_productArray addObjectsFromArray:array];
    }
    return _productArray;
}

- (void)setupTableView
{
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, 64, SCREEN_WIDTH * 0.75, SCREEN_HEIGHT)];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [[UIView alloc] init];
    
    
    tableView.backgroundColor = [UIColor cyanColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headerArray.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.productArray[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headerArray[section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld, %ld", indexPath.section, indexPath.row);
}
/**
 *  下面连个方法是页眉页脚将要出现或者已经出现时调用
 */

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{

    // 向下滑动时调用
    if (self.delegate && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)]!= _isScrollUp && self.tableView.isDecelerating) {
        [self.delegate willDisplayHeaderView:section];
    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)]
//        ) {
//        [self.delegate willDisplayHeaderView:section];
//    }
}


- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    // 向上滑动时调用
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isScrollUp && self.tableView.isDecelerating) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] ) {
//        [self.delegate didEndDisplayingHeaderView:section];
//    }
}
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath
{
    
//    [NSIndexPath indexPathForRow:0 inSection:indexPath.row] 指的是哪一组的第几行，indexPath是从DLCategoryController传递过来的，所以indexPath.row在本控制器中指的是哪一组
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"_lastOffsetY : %f,scrollView.contentOffset.y : %f", _lastOffsetY, scrollView.contentOffset.y);
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
//    NSLog(@"______lastOffsetY: %f", _lastOffsetY);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
