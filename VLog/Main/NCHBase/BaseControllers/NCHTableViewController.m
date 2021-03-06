//
//  NCHTableViewController.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import "NCHTableViewController.h"
#import "NCHAutoRefreshFooter.h"

@interface NCHTableViewController ()
/** <#digest#> */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@end

@implementation NCHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseTableViewUI];
}

- (void)setupBaseTableViewUI
{
    
//    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
//        UIEdgeInsets contentInset = self.tableView.contentInset;
//        contentInset.top += self.jk_navgationBar.jk_height;
//        self.tableView.contentInset = contentInset;
//    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 适配 ios 11
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

#pragma mark - scrollDeleggate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom -= self.tableView.mj_footer.jk_height;
    self.tableView.scrollIndicatorInsets = contentInset;
    [self.view endEditing:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        tableView.backgroundColor = self.view.backgroundColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tableView];
        _tableView = tableView;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _tableViewStyle = style;
    }
    return self;
}

- (void)dealloc {
    
}

@end
