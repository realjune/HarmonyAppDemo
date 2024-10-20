import {
  COMMON_NUM_DOUBLE,
  COMMON_NUM_MINUTE,
  STACK_STYLE,
  TIME_SPLIT,
  ZERO_STR
} from '../common/constant/PlayerConstants';
import { DurationObject } from '../view/VideoPlayer';
import { VideoPlayerModel } from './VideoPlayerModel';

/**
 * video component prepared callback
 */
export function prepared(model: VideoPlayerModel, event: DurationObject) {
  model.durationTime = event.duration;
  let second: number = event.duration % COMMON_NUM_MINUTE;
  let min: number = Number.parseInt((event.duration / COMMON_NUM_MINUTE).toString());
  let head = min < COMMON_NUM_DOUBLE ? `${ZERO_STR}${min}` : min;
  let end = second < COMMON_NUM_DOUBLE ? `${ZERO_STR}${second}` : second;
  model.durationStringTime = `${head}${TIME_SPLIT}${end}`;
  model.flag = true;
}

/**
 * video component finish callback
 */
export function finish(model: VideoPlayerModel) {
  model.isPlay = false;
  model.isOpacity = false;
}

/**
 * video slider component onchange callback
 */
export function sliderOnchange(model: VideoPlayerModel, value: number, mode: SliderChangeMode) {
  model.currentTime = Number.parseInt(value.toString());
  model.controller.setCurrentTime(Number.parseInt(value.toString()), SeekMode.PreviousKeyframe);
  if (mode === SliderChangeMode.Begin) {
    model.isOpacity = false;
  }
  if (mode === SliderChangeMode.Moving) {
    model.isOpacity = false;
  }
  if (mode === SliderChangeMode.End) {
    model.isOpacity = true;
  }
}

/**
 * get video  string of current time
 * @param model
 * @param value
 */
export function onPlayerUpdate(model: VideoPlayerModel, value: number) {
  model.currentTime = value
  model.currentStringTime = changeSliderTime(value)
}

/**
 * get video  string of current time
 * @param the number of current time
 * @return the string of current time
 */
export function changeSliderTime(value: number): string {
  let second: number = value % COMMON_NUM_MINUTE;
  let min: number = Number.parseInt((value / COMMON_NUM_MINUTE).toString());
  let head = min < COMMON_NUM_DOUBLE ? `${ZERO_STR}${min}` : min;
  let end = second < COMMON_NUM_DOUBLE ? `${ZERO_STR}${second}` : second;
  let nowTime = `${head}${TIME_SPLIT}${end}`;
  return nowTime;
}

/**
 * icon onclick callback
 */
export function iconOnclick(model: VideoPlayerModel) {
  if (model.isPlay === true) {
    model.controller.pause()
    model.isPlay = false;
    model.isOpacity = false;
    return;
  }
  if (model.flag === true) {
    model.controller.start();
    model.isPlay = true;
    model.isOpacity = true;
  } else {
    model.isLoading = true;
    // The video loading is not complete. The loading action is displayed.
    let intervalLoading = setInterval(() => {
      if (model.progressVal >= STACK_STYLE.PROGRESS_TOTAL) {
        model.progressVal = 0;
      } else {
        model.progressVal += STACK_STYLE.PROGRESS_STEP;
      }
    }, STACK_STYLE.MILLI_SECONDS)
    // The scheduled task determines whether the video loading is complete.
    let intervalFlag = setInterval(() => {
      if (model.flag === true) {
        model.controller.start();
        model.isPlay = true;
        model.isOpacity = true;
        model.isLoading = false;
        clearInterval(intervalFlag);
        clearInterval(intervalLoading);
      }
    }, STACK_STYLE.MILLI_SECONDS);
  }
}