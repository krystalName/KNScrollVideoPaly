//
//  KNVideoPlayerView.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNVideoSlider.h"
#import <AVFoundation/AVFoundation.h>


@class KNVideoPlayerView;


typedef void (^VideoCompletedPlayingBlock) (KNVideoPlayerView *);


@interface KNVideoPlayerView : UIView

@property (nonatomic, copy) VideoCompletedPlayingBlock completedPlayingBlock;
@property (nonatomic, strong) KNVideoSlider *slider;
@property (nonatomic,strong) AVPlayer *player;


///视频路径
@property(nonatomic, strong) NSString *videoUrl;

///视频暂停
-(void)playPause;

///销毁播放器
-(void)destroyPlayer;

///在cell上播放必须绑定TableView、当前播放cell的IndexPath
- (void)playerBindTableView:(UITableView *)bindTableView currentIndexPath:(NSIndexPath *)currentIndexPath;

///在scrollview的scrollViewDidScroll代理中调用
- (void)playerScrollIsSupportSmallWindowPlay:(BOOL)support;

//进度条和播放暂停按钮
- (void)setStatusBarHidden:(BOOL)hidden;

@end
