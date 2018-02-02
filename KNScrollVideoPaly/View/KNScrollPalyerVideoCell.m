//
//  KNScrollPalyerVideoCell.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/2.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNScrollPalyerVideoCell.h"


@interface KNScrollPalyerVideoCell()

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
@property (strong, nonatomic)  UIButton *likeButton;
@property (strong, nonatomic)  UIButton *shareButton;
@property (strong, nonatomic)  UIImageView *bgimg;
@property (strong, nonatomic)  UILabel *infoLLab;




@end


@implementation KNScrollPalyerVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
