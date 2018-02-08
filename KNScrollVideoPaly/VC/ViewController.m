//
//  ViewController.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/26.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "ViewController.h"
#import "KNScrollPlayerVideoView.h"
#import <Masonry.h>
@interface ViewController ()

@property(nonatomic, strong) KNScrollPlayerVideoView *KNPlayerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.KNPlayerView];
    [self.KNPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}



-(KNScrollPlayerVideoView *)KNPlayerView{
    if (!_KNPlayerView) {
        _KNPlayerView = [[KNScrollPlayerVideoView alloc]init];
    }
    return _KNPlayerView;
}


@end
