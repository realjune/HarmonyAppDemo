import { START_TIME } from '../common/constant/PlayerConstants'

/**
 * video player model
 */
export class VideoPlayerModel {
  public currentTime: number = 0
  public durationTime: number = 0
  public isPlay: boolean = false
  public isOpacity: boolean = false // 不透明度
  public durationStringTime: string = START_TIME
  public currentStringTime: string = START_TIME
  public flag: boolean = false
  public isLoading: boolean = false
  public progressVal: number = 0
  public controller: VideoController = new VideoController()
}