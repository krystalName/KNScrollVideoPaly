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

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KNScrollPlayerVideoView



@end
