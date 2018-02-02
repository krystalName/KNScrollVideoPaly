//
//  KNScrollPlayVideoModel.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/2/1.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNScrollPlayVideoModel : NSObject

///是否播放过
@property (nonatomic, assign) BOOL isShouldToPlay;
///
@property (nonatomic, assign) BOOL isLight;

///内容
@property (nonatomic, strong) NSString * cover;
///标题
@property (nonatomic, strong) NSString * title;
///视频URL
@property (nonatomic, strong) NSString * video_Url;

@end
