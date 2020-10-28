//
//  VLIndexListManager.m
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexListManager.h"
#import "VLIndexRequest.h"

@interface VLIndexListManager()
@property (nonatomic,copy) NSArray * imgArray;
@property (nonatomic,copy) NSArray * nickNameArray;
@property (nonatomic,copy) NSArray * hobbysArray;
@property (nonatomic,copy) NSArray * fromArray;
@end

@implementation VLIndexListManager

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = @[].mutableCopy;
        _imgArray = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg"];
        _nickNameArray = @[@"上官无情",@"慕容空",@"玩的差瘾挺大",@"快枪手",@"YoYo产品经理",@"亲我一口能咋地",@"Rain"];
        _hobbysArray = @[@"四环有套房",@"人之初性本善，玩心眼都滚蛋",@"不约炮，年前已约满",@"弹琴，跳舞，书法，古筝，茶艺我都不会，我只会打王者荣耀",@"喜欢电影，音乐，旅游，爬山，徒步，淘宝，摄影，画画，话剧，美食，吹的我都累了",@"健身，游泳，阅读，打游戏",@"活好不粘人"];
        _fromArray = @[@"北京 学生",@"上海 模特",@"青岛 美容师",@"四川 八线小演员",@"新疆 游击队",@"东北 二人转演员"];
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadDataWithCatId:(NSInteger)catId{
    
    VLIndexRequest *request =  [[VLIndexRequest alloc]init];
    request.isFolllow = self.isfollow;
      NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    [request setArgument:@"2" forKey:@"cat_id"];
    
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLIndexResponse *dataModel = [VLIndexResponse yy_modelWithJSON:baseResponse.data];
        weakself.dataArray = dataModel.list;
        if (weakself.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
            [weakself.delegagte requestDataCompleted];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataFailedErrorMessage:)]) {
               [weakself.delegagte requestDataFailedErrorMessage:baseResponse.errorMessage];
           }
    }];
    
}

@end
