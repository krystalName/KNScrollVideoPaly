//
//  KNScrollPlayerVideoView.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/5.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNScrollPlayerVideoView.h"
#import "KNScrollPlayerVideoCell.h"
#import "KNScrollPlayVideoModel.h"
#import "KNVideoPlayerView.h"
#import <AFNetworking.h>

#define KNScreenWidth [UIScreen mainScreen].bounds.size.width
#define KNScreenHeight [UIScreen mainScreen].bounds.size.height


///接口
#define videoListUrl @"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html"
#define cellHeigh 320


@interface KNScrollPlayerVideoView()<KNScrollPlayerDelegate>
{
    BOOL rate;
    KNVideoPlayerView *_player;
}
///表格
@property(nonatomic, strong) UITableView *tableView;
///数据数组
@property(nonatomic, strong) NSMutableArray *dataArray;
///最后或当前的播放指数
@property(nonatomic, assign) NSInteger lastOrCurrentPlayIndex;
///最后或当前的亮指数;
@property(nonatomic, assign) NSInteger lastOrCurrentLightIndex;

@property(nonatomic, assign) NSInteger lastPlayerCell;

///记录偏移值,用于判断上滑还是下滑
@property(nonatomic, assign) CGFloat lastScrollViewContentOffsetY;
///Yes-往下滑,NO-往上滑
@property(nonatomic, assign) BOOL isScrollDownward;


@end

@implementation KNScrollPlayerVideoView



@end
