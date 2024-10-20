export enum ControlType {
  None,
  VOL_UP,
  VOL_DOWN,
  BRIGHTNEESS_UP,
  BRIGHTNEESS_DOWN,
  FORWARD,
  REWIND,
  PAUSE_OR_CONTINUE
}

/**
 * 手势识别
 * @param offsetX
 * @param offsetY
 * @returns 手势类别
 */
export function controlTypeRecognizer(offsetX: number, offsetY: number): ControlType {
  switch ((-offsetY) > offsetX) {
    case true:
      return (-offsetY) > -offsetX ? ControlType.VOL_UP : ControlType.REWIND
    case false:
      return (-offsetY) > -offsetX ? ControlType.FORWARD : ControlType.VOL_DOWN
  }
}
