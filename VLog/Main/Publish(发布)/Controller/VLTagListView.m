//
//  VLTagListView.m
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTagListView.h"


@class VLTagListViewCell;

NSString * const kVLTagListViewCell   = @"VLTagListViewCell";

@interface VLTagListView ()
KProStrongType(UIView, headerView)
@end

@implementation VLTagListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self endHeaderFooterRefreshing];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    
}

- (void)initSubView{
    [self setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[VLTagListViewCell class] forCellReuseIdentifier:kVLTagListViewCell];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLTagListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLTagListViewCell];
    cell.titleLabel.text = @"达芙妮";
    cell.titleImage.image = kNameImage(@"5.jpg");
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Comment *comment = _data[indexPath.row];
//    if(!comment.isTemp && [@"visitor" isEqualToString:comment.user_type] && [MD5_UDID isEqualToString:comment.visitor.udid]) {
//        MenuPopView *menu = [[MenuPopView alloc] initWithTitles:@[@"删除"]];
//        __weak __typeof(self) wself = self;
//        menu.onAction = ^(NSInteger index) {
//            [wself deleteComment:comment];
//        };
//        [menu show];
//    }
}


- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 80)];
        _headerView.userInteractionEnabled = YES;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [button setBackgroundImage:kNameImage(@"publish_add_icon") forState:UIControlStateNormal];
        [_headerView addSubview:button];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 100, 20)];
        label.text = @"点击添加标签";
        label.font = kFontBMedium;
        label.textColor = kWhiteColor;
        [_headerView addSubview:label];
        [_headerView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
        }];
    }
    return _headerView;
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end


@interface VLTagListViewCell ()

@end

@implementation VLTagListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kColorClear;
        self.clipsToBounds = YES;
        [self initSubView];
        }
    return self;
}


- (void)initSubView{
    [self.contentView addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImage.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
    }];
}


- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _titleImage.image = kNameImage(@"12.jpg");
        kViewRadius(_titleImage, 5);
    }
    return _titleImage;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.font = kFontBMedium;
        _titleLabel.text = @"affaasdafa";
    }
    return _titleLabel;
}

@end

