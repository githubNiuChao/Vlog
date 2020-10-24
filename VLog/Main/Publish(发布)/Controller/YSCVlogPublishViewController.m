//
//  YSCVlogPublishViewController.m
//  VLog
//
//  Created by szy on 2020/9/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YSCVlogPublishViewController.h"
#import "HXPhotoPicker.h"
#import "YSCVlogPublishView.h"
#import "VLPublishRequest.h"
#import "VLTopicViewController.h"
#import "VLLocationViewController.h"

static const CGFloat kPhotoViewMargin = 45.0;
static const CGFloat kPublishViewHeight = 400.0;

@interface YSCVlogPublishViewController ()
<HXPhotoViewDelegate,
UIImagePickerControllerDelegate,
HXPhotoViewCellCustomProtocol,
YSCVlogPublishViewDelegate,
YYTextKeyboardObserver,
UITextFieldDelegate
>
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) YSCVlogPublishView *publishView;

@property (strong, nonatomic) UIButton *publishButton;
@property (assign, nonatomic) NSInteger topicId;

@property (assign, nonatomic) BOOL needDeleteItem;
@property (assign, nonatomic) BOOL showHud;

@property (strong, nonatomic) UIView *toolbar;


@end

@implementation YSCVlogPublishViewController

- (instancetype)init {
    self = [super init];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    return self;
}

- (void)dealloc {
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor hx_colorWithHexStr:@"#191918"];
            }
            return UIColor.whiteColor;
        }];
    }
#endif
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.closeButton];
    [self.mainScrollView addSubview:self.photoView];
    [self.mainScrollView addSubview:self.publishView];
    [self.view addSubview:self.publishButton];
    [self initToolbar];
}

- (void)initToolbar{
    if (_toolbar) return;
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor whiteColor];
    _toolbar.jk_size = CGSizeMake(self.view.jk_width, 45);
    _toolbar.jk_top = self.view.jk_height;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0,_toolbar.jk_width,1)];
    line.backgroundColor = kSysGroupBGColor;
    [_toolbar addSubview:line];
    UIButton* tagButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 90, _toolbar.jk_height)];
    tagButton.titleLabel.font = kFontBMedium;
    tagButton.adjustsImageWhenHighlighted = NO;
    [tagButton setTitle:@" 标签" forState:UIControlStateNormal];
    [tagButton setTitleColor:kGreyColor forState:UIControlStateNormal];
    [tagButton setImageEdgeInsets:UIEdgeInsetsMake(10,0,10,0)];
    tagButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [tagButton setImage:kNameImage(@"publish_tagtoolbar_icon") forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbar addSubview:tagButton];
    UIButton* doneButton = [[UIButton alloc] initWithFrame:CGRectMake(_toolbar.jk_width-60, 0, _toolbar.jk_height, _toolbar.jk_height)];
    doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbar addSubview:doneButton];
    
    [self.view addSubview:_toolbar];
}

- (void)tagButtonClick:(UIButton *)button{
    NSArray *topic = @[@"#冰雪奇缘[品牌]#", @"#Let It Go[品牌]#", @"#纸牌屋[商品]#", @"#北京理想国际大厦[商品]#" , @"#腾讯控股 kh00700[品牌]#"];
    NSString *topicString = topic[arc4random_uniform((u_int32_t)topic.count)];
    [self.publishView.bodyText replaceRange:self.publishView.bodyText.selectedTextRange withText:topicString];
}

- (void)doneButtonClick:(UIButton *)button{
    [self.publishView.bodyText resignFirstResponder];
}

#pragma mark @protocol YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    self.toolbar.hidden = [self.publishView.titleField isFirstResponder];
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        _toolbar.jk_top = CGRectGetMinY(toFrame)+kSafeHeightBottom;
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (transition.toVisible) {
                self->_toolbar.jk_bottom = CGRectGetMinY(toFrame);
            }else{
                self->_toolbar.jk_bottom = CGRectGetMinY(toFrame)+kSafeHeightBottom;
            }
        } completion:NULL];
    }
}



#pragma mark - Action
//发布
- (void)actionPublish:(UIButton *)button{
    NSString *text =  self.publishView.bodyText.text;
    
    NSArray<NSString *> *array = [text componentsSeparatedByString:@"#"];
    NSMutableArray *muarr = [[NSMutableArray alloc] init];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSConstantString class]]) {
            
            
        }
        if ([obj containsString:VLTextViewComposeParserBrandSubKey]) {
            NSString *string = [[obj componentsSeparatedByString:VLTextViewComposeParserBrandSubKey] firstObject];
            NSDictionary *dict = @{@"":@""};
            
        }else if ([obj containsString:VLTextViewComposeParserGoodsSubKey]){
            NSString *string = [[obj componentsSeparatedByString:VLTextViewComposeParserGoodsSubKey] firstObject];
            NSDictionary *dict = @{@"is_tag":@(true),
            @"name":obj};
            
            
        }else if([obj isKindOfClass:[NSString class]]){
            NSDictionary *dict = @{@"is_tag":@(false),
                                   @"name":obj};
        
        }
        
    }];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    HXWeakSelf
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:image location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf.view hx_showImageHUDText:@"保存图片失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithImage:image];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf.view hx_showImageHUDText:@"保存视频失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithVideoURL:url];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HXPhotoViewDelegate

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    //    [self changeStatus];
    
    
    
    NSSLog(@"%@",[videos.firstObject videoURL]);
//    VLPublishRequest *requeset = [[VLPublishRequest alloc] initWithVideoUrl:[videos firstObject].videoURL];
//
//
//    NSData *videoData = [NSData dataWithContentsOfURL:[videos firstObject].videoURL];
//    [requeset setArgument:videoData forKey:@"load_img"];
//
//    [requeset nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
//
//
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
//
//    }];
    
    
    /*
     
     HXPhotoModel *photoModel = allList.firstObject;
     
     [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
     // imageArray 获取成功的image数组
     // errorArray 获取失败的model数组
     NSSLog(@"\nimage: %@\nerror: %@",imageArray,errorArray);
     }];
     
     // 如果将_manager.configuration.requestImageAfterFinishingSelection 设为YES，
     // 那么在选择完成的时候就会获取图片和视频地址
     // 如果选中了原图那么获取图片时就是原图
     // 获取视频时如果设置 exportVideoURLForHighestQuality 为YES，则会去获取高等质量的视频。其他情况为中等质量的视频
     // 个人建议不在选择完成的时候去获取，因为每次选择完都会去获取。获取过程中可能会耗时过长
     // 可以在要上传的时候再去获取
     
     for (HXPhotoModel *model in allList) {
     // 数组里装的是所有类型的资源，需要判断
     // 先判断资源类型
     if (model.subType == HXPhotoModelMediaSubTypePhoto) {
     // 当前为图片
     if (model.photoEdit) {
     // 如果有编辑数据，则说明这张图篇被编辑过了
     // 需要这样才能获取到编辑之后的图片
     model.photoEdit.editPreviewImage;
     return;
     }
     // 再判断具体类型
     if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
     // 到这里就说明这张图片不是手机相册里的图片，可能是本地的也可能是网络图片
     // 关于相机拍照的的问题，当系统 < ios9.0的时候拍的照片虽然保存到了相册但是在列表里存的是本地的，没有PHAsset
     // 当系统 >= ios9.0 的时候拍的照片就不是本地照片了，而是手机相册里带有PHAsset对象的照片
     // 这里的 model.asset PHAsset是空的
     // 判断具体类型
     if (model.cameraPhotoType == HXPhotoModelMediaTypeCameraPhotoTypeLocal) {
     // 本地图片
     
     }else if (model.cameraPhotoType == HXPhotoModelMediaTypeCameraPhotoTypeLocalGif) {
     // 本地gif图片
     
     }else if (model.cameraPhotoType == HXPhotoModelMediaTypeCameraPhotoTypeNetWork) {
     // 网络图片
     
     }else if (model.cameraPhotoType == HXPhotoModelMediaTypeCameraPhotoTypeNetWorkGif) {
     // 网络gif图片
     
     }
     // 上传图片的话可以不用判断具体类型，按下面操作取出图片
     if (model.networkPhotoUrl) {
     // 如果网络图片地址有值就说明是网络图片，可直接拿此地址直接使用。避免重复上传
     // 这里需要注意一下，先要判断是否为图片。因为如果是网络视频的话此属性代表视频封面地址
     
     }else {
     // 网络图片地址为空了，那就肯定是本地图片了
     // 直接取 model.previewPhoto 或者 model.thumbPhoto，这两个是同一个image
     
     }
     }else {
     // 到这里就是手机相册里的图片了 model.asset PHAsset对象是有值的
     // 如果需要上传 Gif 或者 LivePhoto 需要具体判断
     if (model.type == HXPhotoModelMediaTypePhoto) {
     // 普通的照片，如果不可以查看和livePhoto的时候，这就也可能是GIF或者LivePhoto了，
     // 如果你的项目不支持动图那就不要取NSData或URL，因为如果本质是动图的话还是会变成动图传上去
     // 这样判断是不是GIF model.photoFormat == HXPhotoModelFormatGIF
     
     // 如果 requestImageAfterFinishingSelection = YES 的话，直接取 model.previewPhoto 或者 model.thumbPhoto 在选择完成时候已经获取并且赋值了
     // 获取image
     // size 就是获取图片的质量大小，原图的话就是 PHImageManagerMaximumSize，其他质量可设置size来获取
     CGSize size;
     if (isOriginal) {
     size = PHImageManagerMaximumSize;
     }else {
     size = CGSizeMake(model.imageSize.width * 0.5, model.imageSize.height * 0.5);
     }
     [model requestPreviewImageWithSize:size startRequestICloud:^(PHImageRequestID iCloudRequestId, HXPhotoModel * _Nullable model) {
     // 如果图片是在iCloud上的话会先走这个方法再去下载
     } progressHandler:^(double progress, HXPhotoModel * _Nullable model) {
     // iCloud的下载进度
     } success:^(UIImage * _Nullable image, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
     // image
     } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
     // 获取失败
     }];
     }else if (model.type == HXPhotoModelMediaTypePhotoGif) {
     // 动图，如果 requestImageAfterFinishingSelection = YES 的话，直接取 model.imageURL。因为在选择完成的时候已经获取了不用再去获取
     model.imageURL;
     // 上传动图时，不要直接拿image上传哦。可以获取url或者data上传
     // 获取url
     [model requestImageURLStartRequestICloud:nil progressHandler:nil success:^(NSURL * _Nullable imageURL, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
     // 下载完成，imageURL 本地地址
     } failed:nil];
     
     // 获取data
     [model requestImageDataStartRequestICloud:nil progressHandler:nil success:^(NSData * _Nullable imageData, UIImageOrientation orientation, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
     // imageData
     } failed:nil];
     }else if (model.type == HXPhotoModelMediaTypeLivePhoto) {
     // LivePhoto，requestImageAfterFinishingSelection = YES 时没有处理livephoto，需要自己处理
     // 如果需要上传livephoto的话，需要上传livephoto里的图片和视频
     // 展示的时候需要根据图片和视频生成livephoto
     [model requestLivePhotoAssetsWithSuccess:^(NSURL * _Nullable imageURL, NSURL * _Nullable videoURL, BOOL isNetwork, HXPhotoModel * _Nullable model) {
     // imageURL - LivePhoto里的照片封面地址
     // videoURL - LivePhoto里的视频地址
     
     } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
     // 获取失败
     }];
     }
     // 也可以不用上面的判断和方法获取，自己根据 model.asset 这个PHAsset对象来获取想要的东西
     PHAsset *asset = model.asset;
     // 自由发挥
     }
     }else if (model.subType == HXPhotoModelMediaSubTypeVideo) {
     // 当前为视频
     if (model.type == HXPhotoModelMediaTypeVideo) {
     // 为手机相册里的视频
     // requestImageAfterFinishingSelection = YES 时，直接去 model.videoURL，在选择完成时已经获取了
     model.videoURL;
     // 获取视频时可以获取 AVAsset，也可以获取 AVAssetExportSession，获取之后再导出视频
     // 获取 AVAsset
     [model requestAVAssetStartRequestICloud:nil progressHandler:nil success:^(AVAsset * _Nullable avAsset, AVAudioMix * _Nullable audioMix, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
     // avAsset
     // 自己根据avAsset去导出视频
     } failed:nil];
     
     // 获取 AVAssetExportSession
     [model requestAVAssetExportSessionStartRequestICloud:nil progressHandler:nil success:^(AVAssetExportSession * _Nullable assetExportSession, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
     
     } failed:nil];
     
     // HXPhotoModel也提供直接导出视频地址的方法
     // presetName 导出视频的质量，自己根据需求设置
     [model exportVideoWithPresetName:AVAssetExportPresetMediumQuality startRequestICloud:nil iCloudProgressHandler:nil exportProgressHandler:^(float progress, HXPhotoModel * _Nullable model) {
     // 导出视频时的进度，在iCloud下载完成之后
     } success:^(NSURL * _Nullable videoURL, HXPhotoModel * _Nullable model) {
     // 导出完成, videoURL
     
     } failed:nil];
     
     // 也可以不用上面的方法获取，自己根据 model.asset 这个PHAsset对象来获取想要的东西
     PHAsset *asset = model.asset;
     // 自由发挥
     }else {
     // 本地视频或者网络视频
     if (model.cameraVideoType == HXPhotoModelMediaTypeCameraVideoTypeLocal) {
     // 本地视频
     // model.videoURL 视频的本地地址
     }else if (model.cameraVideoType == HXPhotoModelMediaTypeCameraVideoTypeNetWork) {
     // 网络视频
     // model.videoURL 视频的网络地址
     // model.networkPhotoUrl 视频封面网络地址
     }
     }
     }
     }
     */
    
    
}
- (void)photoViewCurrentSelected:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    for (HXPhotoModel *photoModel in allList) {
        NSSLog(@"当前选择----> %@", photoModel.selectIndexStr);
    }
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.publishView.frame = CGRectMake(0, CGRectGetMaxY(self.photoView.frame)+10, self.view.hx_w, kPublishViewHeight);
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}
- (void)photoViewPreviewDismiss:(HXPhotoView *)photoView {
    //    [self changeStatus];
}
- (void)photoViewDidCancel:(HXPhotoView *)photoView {
    //    [self changeStatus];
}
- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}
- (BOOL)photoView:(HXPhotoView *)photoView collectionViewShouldSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(HXPhotoModel *)model {
    return YES;
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView gestureRecognizer:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    return self.needDeleteItem;
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    NSSLog(@"长按手势开始了 - %ld",indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    NSSLog(@"长按手势改变了 %@ - %ld",NSStringFromCGPoint(point), indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    NSSLog(@"长按手势结束了 - %ld",indexPath.item);
    
}

#pragma mark - < HXPhotoViewCellCustomProtocol >
//- (UIView *)customView:(HXPhotoSubViewCell *)cell indexPath:(NSIndexPath *)indexPath {
//
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor redColor];
//
//    return view;
//}
//- (CGRect)customViewFrame:(HXPhotoSubViewCell *)cell indexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item == 4) {
//        return CGRectMake(40, 40, 40, 40);
//    }
//    return CGRectMake(10, 10, 40, 40);
//}
//- (BOOL)shouldHiddenBottomType:(HXPhotoSubViewCell *)cell indexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item == 2) {
//        return YES;
//    }
//    return NO;
//}


#pragma mark - <YSCVlogPublishViewDelegate>
//选择话题
- (void)didTopicViewClicked{
    VLTopicViewController *topicListVC = [[VLTopicViewController alloc] init];
    NCWeakSelf(self);
    topicListVC.selectTopicBlock = ^(NSInteger topicid, NSString * _Nonnull topTitle) {
        weakself.topicId = topicid;
        [weakself.publishView refreshIndfo:topTitle];
    };
    topicListVC.modalPresentationStyle = UIModalPresentationFullScreen;
    topicListVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:topicListVC animated:YES completion:nil];
}
//选择地点
- (void)didLocationViewClicked{
    
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(kSCREEN_WIDTH - 50, 0.0f, 40.0f, 40.0f);
          [_closeButton setBackgroundImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];
          [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.alwaysBounceVertical = YES;
    }
    return _mainScrollView;
}

- (HXPhotoView *)photoView{
    if (!_photoView) {
        CGFloat width = _mainScrollView.frame.size.width;
        _photoView = [HXPhotoView photoManager:self.manager scrollDirection:UICollectionViewScrollDirectionVertical];
        _photoView.frame = CGRectMake(0, kPhotoViewMargin, width, 0);
        _photoView.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //        photoView.spacing = kPhotoViewMargin;
        _photoView.lineCount = 4;
        _photoView.delegate = self;
        _photoView.cellCustomProtocol = self;
        _photoView.outerCamera = YES;
        //        photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
        _photoView.previewShowDeleteButton = YES;
        _photoView.showAddCell = YES;
        //        photoView.showDeleteNetworkPhotoAlert = YES;
        //        photoView.adaptiveDarkness = NO;
        [_photoView.collectionView reloadData];
    }
    return _photoView;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        //        _manager.configuration.openCamera = NO;
        _manager.configuration.type = HXConfigurationTypeWXChat;
        _manager.configuration.reverseDate = YES;
        _manager.configuration.useWxPhotoEdit = YES;//是否仿微信编辑
        _manager.configuration.cameraPhotoJumpEdit = NO;
        _manager.configuration.selectTogether = NO;
        _manager.configuration.supportRotation = NO;
        //        _manager.configuration.rowCount = 3;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.showOriginalBytes = YES;
        _manager.configuration.showOriginalBytesLoading = YES;
        _manager.configuration.requestImageAfterFinishingSelection =YES;
        //                _manager.configuration.photoEditConfigur.aspectRatio = HXPhotoEditAspectRatioType_Original;
        //                _manager.configuration.photoEditConfigur.customAspectRatio = CGSizeMake(1, 1);
        //        _manager.configuration.lookLivePhoto = YES;
        //                _manager.configuration.photoEditConfigur.onlyCliping = YES;
        //        _manager.configuration.navBarBackgroundImage = [UIImage imageNamed:@"APPCityPlayer_bannerGame"];
        HXWeakSelf
        _manager.configuration.photoListBottomView = ^(HXPhotoBottomView *bottomView) {
            //            bottomView.bgView.translucent = NO;
            //            if ([HXPhotoCommon photoCommon].isDark) {
            //                bottomView.bgView.barTintColor = [UIColor blackColor];
            //            }else {
            //                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //            }
        };
        _manager.configuration.previewBottomView = ^(HXPhotoPreviewBottomView *bottomView) {
            //            bottomView.bgView.translucent = NO;
            //            bottomView.tipView.translucent = NO;
            //            if ([HXPhotoCommon photoCommon].isDark) {
            //                bottomView.bgView.barTintColor = [UIColor blackColor];
            //                bottomView.tipView.barTintColor = [UIColor blackColor];
            //            }else {
            //                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //                bottomView.tipView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //            }
        };
        
        //        _manager.configuration.photoEditConfigur.requestChartletModels = ^(void (^ _Nonnull chartletModels)(NSArray<HXPhotoEditChartletTitleModel *> * _Nonnull)) {
        //            // 模仿网络请求获取贴图资源
        //            HXPhotoEditChartletTitleModel *netModel = [HXPhotoEditChartletTitleModel modelWithNetworkNURL:[NSURL URLWithString:@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy_s_highlighted.png"]];
        //            NSString *prefix = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/chartle/xxy%d.png";
        //            NSMutableArray *netModels = @[].mutableCopy;
        //            for (int i = 1; i <= 40; i++) {
        //                [netModels addObject:[HXPhotoEditChartletModel modelWithNetworkNURL:[NSURL URLWithString:[NSString stringWithFormat:prefix ,i]]]];
        //            }
        //            netModel.models = netModels.copy;
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                // 这里没有模仿做缓存处理，需要自己做缓存处理
        //                if (chartletModels) {
        //                    chartletModels(@[netModel]);
        //                }
        //            });
        //        };
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}

- (YSCVlogPublishView *)publishView{
    if (!_publishView) {
        
        _publishView = [[YSCVlogPublishView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoView.frame), self.view.hx_w, kPublishViewHeight)];
        _publishView.backgroundColor = [UIColor whiteColor];
        _publishView.titleField.delegate = self;
        _publishView.delegate = self;
    }
    return _publishView;
}

- (UIButton *)publishButton{
    
    if (!_publishButton) {
        CGSize selfSize = self.view.jk_size;
        _publishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, selfSize.height-150, 300, 50)];
        _publishButton.jk_centerX = self.view.jk_centerX;
        _publishButton.layer.cornerRadius = 25;
        [_publishButton setTitle:@"发布笔记" forState:UIControlStateNormal];
        [_publishButton setBackgroundColor:kCOLOR_THEME];
        [_publishButton addTarget:self action:@selector(actionPublish:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        [self preferredStatusBarUpdateAnimation];
        //        [self changeStatus];
    }
#endif
}
- (UIStatusBarStyle)preferredStatusBarStyle {
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIStatusBarStyleLightContent;
        }
    }
#endif
    return UIStatusBarStyleDefault;
}


//- (void)changeStatus {
//#ifdef __IPHONE_13_0
//    if (@available(iOS 13.0, *)) {
//        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//            return;
//        }
//    }
//#endif
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//}

@end
