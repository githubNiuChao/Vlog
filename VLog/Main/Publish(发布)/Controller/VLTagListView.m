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
KProStrongType(UILabel, tagTitle)
KProNSArray(dataArray)
@end

@implementation VLTagListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self endHeaderFooterRefreshing];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
}

- (void)initSubView{
    [self setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[VLTagListViewCell class] forCellReuseIdentifier:kVLTagListViewCell];
}

- (void)setInfoData:(NSArray *)dataArray tagInfo:(NSString *)titleInfo{
    _dataArray = dataArray;
    self.tableView.tableHeaderView = [self createHeaderViewWithTagTitle:titleInfo];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLTagListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLTagListViewCell];
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[VLPublishBrandTagModel class]]) {
        VLPublishBrandTagModel *brandModel = (VLPublishBrandTagModel *)model;
        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:brandModel.brand_logo] placeholderImage:[UIImage jk_imageWithColor:kGreyColor]];
        cell.titleLabel.text = brandModel.brand_name;
    }else if([model isKindOfClass:[VLPublishGoodsTagModel class]]){
        VLPublishGoodsTagModel *goodsModel = (VLPublishGoodsTagModel *)model;
        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.goods_image] placeholderImage:[UIImage jk_imageWithColor:kGreyColor]];
        cell.titleLabel.text = goodsModel.goods_name;
        cell.subTitleLabel.text = [NSString stringWithFormat:@"¥%@",goodsModel.goods_price];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[VLPublishBrandTagModel class]]) {
        
        
    }else if([model isKindOfClass:[VLPublishGoodsTagModel class]]){
        
        
    }
    
}


- (UIView *)createHeaderViewWithTagTitle:(NSString *)tagTitle{

        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 80)];
        _headerView.userInteractionEnabled = YES;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [button setBackgroundImage:kNameImage(@"publish_add_icon") forState:UIControlStateNormal];
        [_headerView addSubview:button];
        _tagTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 200, 20)];
        _tagTitle.text = tagTitle;
        _tagTitle.font = kFontBBig;
        _tagTitle.textColor = kWhiteColor;
        [_headerView addSubview:_tagTitle];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 200, 20)];
        label.text = @"点击添加标签";
        label.font = kFontBMedium;
        label.textColor = kWhiteColor;
        [_headerView addSubview:label];
        
        [_headerView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
        }];
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
        make.centerY.equalTo(self.contentView).offset(-10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.titleLabel);
    }];
}


- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _titleImage.contentMode = UIViewContentModeScaleToFill;
        kViewRadius(_titleImage, 5);
    }
    return _titleImage;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.font = kFontBMedium;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = kGreyColor;
        _subTitleLabel.font = kFontBSmall;
        _subTitleLabel.text = @"";
    }
    return _subTitleLabel;
}


@end

