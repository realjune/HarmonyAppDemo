export class PanGestureInfo {

  pressMoveX: number = 0;
  pressMoveY: number = 0;
  lastMoveX: number = 0;
  lastMoveY: number = 0;
  lastDiffX: number = 0;
  lastDiffY: number = 0;
  areaWidth: number = 0
  areaHeight: number = 0

  reset() {
    this.pressMoveX = 0;
    this.pressMoveY = 0;
    this.lastMoveX = 0;
    this.lastMoveY = 0;
    this.lastDiffX = 0;
    this.lastDiffY = 0;
    this.areaWidth = 0
    this.areaHeight = 0
  }

  getXOffestPressPX() {
    return this.lastMoveX - this.pressMoveX
  }

  getYOffestPressPX() {
    return this.lastMoveY - this.pressMoveY
  }

  getLastOffsetX() {
    if (this.areaWidth) {
      return this.lastDiffX / this.areaWidth
    } else {
      return this.lastDiffX
    }
  }

  getLastOffsetY() {
    if (this.areaWidth) {
      return this.lastDiffX / this.areaWidth
    } else {
      return this.lastDiffX
    }
  }
}

export class PanGestureBase {
  gestureInfo: PanGestureInfo = new PanGestureInfo()

  onVerticalStart(localX: number, localY: number, area: Area) {
    this.initGestureInfo(localX, localY);
  }

  onHorizontalStart(localX: number, localY: number, area: Area) {
    this.initGestureInfo(localX, localY);
  }

  private initGestureInfo(localX: number, localY: number) {
    this.gestureInfo.reset();
    if (localX) {
      this.gestureInfo.pressMoveX = localX;
      this.gestureInfo.lastMoveX = localX;
    }
    if (localY) {
      this.gestureInfo.pressMoveY = localY;
      this.gestureInfo.lastMoveY = localY;
    }
  }

  /**
   * 设置音量
   */
  onVerticalUpdate(event: GestureEvent) {
    this.updateGestureInfo(event);
    this.onVerticalMove(this.gestureInfo)
  }

  onHorizontalUpdate(event: GestureEvent) {
    this.updateGestureInfo(event);
    this.onHorizontalMove(this.gestureInfo)
  }

  private updateGestureInfo(event: GestureEvent) {
    let currentX = event.fingerList[event.fingerList.length - 1].localX;
    let currentY = event.fingerList[event.fingerList.length - 1].localY;
    this.gestureInfo.areaWidth = event.target.area.width as number;
    this.gestureInfo.areaHeight = event.target.area.height as number;
    this.gestureInfo.lastDiffX = (currentX - this.gestureInfo.lastMoveX) / (this.gestureInfo.areaWidth); //(-1,1)
    this.gestureInfo.lastDiffY = (currentY - this.gestureInfo.lastMoveY) / (this.gestureInfo.areaHeight);
    this.gestureInfo.lastMoveX = currentX;
    this.gestureInfo.lastMoveY = currentY;
  }

  onVerticalMove(gestureInfo: PanGestureInfo) {
  }

  onHorizontalMove(gestureInfo: PanGestureInfo) {
  }

  onVerticalEnd() {
  }

  onHorizontalEnd() {
  }
}