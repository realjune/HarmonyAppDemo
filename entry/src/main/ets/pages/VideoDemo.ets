import { VideoPlayerModel } from '../model/VideoPlayerModel';
import { VideoPlayer } from '../view/VideoPlayer';
import { VideoSlider } from '../view/VideoSlider';
import { NET_VIDEO_URL } from '../common/constant/PlayerConstants'
import { Header } from '../component/Header';

@Entry
@Component
struct VideoDemo {
  @State message: string = 'Hello World';
  @Provide videoPlayerModel: VideoPlayerModel = new VideoPlayerModel();

  build() {
    Column() {
      Header({ title: '视频播放', fontColor:Color.White })

      VideoPlayer({
        source: NET_VIDEO_URL
      }).zIndex(0)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}