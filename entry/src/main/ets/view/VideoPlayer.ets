/**
 * video controller component
 */
import { ALL_PERCENT, COMMON_NUM_DURATION, MESSAGE, STRING_PERCENT } from '../common/constant/PlayerConstants'
import { finish, onPlayerUpdate, prepared } from '../model/VideoControll'
import { VideoPlayerModel } from '../model/VideoPlayerModel'
import { promptAction } from '@kit.ArkUI'
import { VideoSlider } from './VideoSlider'

@Component
export struct VideoPlayer {
  source: string | Resource = ''
  previewUris: string | Resource = ''
  @Consume private videoPlayerModel: VideoPlayerModel

  build() {
    Stack() {
      Video({
        src: this.source,
        previewUri: this.previewUris,
        controller: this.videoPlayerModel.controller
      })
        .width(ALL_PERCENT)
        .height(STRING_PERCENT.NINETY_PERCENT)
        .controls(false)// 不是用播控
        .autoPlay(false)
        .objectFit(ImageFit.Contain)// 等比缩放
        .loop(false)
        .onPrepared((event ?: DurationObject) => {
          if (event !== undefined) {
            prepared(this.videoPlayerModel, event)
          }
        })
        .onUpdate((event) => {
          onPlayerUpdate(this.videoPlayerModel, event.time)
        })
        .onError(() => {
          promptAction.showToast({
            duration: COMMON_NUM_DURATION,
            message: MESSAGE
          })
        })
        .onFinish(() => {
          finish(this.videoPlayerModel)
        })
      VideoSlider()
    }.alignContent(Alignment.Bottom)
  }
}

export interface DurationObject {
  duration: number;
}