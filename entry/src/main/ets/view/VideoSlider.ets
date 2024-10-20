/**
 * video slider component
 */
import {
  ALL_PERCENT,
  BIG_TRACK_THICK_NESS,
  DEFAULT_OPACITY,
  IMAGE_SIZE,
  MARGIN_FONT_SIZE,
  SMALL_TRACK_THICK_NESS,
  STRING_PERCENT
} from '../common/constant/PlayerConstants'
import { iconOnclick, sliderOnchange } from '../model/VideoControll';
import { VideoPlayerModel } from '../model/VideoPlayerModel';

@Component
export struct VideoSlider {
  @Consume videoPlayerModel: VideoPlayerModel

  build() {
    Row({ space: MARGIN_FONT_SIZE.FIRST_MARGIN }) {
      // 播放/暂停按钮
      Image(this.videoPlayerModel.isPlay ? $r('app.media.ic_player_controller_pause') :
      $r('app.media.ic_player_controller_play'))
        .width(IMAGE_SIZE).height(IMAGE_SIZE)
        .margin({ left: MARGIN_FONT_SIZE.FIRST_MARGIN })
        .onClick(() => {
          iconOnclick(this.videoPlayerModel)
        })
      // 当前播放时间
      Text(this.videoPlayerModel.currentStringTime)
        .fontSize(MARGIN_FONT_SIZE.SECOND_MARGIN)
        .fontColor(Color.White)
        .margin({ left: MARGIN_FONT_SIZE.FIRST_MARGIN })
      // 控制和显示播放进度
      Slider({
        value: this.videoPlayerModel.currentTime,
        min: 0,
        max: this.videoPlayerModel.durationTime,
        step: 1
      })
        .blockColor(Color.White)
        .width(STRING_PERCENT.SLIDER_WITH)
        .trackColor(Color.Gray)
        .selectedColor(Color.White)
        .showSteps(true)
        .showTips(true)
        .trackThickness(this.videoPlayerModel.isOpacity ? SMALL_TRACK_THICK_NESS : BIG_TRACK_THICK_NESS)
        .onChange((value: number, mode: SliderChangeMode) => {
          sliderOnchange(this.videoPlayerModel, value, mode)
        })
      // 显示视频总时长
      Text(this.videoPlayerModel.durationStringTime)
        .fontSize(MARGIN_FONT_SIZE.SECOND_MARGIN)
        .margin({ right: MARGIN_FONT_SIZE.FIRST_MARGIN })
        .fontColor(Color.White)
    }
    .opacity(this.videoPlayerModel.isOpacity ? DEFAULT_OPACITY : 1)
    .width(ALL_PERCENT)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}