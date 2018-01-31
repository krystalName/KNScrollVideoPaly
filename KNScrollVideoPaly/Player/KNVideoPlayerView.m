//
//  KNVideoPlayerView.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNVideoPlayerView.h"

static CGFloat const barAnimateSpeed = 0.5f;
static CGFloat const barShowDuration = 5.0f;
static CGFloat const opacity = 0.7f;
static CGFloat const bottomBaHeight = 40.0f;
static CGFloat const playBtnSideLength = 60.0f;

@interface KNVideoPlayerView ()

/**videoPlayer superView*/
@property (nonatomic, strong) UIView *playSuprView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) UILabel *totalDurationLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIWindow *keyWindow;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) CGRect playerOriginalFrame;
@property (nonatomic, strong) UIButton *zoomScreenBtn;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/**video player*/
/**video total duration*/
@property (nonatomic, assign) CGFloat totalDuration;
@property (nonatomic, assign) CGFloat current;

@property (nonatomic, strong) UITableView *bindTableView;
@property (nonatomic, assign) CGRect currentPlayCellRect;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, assign) BOOL isOriginalFrame;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL barHiden;
@property (nonatomic, assign) BOOL inOperation;
@property (nonatomic, assign) BOOL smallWinPlaying;

@end

@implementation KNVideoPlayerView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
