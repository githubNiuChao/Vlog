//
//  VLTopicListView.m
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTopicListView.h"
#import "VLTopicRequest.h"
#import "VLTopicResponse.h"
#import "VLIndexResponse.h"

@class VLTopicListViewCell;

NSString * const kVLTopicListViewCell   = @"VLTopicListViewCell";

@interface VLTopicListView ()
KProStrongType(UIView, headerView)
KProStrongType(UILabel, tagTitle)
KProNSArray(dataArray)
@end

@implementation VLTopicListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
}

- (void)loadMore:(BOOL)isMore{
      VLTopicRequest *request = [[VLTopicRequest alloc] init];
        [request setArgument:self.parent_id forKey:@"parent_id"];
        NCWeakSelf(self);
        [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLIndex_Cat_InfoResponse class] json:baseResponse.data];
            weakself.dataArray = [modelArray mutableCopy];
            weakself.tableView.tableHeaderView = [weakself createHeaderView];
            [weakself.tableView reloadData];
            [weakself endHeaderFooterRefreshing];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        }];
}

- (void)initSubView{
    [self setBackgroundColor:[UIColor clearColor]];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLTopicListViewCell class] forCellReuseIdentifier:kVLTopicListViewCell];
}

- (void)setInfoData:(NSArray *)dataArray tagInfo:(NSString *)titleInfo{
    _dataArray = dataArray;
    
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
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLTopicListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLTopicListViewCell];
    VLIndex_Cat_InfoResponse *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.cat_name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VLIndex_Cat_InfoResponse *model = [self.dataArray objectAtIndex:indexPath.row];
    
    if (_delegate &&[_delegate respondsToSelector:@selector(topicListView:didSelectCatid:SelectCatTitle:)]) {
        [self.delegate topicListView:self didSelectCatid:model.cat_id SelectCatTitle:model.cat_name];
    }
}

- (UIView *)createHeaderView{

        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 45)];
        _headerView.userInteractionEnabled = YES;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
        [button setBackgroundImage:kNameImage(@"publish_topic_not") forState:UIControlStateNormal];
        [_headerView addSubview:button];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 18, 200, 20)];
        label.text = @"不选择话题";
        label.font = kFontBMedium;
        label.textColor = kBlackColor;
        [_headerView addSubview:label];
    NCWeakSelf(self);
        [_headerView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakself.delegate &&[weakself.delegate respondsToSelector:@selector(topicListView:didSelectCatid:SelectCatTitle:)]) {
                [weakself.delegate topicListView:self didSelectCatid:0 SelectCatTitle:@"不选择话题"];
            }
        }];
    return _headerView;
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end


@interface VLTopicListViewCell ()

@end

@implementation VLTopicListViewCell

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
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImage.mas_right).offset(10);
        make.centerY.equalTo(self.contentView).offset(0);
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
        _titleImage.image = kNameImage(@"publish_topic_icon");
//        kViewRadius(_titleImage, 5);
    }
    return _titleImage;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kBlackColor;
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

