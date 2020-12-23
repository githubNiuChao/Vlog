//
//  CommentsPopView.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "CommentsPopView.h"
#import "MenuPopView.h"
#import "LoadMoreControl.h"
#import "VLDetailCommentCell.h"
#import "VLCommentTextView.h"
#import "VLPhotoDetailManager.h"
#import "VLPublishCommentRequest.h"


NSString * const kVLDetailCommentCell     = @"VLDetailCommentCell";
//NSString * const kCommentHeaderCell   = @"CommentHeaderCell";
//NSString * const kCommentFooterCell   = @"CommentFooterCell";

@interface CommentsPopView () <UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate,UIScrollViewDelegate, VLCommentTextViewDelegate,VLDetailCommentCellDelegate>


@property (nonatomic, strong) UIView                           *container;
@property (nonatomic, strong) UITableView                      *tableView;
@property (nonatomic, strong) NSMutableArray<VLDetailCommentModel *>        *dataArray;

KProStrongType(VLCommentTextView, textView)

//当前准备回复的评论model
KProStrongType(VLDetailCommentModel, currentCommentModel)
//配置默认的评论模型
KProStrongType(VLDetailCommentModel, defaultCommentModel)

//当前准备回复的评论IndexPath
@property (nonatomic, strong) NSIndexPath *currentCommentIndexPath;


@end


@implementation CommentsPopView

- (instancetype)initWithCommentListData:(NSArray<VLDetailCommentModel *> *)commentListData loginUserInfoModel:(VLUserInfoModel *)loginUser{
    self = [super init];
    if (self) {
        self.frame = ScreenFrame;
        
        _dataArray = [commentListData mutableCopy];
        _loginUserInfoModel = loginUser;
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*3/4)];
        _container.backgroundColor = kWhiteColor;
        [self addSubview:_container];
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight*3/4) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0f;
        [_container addSubview:visualEffectView];
        
        
        _label = [[UILabel alloc] init];
        _label.textColor = ColorGray;
        _label.text = [NSString stringWithFormat:@"%ld条评论",_dataArray.count];
        _label.font = kFontSmall;
        _label.textAlignment = NSTextAlignmentCenter;
        [_container addSubview:_label];
        
        _close = [[UIImageView alloc] init];
        _close.image = [UIImage imageNamed:@"common_close"];
        _close.contentMode = UIViewContentModeCenter;
        _close.userInteractionEnabled = YES;
        [_close addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClose)]];
        [_container addSubview:_close];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.container);
            make.height.mas_equalTo(35);
        }];
        [_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.label);
            make.right.equalTo(self.label).inset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight*3/4 - 35 - 50 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = ColorClear;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[VLDetailCommentCell class] forCellReuseIdentifier:kVLDetailCommentCell];
        
        
//        _loadMore = [[LoadMoreControl alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50) surplusCount:10];
//        [_loadMore startLoading];
//        __weak __typeof(self) wself = self;
//        [_loadMore setOnLoad:^{
//            [wself loadData:wself.pageIndex pageSize:wself.pageSize];
//        }];
//        [_tableView addSubview:_loadMore];
        
        [_container addSubview:_tableView];
        
        _textView = [VLCommentTextView new];
        _textView.delegate = self;
        
//        [self loadData:_pageIndex pageSize:_pageSize];
        
    }
    return self;
}

// comment textView delegate
//-(void)onSendText:(NSString *)text {
//    __weak __typeof(self) wself = self;
//    PostCommentRequest *request = [PostCommentRequest new];
//    request.aweme_id = _awemeId;
//    request.udid = UDID;
//    request.text = text;
//    __block NSURLSessionDataTask *task = [NetworkHelper postWithUrlPath:PostComentPath request:request success:^(id data) {
//        CommentResponse *response = [[CommentResponse alloc] initWithDictionary:data error:nil];
//        Comment *comment = response.data;
//        for(NSInteger i = wself.data.count-1; i>=0; i--) {
//            if(wself.data[i].taskId == task.taskIdentifier) {
//                wself.data[i] = comment;
//                break;
//            }
//        }
//        [UIWindow showTips:@"评论成功"];
//    } failure:^(NSError *error) {
//        [UIWindow showTips:@"评论失败"];
//    }];
//
//    Comment *comment = [[Comment alloc] init:_awemeId text:text taskId:task.taskIdentifier];
//    comment.user_type = @"visitor";
//    comment.visitor = _vistor;
//}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    NCWeakSelf(self);
    CGFloat h = [VLDetailCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        VLDetailCommentCell *cell = (VLDetailCommentCell *)sourceCell;
        cell.loginUserInfoModel = weakself.loginUserInfoModel;
        [cell configCellWithModel:model indexPath:indexPath];
    } cache:^NSDictionary *{
      NSDictionary *cache = @{kHYBCacheUniqueKey : model.comment_id,
               kHYBCacheStateKey  : @"",
               kHYBRecalculateForStateKey : @(model.shouldUpdateCache)};
      model.shouldUpdateCache = NO;
      return cache;
    }];

    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLDetailCommentCell];
    cell.delegate = self;
    VLDetailCommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.loginUserInfoModel = self.loginUserInfoModel;
    [cell configCellWithModel:model indexPath:indexPath];
    return cell;
}

//回复主评论
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VLDetailCommentModel *model = [self.dataArray objectAtIndex:indexPath.row];
    self.currentCommentIndexPath = indexPath;
    self.currentCommentModel = [[VLDetailCommentModel alloc] init];
    self.currentCommentModel.parent_id = model.comment_id;
    self.currentCommentModel.reply_id = @"0";
    [self.textView showWtihTitle:model.nickname];

}


#pragma mark - VLDetailCommentCellDelegate
//subCell回复评论
- (void)detailCommentCellModel:(VLDetailCommentModel *)cellModel replyCommentWith:(VLDetailCommentModel *)subCellModel atIndexPath:(NSIndexPath *)indexPath{
    
    self.currentCommentIndexPath = indexPath;
    
    self.currentCommentModel = [[VLDetailCommentModel alloc] init];
    self.currentCommentModel.parent_id = cellModel.comment_id;
    self.currentCommentModel.reply_id = subCellModel.comment_id;
    self.currentCommentModel.reply_user = subCellModel.nickname;
    
    [self.textView showWtihTitle:subCellModel.nickname];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return cell.testModel.is_author;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [VLPhotoDetailManager deleteCommentWithCommentModel:[self.dataArray objectAtIndex:indexPath.row]];
            [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - VLCommentTextViewDelegate - 评论弹窗代理
- (void)onSendText:(NSString *)text{
    
    VLPublishCommentRequest *commentRequest = [[VLPublishCommentRequest alloc] init];
    commentRequest.isAdd = YES;
    [commentRequest setArgument:self.currentCommentModel.parent_id forKey:@"parent_id"];
    [commentRequest setArgument:self.currentCommentModel.reply_id forKey:@"reply_id"];
    [commentRequest setArgument:self.videoID forKey:@"video_id"];
    [commentRequest setArgument:text forKey:@"content"];

    [commentRequest nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        if (baseResponse.code == 0) {
            [UIWindow showTips:@"评论发表成功"];
            
            [self.label setText:[NSString stringWithFormat:@"%@条评论",[request.responseJSONObject objectForKey:@"comment_count"]]];
            
            VLDetailCommentModel *model = [VLDetailCommentModel yy_modelWithJSON:[request.responseJSONObject objectForKey:@"comment_info"]];
            model.headimg = self.loginUserInfoModel.headimg;
            model.nickname = self.loginUserInfoModel.nickname;
            if (self.currentCommentModel.reply_user.length) {
                model.reply_user = self.currentCommentModel.reply_user;
            }
            
            if ([self.currentCommentModel.parent_id isEqualToString:@"0"] && [self.currentCommentModel.reply_id isEqualToString:@"0"]) {
                [self.dataArray insertObject:model atIndex:0];
                [self.tableView reloadData];
                
            }else{
                VLDetailCommentCell *cell = [self.tableView cellForRowAtIndexPath:self.currentCommentIndexPath];
                cell.testModel.shouldUpdateCache = YES;
                [cell.testModel.children insertObject:model atIndex:0];
                [self reloadCellHeightForModel:cell.testModel atIndexPath:self.currentCommentIndexPath];
            }
        }else{
            [UIWindow showTips:@"评论发表失败"];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        [UIWindow showTips:@"评论发表失败"];
        
    }];
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Comment *comment = _data[indexPath.row];
//    if(!comment.isTemp && [@"visitor" isEqualToString:comment.user_type] && [MD5_UDID isEqualToString:comment.visitor.udid]) {
//        MenuPopView *menu = [[MenuPopView alloc] initWithTitles:@[@"删除"]];
//        __weak __typeof(self) wself = self;
//        menu.onAction = ^(NSInteger index) {
//            [wself deleteComment:comment];
//        };
//        [menu show];
//    }
//}
//guesture
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:@"CommentListCell"]) {
//        return NO;
//    }else {
//        return YES;
//    }
//}

//- (void)handleGuesture:(UITapGestureRecognizer *)sender {
//    CGPoint point = [sender locationInView:_container];
//    if(![_container.layer containsPoint:point]) {
//        [self dismiss];
//        return;
//    }
//    point = [sender locationInView:_close];
//    if([_close.layer containsPoint:point]) {
//        [self dismiss];
//    }
//}

//update method
- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
//    [self.textView show];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self.textView dismiss];
                     }];
}


//UIScrollViewDelegate Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0) {
        self.frame = CGRectMake(0, -offsetY, self.frame.size.width, self.frame.size.height);
    }
    if (scrollView.isDragging && offsetY < -50) {
        [self dismiss];
    }
}

- (void)actionClose{
    [self dismiss];
}

@end


