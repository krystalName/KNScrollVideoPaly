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
///背景图片
@property (strong, nonatomic)  UIImageView *bgimg;
///信息Lable
@property (strong, nonatomic)  UILabel *infoLLab;
///底部View;
@property (strong, nonatomic)  UIView *bottomView;


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

-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [[UIButton alloc]init];
        [_playButton setImage:[UIImage imageNamed:@"CellPaly"] forState:UIControlStateNormal];
        [_playButton sizeToFit];
    }
    return _playButton;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"专家在线解密，一小时了解市场行情!/n10月20日，您绝对不能错过的价值万元教学您绝对不能错过的价值万元教学您绝对不能错过的价值万元教学全文";
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.backgroundColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor blackColor];
    }
    return _bottomView;
}

-(UIButton *)headImageButton{
    if (!_headImageButton) {
        _headImageButton = [[UIButton alloc]init];
        [_headImageButton setImage:[UIImage imageNamed:@"120"] forState:UIControlStateNormal];
        _headImageButton.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageButton;
}
@end
