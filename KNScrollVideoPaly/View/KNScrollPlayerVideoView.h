//
//  KNScrollPlayerVideoView.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/5.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNScrollPlayerVideoView : UIView

-(instancetype)init;
///设置初次跳转过来。 起始播放时间
@property (nonatomic, assign) CGFloat startTimeValue;
@end
