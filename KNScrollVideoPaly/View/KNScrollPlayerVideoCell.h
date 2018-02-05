//
//  KNScrollPalyerVideoCell.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/2.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNScrollPlayVideoModel.h"

@protocol KNScrollPlayerDelegate<NSObject>

-(void)playerTapActionWithIsShouldToHideSubviews:(BOOL)isHide;
-(void)playerButtonClick:(UIButton *)sneder;

@end

@interface KNScrollPlayerVideoCell : UITableViewCell

///滑动上去的时候。显示黑色背景颜色View;
@property (nonatomic, strong) UIView *topBlackView;
///第一次播放video的时候背景图片
@property (nonatomic, strong) UIView*videoFirstImageView;

@property (nonatomic, weak) id<KNScrollPlayerDelegate> delegate;
///视频背景View;
@property (nonatomic, strong) UIView *videoBackView;
///Row
@property(nonatomic, assign) NSInteger row;
///model
@property(nonatomic, retain) KNScrollPlayVideoModel * model;


@end
