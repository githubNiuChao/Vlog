//
//  VLMessageViewController.m
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLMessageViewController.h"


@implementation VLMessageModel

@end

@interface VLMessageCell ()

KProStrongType(UILabel, titleLabel)
KProStrongType(UILabel, subTitleLabel)
KProStrongType(UILabel, dateLabel)

@end

@implementation VLMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
        }
    return self;
}


- (void)initSubView{
    [self.contentView addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageButton.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(self.titleLabel);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel);
        make.height.equalTo(@0.5);
    }];
}


- (UIButton *)imageButton{
    if (!_imageButton) {
        _imageButton = [[UIButton alloc] initWithFrame:CGRectZero];
        kViewRadius(_imageButton, 30);
        [_imageButton setJk_badgeValue:@"1"];
        [_imageButton setJk_badgeFont:kFontBSmall];
        [_imageButton setJk_badgeOriginX:40];
    }
    return _imageButton;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontBBig;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = kGreyColor;
        _subTitleLabel.font = kFontBMedium;
    }
    return _subTitleLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.textColor = kBlackColor;
        _dateLabel.font = kFontSmall;
    }
    return _dateLabel;
}

- (void)setMessageModel:(VLMessageModel *)messageModel{
    _messageModel = messageModel;
    [self.imageButton setBackgroundImage:kNameImage(messageModel.imageString) forState:UIControlStateNormal];
    [self.imageButton setJk_badgeValue:messageModel.messageNum];
    self.titleLabel.text = messageModel.titleString;
    self.subTitleLabel.text = messageModel.subTitleSring;
}

@end

NSString * const kVLMessageCell = @"VLMessageCell";

@class VLMessageModel;
@interface VLMessageViewController ()
KProNSMutableArrayType(VLMessageModel, dataArray);
@end

@implementation VLMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    [self setNavigationBarTitle:@"消息"];
}

- (void)initSubView{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLMessageCell class] forCellReuseIdentifier:kVLMessageCell];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLMessageCell];
    cell.messageModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VLMessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    VLMessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.messageModel.messageNum = @"0";
    [cell.imageButton setJk_badgeValue:@"0"];
    UIViewController *vc = [[NSClassFromString(model.className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray<VLMessageModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        NSArray *imageArray = @[@"message_zan_icon",@"message_guanzhu_icon",@"message_pinglun_icon",@"message_tongzhi_icon",@"message_pengyou_icon"];
        NSArray *tittleArray = @[@"赞和收藏",@"新增关注",@"收到的评论",@"通知消息"];
        NSArray *subTitleArray = @[@"看一看哪些朋友为你点赞和收藏",@"点击查看哪些朋友关注了你",@"看看哪些朋友评论了你的作品",@"查看系统通知消息"];
        NSArray *classArray = @[@"VLMessageLikeListViewController",@"VLMessageFollowListViewController",@"",@""];
        NSArray *messageNumArray = @[@"11",@"22",@"33",@"4"];
        [tittleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            VLMessageModel * model = [[VLMessageModel alloc] init];
            model.titleString = obj;
            model.imageString = [imageArray objectAtIndex:idx];
            model.subTitleSring = [subTitleArray objectAtIndex:idx];
            model.messageNum = [messageNumArray objectAtIndex:idx];
            model.className = [classArray objectAtIndex:idx];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}

@end
