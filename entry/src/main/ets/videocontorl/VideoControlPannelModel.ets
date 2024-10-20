import { Logger } from "../common/util/Logger";
import { ControlType } from "./GestureRecognition";
import { PanGestureBase, PanGestureInfo } from "./PanGestureBase";
import { VideoControlViewModel } from "./VideoControlViewModel";

const TAG = 'ss_gesture'

export class ModelCenter {
  viewModel: VideoControlViewModel = new VideoControlViewModel()
  controlType: ControlType = ControlType.None
  isPlaying: boolean = false
  volume: number = 50;
  progress: number = 20;
  duration: number = 100;


}

export class VideoControlPannelModel extends PanGestureBase {

  isLeft: boolean = false

  onVerticalStart(localX: number, localY: number, area: Area) {
    super.onVerticalStart(localX, localY, area)
    if (localX) {
      this.isLeft = localX < (area.height as number) / 2;
    }
  }

  /**
   * 设置音量
   */
  onVerticalMove(gestureInfo: PanGestureInfo) {
    let offset = gestureInfo.getLastOffsetY();
    if (this.isLeft) {
      this.updateControlType(offset < 0 ? ControlType.VOL_UP : ControlType.VOL_DOWN)
    } else {
      this.updateControlType(offset < 0 ? ControlType.BRIGHTNEESS_UP : ControlType.BRIGHTNEESS_DOWN)
    }
    if (this.isLeft) {
      this.onGstChangingVolume(offset)
    } else {
      this.onGstChangingBrightness(offset)
    }
  }

  onVerticalEnd() {
    super.onVerticalEnd()
    if (this.isLeft) {
      this.onGstSetVolume()
    } else {
      this.onGstSetBright()
    }
  }

  onHorizontalMove(gestureInfo: PanGestureInfo) {
    let offset = gestureInfo.getLastOffsetX();
    this.updateControlType(offset > 0 ? ControlType.FORWARD : ControlType.REWIND)
    this.onGstSeeking(offset / 2)
  }

  onHorizontalEnd() {
    super.onHorizontalEnd()
    this.onGstSeek()
  }

  modelCenter: ModelCenter = new ModelCenter()

  updateControlType(ct: ControlType) {
    this.modelCenter.controlType = ct
    Logger.d(TAG, 'updateControlType ' + ct)
  }

  timeoutId?: number = undefined

  setIsVisible(visible: boolean) {
    this.modelCenter.viewModel.visible = visible
  }

  handleClick = () => {
    this.setIsVisible(true);
    // Clear any existing timeout
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
    }

    // Set a new timeout to hide the component after 3 seconds
    const id = setTimeout(() => {
      this.setIsVisible(false)
    }, 3000);
    this.timeoutId = id;
  };

  onPauseOrContinue() {
    this.modelCenter.isPlaying = !this.modelCenter.isPlaying
    this.modelCenter.viewModel.playing = this.modelCenter.isPlaying
    Logger.d(TAG, 'onPauseOrContinue')
  }

  /**
   * [手势]调整音量进度条
   */
  onGstChangingVolume(percent: number): void {
    let deltaVol: number = percent * 100
    this.modelCenter.volume += deltaVol
    Logger.d(TAG, 'onGstChangingVolume ' + this.modelCenter.volume)
    this.modelCenter.viewModel.text = `Volume:${this.modelCenter.volume}`
  }

  /**
   * [手势]调整音量进度条
   */
  onGstChangingBrightness(percent: number): void {
    let deltaVol: number = percent * 100
    this.modelCenter.volume += deltaVol
    Logger.d(TAG, 'onGstChangingBrightness ' + this.modelCenter.volume)
    this.modelCenter.viewModel.text = `Bright:${this.modelCenter.volume}`
  }

  /**
   * 设置音量
   */
  onGstSetVolume(): void {
    Logger.d(TAG, 'onGstSetVolume ')
    this.setVolume()
  }

  /**
   * 设置音量
   */
  onGstSetBright(): void {
    Logger.d(TAG, 'onGstSetBright ')
    this.setVolume()
  }

  setVolume() {

  }

  /**
   * [手势]根据滑块位置跳转进度
   */
  onGstSeek(): void {
    Logger.d(TAG, 'onGstSeek...')
    this.seek()
  }

  /**
   * 按钮控制进度
   */
  onBtnSeeking(step: number, onHold: boolean): void {
    this.modelCenter.viewModel.isSeeking = true
    this.modelCenter.progress += step
    Logger.d(TAG, 'onBtnSeeking step=' + step)
    if (!onHold) {
      this.seek()
    }
  }

  /**
   * [手势]改变进度条滑块位置
   */
  onGstSeeking(percent: number): void {
    this.modelCenter.viewModel.isSeeking = true
    let progress: number = this.modelCenter.duration * percent
    this.modelCenter.progress += progress
    Logger.d(TAG, 'onGstSeeking-Seeking ' + this.modelCenter.progress)
    this.modelCenter.viewModel.text = `SEEK:${this.modelCenter.progress}/${this.modelCenter.duration}`
  }

  seek(): void {
    // this.sendControlCommand('seek', this.modelCenter.progress)
    this.modelCenter.viewModel.isSeeking = false
    Logger.d(TAG, 'onGstSeeking-isSeeking false')
    this.modelCenter.viewModel.text = ''
  }
}