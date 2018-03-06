# KNScrollVideoPaly
简单的播放器。 类似新浪微博。 优酷～   tableView格式播放完自动滑动播放下一个～   

## 上一张效果图

![](https://github.com/krystalName/KNScrollVideoPaly/blob/master/KNScrollVideoGif.gif)

### 说明一下demo的制作思路
+ 首先封装一个控制视频进度的滑杆。 和暂停播放按钮。视频时间显示
+ 再封装一个AVPlayer。和上面的控件结合起来。 形成了一个完整的播放器。
+ 再次封装一个tableView 里面放一个内容的View 来承载这个播放器。
+ 请求接口。获取到视频的url。 放入播放器。缓冲。播放

#### 难点说明。
+ 要考虑打开页面。 第一次播放的时候。其他页面用黑色的View 遮住。
+ 要考虑滑动的时候。选择一个适当的视频来播放。把正在播放的视频停止。
+ 要考虑播放完之后。如何移动到下一个cell 继续播放


