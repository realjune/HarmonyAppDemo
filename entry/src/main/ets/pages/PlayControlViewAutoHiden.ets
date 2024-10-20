import { Logger } from '../common/util/Logger';
import { ControlType } from '../videocontorl/GestureRecognition';
import { VideoControlPannelModel } from '../videocontorl/VideoControlPannelModel';
import { VideoControlViewModel } from '../videocontorl/VideoControlViewModel';

const TAG='ss_videoGiest'
@Entry
@Component
struct PlayControlViewAutoHiden {
  @State message: string = 'cickMe';
  @State model:VideoControlPannelModel = new VideoControlPannelModel()
  @State viewModel:VideoControlViewModel=this.model.modelCenter.viewModel

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50).backgroundColor('#998800')
          .fontWeight(FontWeight.Bold)
        Row() {
          Text('control').fontSize(40).onClick(() => {
            this.model.handleClick()
          }).visibility(this.viewModel.visible ? Visibility.Visible : Visibility.Hidden)
          Text('play:' + this.viewModel.playing).fontSize(40)
        }
          Text(this.viewModel.text)
      }
      .height(250)
      // .onClick(()=>{
      //   Logger.d(TAG, 'onClick:')
      //   this.model.handleClick()
      // })
      // .gesture(
      //   TapGesture({ count: 2 })
      //     .onAction((event: GestureEvent) => {
      //       if (event) {
      //         let value = JSON.stringify(event.fingerList[0])
      //         Logger.d(TAG, 'TapGesture-onAction:'+value)
      //       }
      //     })
      // )
      // .onTouch((event)=>{
      //   Logger.d(TAG, 'event:'+event.type)
      // })
      .priorityGesture(
        GestureGroup(GestureMode.Exclusive,
          // 双击暂停/播放
          TapGesture({ count: 2, fingers: 1 })
            .onAction(() => {
              this.model.updateControlType(ControlType.PAUSE_OR_CONTINUE)
              this.model.onPauseOrContinue()
            }),
          // 音量控制
          PanGesture({ direction: PanDirection.Vertical, distance: 5 })
            .onActionStart((event: GestureEvent) => {
              let localY = event.fingerList[event.fingerList.length-1].localY
              this.model.onVerticalStart(event.fingerList[event.fingerList.length-1].localX, localY,event.target.area)
            })
            .onActionUpdate((event) => {
              this.model.onVerticalUpdate(event)
            })
            .onActionEnd(() => {
              this.model.onVerticalEnd()
            })
          ,

          // 播放进度控制
          PanGesture({ direction: PanDirection.Horizontal, distance: 5 })
            .onActionStart((event: GestureEvent) => {
              let localY = event.fingerList[event.fingerList.length-1].localY
              this.model.onHorizontalStart(event.fingerList[event.fingerList.length-1].localX, localY,event.target.area)
            })
            .onActionUpdate((event: GestureEvent) => {
              this.model.onHorizontalUpdate(event)
            })
            .onActionEnd((event: GestureEvent) => {
              this.model.onHorizontalEnd()
            })
        )
      )
      // .onTouchIntercept({
      //   (data: TouchEvent): HitTestMode{
      //     return
      // }
      // } as Callback<TouchEvent, HitTestMode>)
      .backgroundColor('#009283')
      .width('100%')
    }
    .height('100%')
  }
}