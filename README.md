# KNScrollVideoPaly
简单的播放器。 类似新浪微博。 优酷～   tableView格式播放完自动滑动播放下一个～   

## 上一张效果图

![](https://github.com/krystalName/KNScrollVideoPaly/blob/master/KNScrollVideoGif.gif)

### 说明一下demo的制作思路
+ 首先封装一个控制视频进度的滑杆。 和暂停播放按钮。视频时间显示
+ 再封装一个AVPlayer。和上面的控件结合起来。 形成了一个完整的播放器。
+ 再次封装一个tableView 里面放一个内容的View 来承载这个播放器。
+ 请求接口。获取到视频的url。 放入播放器。缓冲。播放

### 难点说明。
+ 要考虑打开页面。 第一次播放的时候。其他页面用黑色的View 遮住。
+ 要考虑滑动的时候。选择一个适当的视频来播放。把正在播放的视频停止。
+ 要考虑播放完之后。如何移动到下一个cell 继续播放
+ 要考虑明暗控制。 当前正在播放的时候。遮掩View 消失。 其他的显示


### 难点代码！


``` objc 
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
```




