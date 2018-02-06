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

//网络请求
- (void)fetchVideoListData {
    
    [self.dataArray removeAllObjects];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:videoListUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *dataArray = responseObject[@"VAP4BFR16"];
        
        for (NSMutableDictionary *dic in dataArray) {
            KNScrollPlayVideoModel *model = [[KNScrollPlayVideoModel alloc] init];
            model.cover = dic[@"cover"];
            model.title = dic[@"title"];
            model.video_Url = dic[@"mp4_url"];
            model.isShouldToPlay = NO;
            [self.dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        
        //设置初次播放
        [self setStartTimeValue:0];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}




#pragma mark - Getters & Setters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KNScreenWidth, KNScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionFooterHeight = 1;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KNScreenWidth, 0.001)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KNScreenWidth, 0.001)];
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
