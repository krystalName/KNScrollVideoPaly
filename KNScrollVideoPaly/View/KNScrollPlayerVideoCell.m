//
//  KNScrollPalyerVideoCell.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/2.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNScrollPlayerVideoCell.h"
#import <UIImageView+WebCache.h>


@interface KNScrollPlayerVideoCell()

///内容lLable
@property (strong, nonatomic)  UILabel *contentLabel;
///点击播放按钮
@property (strong, nonatomic)  UIButton *playButton;
///头像按钮
@property (strong, nonatomic)  UIImageView *headImageView;
///名字
@property (strong, nonatomic)  UILabel *nameLabel;
///背景图片
@property (strong, nonatomic)  UIImageView *bgimg;

///底部View;
@property (strong, nonatomic)  UIView *bottomView;


@end


@implementation KNScrollPlayerVideoCell

#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.videoBackView];
        [self.videoBackView addSubview:self.bgimg];
        [self.videoBackView addSubview:self.playButton];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.bottomView];
        [self.bottomView addSubview:self.nameLabel];
        [self.bottomView addSubview:self.headImageView];
        [self.contentView addSubview:self.topBlackView];

    }
    return self;
}

#pragma mark - 赋值
-(void)SetCellValue{
    
    
  
}

///点击播放
-(void)playClick:(UIButton *)sender
{
    [sender setSelected:!sender.isSelected];
    
    if ([self.delegate respondsToSelector:@selector(playClick:)]) {
        [self.delegate playerButtonClick:sender];
    }
}


#pragma mark - SBPlayerDelegate
- (void)playerTapActionWithIsShouldToHideSubviews:(BOOL)isHide
{
    if ([self.delegate respondsToSelector:@selector(playerTapActionWithIsShouldToHideSubviews:)]) {
        [self.delegate playerTapActionWithIsShouldToHideSubviews:isHide];
    }
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    self.playButton.tag = 788+row;
}


-(void)setModel:(KNScrollPlayVideoModel *)model{
    
    _model = model;
    [_bgimg sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"bgImage"]];
    _contentLabel.text = model.title;
    _nameLabel.text = @"你猜你猜？？";
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.videoBackView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.contentView);
        make.height.equalTo(@235);
    }];
    
    [self.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.videoBackView);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.videoBackView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoBackView.mas_bottom);
        make.left.width.equalTo(self.contentView);
        make.height.equalTo(@75);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.left.width.equalTo(self.contentView);
        make.height.equalTo(@40);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    [self.topBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
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
        [_playButton addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"专家在线解密，一小时了解市场行情!/n10月20日，您绝对不能错过的价值万元教学您绝对不能错过的价值万元教学您绝对不能错过的价值万元教学全文";
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
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

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView =[[UIImageView alloc]init];
        [_headImageView setImage:[UIImage imageNamed:@"120"]];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headImageView sizeToFit];
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

-(UIView *)topBlackView{
    if (!_topBlackView) {
        _topBlackView = [[UIView alloc]init];
        _topBlackView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    }
    return _topBlackView;
}

@end
