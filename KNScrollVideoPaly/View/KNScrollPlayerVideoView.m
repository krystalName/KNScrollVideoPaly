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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
      

    }
    return self;
}

- (void)initData
{
    self.lastOrCurrentPlayIndex = 0;
    self.lastOrCurrentLightIndex = 0;
    self.lastPlayerCell = 0;
}

-(void)initView{
    ///添加table
    [self addSubview:self.tableView];
    ///注册cell
    [self.tableView registerClass:[KNScrollPlayerVideoCell class] forCellReuseIdentifier:NSStringFromClass([KNScrollPlayerVideoCell class])];
    
}

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

#pragma mark - KNScrollPlayVideoCellDelegate

-(void)playerTapActionWithIsShouldToHideSubviews:(BOOL)isHide
{
    KNScrollPlayerVideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastOrCurrentPlayIndex inSection:0]];
}

-(void)playerButtonClick:(UIButton *)sneder
{
    NSInteger row = sneder.tag - 788;
    
    if (row!=self.lastOrCurrentPlayIndex) {
        [self stopVideoWithShouldToStopIndex:self.lastOrCurrentPlayIndex];
        self.lastOrCurrentPlayIndex = row;
        [self playVideoWithShouldToPlayIndex:self.lastOrCurrentPlayIndex];
        self.lastOrCurrentLightIndex = row;
        [self shouldLightCellWithShouldLightIndex:self.lastOrCurrentLightIndex];
    }
}


#pragma make - 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KNScrollPlayerVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KNScrollPlayerVideoCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.row = indexPath.row;
    cell.model =self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeigh;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滚动方向
    if (scrollView.contentOffset.y>self.lastScrollViewContentOffsetY) {
        self.isScrollDownward = YES;
    }else{
        self.isScrollDownward = NO;
    }
    self.lastScrollViewContentOffsetY = scrollView.contentOffset.y;
    
    //停止当前播放的
    [self stopCurrentPlayingCell];
    
    //找出适合播放的并点亮
    [self filterShouldLightCellWithScrollDirection:self.isScrollDownward];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y >0 || velocity.y < 0) {
        rate = YES;
    }else{
        rate = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (rate == YES) {
        //停止的时候找出最合适的播放
        NSLog(@"滑动停止时播放1");
//        [self filterShouldPlayCellWithScrollDirection:self.isScrollDownward];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate == NO){
        //停止的时候找出最合适的播放
        NSLog(@"滑动停止时播放2");
//        [self filterShouldPlayCellWithScrollDirection:self.isScrollDownward];
    }
}

//setContentOffset: animation:
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self playNext];
}



#pragma mark - 明暗控制
- (void)filterShouldLightCellWithScrollDirection:(BOOL)isScrollDownward{
    
    KNScrollPlayerVideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastOrCurrentLightIndex inSection:0]];
    cell.topBlackView.hidden = NO;
    //顶部
    if (self.tableView.contentOffset.y<=0) {
        [self shouldLightCellWithShouldLightIndex:0];
        self.lastOrCurrentLightIndex = 0;
        return;
    }
    
    //底
    if (self.tableView.contentOffset.y+self.tableView.frame.size.height>=self.tableView.contentSize.height) {
        //其他的已经暂停播放
        [self shouldLightCellWithShouldLightIndex:self.dataArray.count-1];
        self.lastOrCurrentLightIndex=self.dataArray.count-1;
        return;
    }
    NSArray *cellsArray = [self.tableView visibleCells];
    NSArray *newArray = nil;
    if (!isScrollDownward) {
        newArray = [cellsArray reverseObjectEnumerator].allObjects;
    }else{
        newArray = cellsArray;
    }
    [newArray enumerateObjectsUsingBlock:^(KNScrollPlayerVideoCell *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog(@"合适的播放视频： %ld",(long)cell.row);
        
        CGRect rect = [cell.videoBackView convertRect:cell.videoBackView.bounds toView:self];
        CGFloat topSpacing = rect.origin.y;
        CGFloat bottomSpacing = self.frame.size.height-rect.origin.y-rect.size.height;
        if (topSpacing>=-rect.size.height/3&&bottomSpacing>=-rect.size.height/3) {
            if (self.lastOrCurrentPlayIndex==-1) {
                self.lastOrCurrentLightIndex = cell.row;
            }
            *stop = YES;
        }
    }];
    [self shouldLightCellWithShouldLightIndex:self.lastOrCurrentLightIndex];
    
}



- (void)stopCurrentPlayingCell
{
    //避免第一次播放的时候被暂停
    if (self.tableView.contentOffset.y<=0) {
        return;
    }
    if (self.lastOrCurrentPlayIndex!=-1) {
        KNScrollPlayerVideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastOrCurrentPlayIndex inSection:0]];
        CGRect rect = [cell.videoBackView convertRect:cell.videoBackView.bounds toView:self];
        CGFloat topSpacing = rect.origin.y;
        CGFloat bottomSpacing = self.frame.size.height-rect.origin.y-rect.size.height;
        //当视频播放部分移除可见区域1/3的时候暂停
        if (topSpacing<-rect.size.height/3||bottomSpacing<-rect.size.height/3) {
            self.lastOrCurrentPlayIndex  = -1;
        }
    }
}


#pragma mark - 其他方法
- (void)stopVideoWithShouldToStopIndex:(NSInteger)shouldToStopIndex{
    KNScrollPlayerVideoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:shouldToStopIndex inSection:0]];
    cell.topBlackView.hidden = NO;
}

- (void)shouldLightCellWithShouldLightIndex:(NSInteger)shouldLIghtIndex
{
    
    KNScrollPlayerVideoCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:shouldLIghtIndex inSection:0]];
    cell2.topBlackView.hidden = YES;
}

- (void)playVideoWithShouldToPlayIndex:(NSInteger)shouldToPlayIndex{
    NSIndexPath *path = [NSIndexPath indexPathForRow:shouldToPlayIndex inSection:0];
    KNScrollPlayerVideoCell *cell = [self.tableView cellForRowAtIndexPath:path];
    [self cellPlay:cell];
}


-(void)cellPlay:(KNScrollPlayerVideoCell *)cell{
    
    if(self.dataArray.count<=0){
        return;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:cell.row inSection:0];
    
    __weak typeof(self) weakSelf = self;
    __weak KNVideoPlayerView *beplayer = _player;
    if (_player && cell.row == self.lastPlayerCell) {
        return;
    }
    
    [_player removeFromSuperview];
    
    _player = [[KNVideoPlayerView alloc] init];
    _player.completedPlayingBlock = ^(KNVideoPlayerView *player) {
        
        NSLog(@"两个比较 %f%d",weakSelf.tableView.contentOffset.y  + weakSelf.tableView.frame.size.height,(int)weakSelf.tableView.contentSize.height );
        
        if (weakSelf.lastPlayerCell != weakSelf.dataArray.count-1) {
            
            if(weakSelf.tableView.contentOffset.y  + weakSelf.tableView.frame.size.height  == (int)weakSelf.tableView.contentSize.height ){
                
//                [weakSelf playNext];
                
            }else if(weakSelf.tableView.contentOffset.y  + weakSelf.tableView.frame.size.height + cellHeigh > (int)weakSelf.tableView.contentSize.height ){
                
                [weakSelf.tableView setContentOffset:CGPointMake(0, weakSelf.tableView.contentSize.height  -weakSelf.tableView.frame.size.height) animated:YES];
                
                NSLog(@"滑动到最后一个视频 %f",weakSelf.tableView.contentSize.height  -weakSelf.tableView.frame.size.height);
                
            }else {
                [weakSelf.tableView setContentOffset:CGPointMake(0, weakSelf.tableView.contentOffset.y + cellHeigh ) animated:YES];
                NSLog(@"滑动到下一个视频 %f",weakSelf.tableView.contentOffset.y + cellHeigh);
            }
        }
        [beplayer setStatusBarHidden:NO];
    };
    
    _player.slider.value = 0;
    _player.videoUrl = cell.model.video_Url;// item.mp4_url;
    [_player playerBindTableView:self.tableView currentIndexPath:path];
    _player.frame = cell.videoBackView.bounds;
    [_player.player play];
    //在cell上加载播放器
    [cell.contentView addSubview:_player];
    
    self.lastOrCurrentPlayIndex = cell.row;
    self.lastPlayerCell = cell.row;
    cell.topBlackView.hidden = YES;
}

///继续播放下一个
-(void)playNext{
    
    //中部(找出可见cell中最合适的一个进行播放)
    NSArray *cellsArray = [self.tableView visibleCells];
    [self stopVideoWithShouldToStopIndex:self.lastPlayerCell];
    
    for (KNScrollPlayerVideoCell *cell in cellsArray) {
        
        if (cell.row == self.lastPlayerCell + 1) {
            NSLog(@"播放下一个视频： %ld",(long)cell.row);
            [self cellPlay:cell];
            break;
        }
    }
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
