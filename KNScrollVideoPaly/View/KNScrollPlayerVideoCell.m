//
//  KNScrollPalyerVideoCell.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/2.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNScrollPlayerVideoCell.h"


@interface KNScrollPlayerVideoCell()

///内容lLable
@property (strong, nonatomic)  UILabel *contentLabel;
///点击播放按钮
@property (strong, nonatomic)  UIButton *playButton;
///头像按钮
@property (strong, nonatomic)  UIButton *headImageButton;
///名字
@property (strong, nonatomic)  UILabel *nameLabel;
///讨论内容按钮
@property (strong, nonatomic)  UIButton *commentButton;
///喜欢按钮
@property (strong, nonatomic)  UIButton *likeButton;
///背景图片
@property (strong, nonatomic)  UIImageView *bgimg;
///信息Lable
@property (strong, nonatomic)  UILabel *infoLLab;




@end


@implementation KNScrollPlayerVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




#pragma mark - 懒加载

-(UIView *)videoBackView{
    if (!_videoBackView) {
        _videoBackView = [[UIView alloc]init];
        _videoBackView.backgroundColor = [UIColor blackColor];
    }
    return _videoBackView;
}


-(UIImageView *)bgimg{
    if (!_bgimg) {
        _bgimg = [[UIImageView alloc]init];
        [_bgimg setImage:[UIImage imageNamed:@"bgImage"]];
        _bgimg.contentMode = UIViewContentModeScaleAspectFill;
        _bgimg.backgroundColor = [UIColor clearColor];
    }
    return _bgimg;
}



@end
