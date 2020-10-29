//
//  VLDetailCommentCell.m
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import "VLDetailCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry.h>
#import "VLDetailCommentSubCell.h"
#import "VLDetailCommentModel.h"

@interface VLDetailCommentCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) VLDetailCommentModel *testModel;
@property (nonatomic, strong) NSIndexPath *indexPath;



@property (nonatomic, strong) UIImageView        *avatar;
@property (nonatomic, strong) UIImageView        *likeIcon;
@property (nonatomic, strong) UILabel            *nickName;
@property (nonatomic, strong) UILabel            *extraTag;
@property (nonatomic, strong) UILabel            *content;
@property (nonatomic, strong) UILabel            *likeNum;
@property (nonatomic, strong) UILabel            *date;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation VLDetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        [self initSubView];
    }
    
    return self;
}


- (void)initSubView{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    _avatar = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"user_avatar_default"];
    _avatar.clipsToBounds = YES;
    _avatar.layer.cornerRadius = 14;
    [self.contentView addSubview:_avatar];
    
    _likeIcon = [[UIImageView alloc] init];
    _likeIcon.image = [UIImage imageNamed:@"home_like_n"];
    [self.contentView addSubview:_likeIcon];
    
    _nickName = [[UILabel alloc] init];
    _nickName.numberOfLines = 1;
    _nickName.textColor = [UIColor blackColor];
    _nickName.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_nickName];
    
    _content = [[UILabel alloc] init];
    _content.numberOfLines = 0;
    _content.textColor = [UIColor blackColor];
    _content.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_content];
    
    _date = [[UILabel alloc] init];
    _date.numberOfLines = 1;
    _date.textColor = [UIColor grayColor];
    _date.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_date];
    
    _likeNum = [[UILabel alloc] init];
    _likeNum.numberOfLines = 1;
    _likeNum.textColor = [UIColor grayColor];
    _likeNum.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_likeNum];
    
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-35);
    }];
    
    [_likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(10);
        make.left.right.equalTo(self.nickName);
    }];
    [_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.content.mas_bottom).offset(5);
        make.left.right.equalTo(self.nickName);
    }];
    [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likeIcon);
        make.top.equalTo(self.likeIcon.mas_bottom).offset(5);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.date);
        make.top.mas_equalTo(self.date.mas_bottom).offset(10);
        make.right.mas_equalTo(self);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hyb_lastViewInCell = self.tableView;
    self.hyb_bottomOffsetToCell = 0;
}



- (void)configCellWithModel:(VLDetailCommentModel *)model indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    self.content.text = model.content;
    self.nickName.text= model.nickname;
    self.date.text = [NSDate formatTime:[model.add_time longLongValue]];
    self.testModel = model;
    CGFloat tableViewHeight = 0;
    for (VLDetailCommentModel *commentModel in model.children) {
        CGFloat cellHeight = [VLDetailCommentSubCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            VLDetailCommentSubCell *cell = (VLDetailCommentSubCell *)sourceCell;
            [cell configCellWithModel:commentModel];
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey : commentModel.comment_id,
                     kHYBCacheStateKey : @"",
                     kHYBRecalculateForStateKey : @(NO)};
        }];
        tableViewHeight += cellHeight;
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[VLDetailCommentSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    VLDetailCommentModel *model = [self.testModel.children objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testModel.children.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VLDetailCommentModel *model = [self.testModel.children objectAtIndex:indexPath.row];
    CGFloat height = [VLDetailCommentSubCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        VLDetailCommentSubCell *cell = (VLDetailCommentSubCell *)sourceCell;
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey : model.comment_id,
                 kHYBCacheStateKey : @"",
                 kHYBRecalculateForStateKey : @(NO)};
    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    // 添加一条数据
//    VLDetailCommentModel *Model = [[VLDetailCommentModel alloc] init];
//    Model.nickname = @"标哥的技术博客";
//    Model.content = @"由标哥的技术博客出品，学习如何在cell中嵌套使用tableview并自动计算行高。同时演示如何通过HYBMasonryAutoCellHeight自动计算行高，关注博客：http://www.henishuo.com";
//    Model.headimg = @"header";
//    Model.reply_user = @"傻逼";
//    Model.comment_id = [NSString stringWithFormat:@"%ld",indexPath.row+1000];
//
//    [self.testModel.children addObject:Model];
    
//    if ([self.delegate respondsToSelector:@selector(reloadCellHeightForModel:atIndexPath:)]) {
//        self.testModel.shouldUpdateCache = YES;
//        [self.delegate reloadCellHeightForModel:self.testModel atIndexPath:self.indexPath];
//    }
    
    VLDetailCommentModel *subModel = [self.testModel.children objectAtIndex:indexPath.row];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(detailCommentCellModel:replyCommentWith:atIndexPath:)]) {
        [self.delegate detailCommentCellModel:self.testModel replyCommentWith:subModel atIndexPath:self.indexPath];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.testModel.children removeObjectAtIndex:indexPath.row];
        if ([self.delegate respondsToSelector:@selector(reloadCellHeightForModel:atIndexPath:)]) {
            self.testModel.shouldUpdateCache = YES;
            [self.delegate reloadCellHeightForModel:self.testModel atIndexPath:self.indexPath];
        }
    }
}

//- (NSString *)ConvertStrToTime:(NSString *)timeStr{
//    long long time=[timeStr longLongValue];
//    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
//    NSString*timeString=[formatter stringFromDate:date];
//    return timeString;
//}

@end
