import router from '@ohos.router'

@Entry
@Component
struct AnimationPage {
  // 坐标
  @State fishX: number = 200
  @State fishY: number = 180
  // 角度
  @State angle: number = 0
  // 图片
  @State src: Resource = $r('app.media.fish')

  // 是否开始
  @State isBegin: boolean = false

  build() {
    Row() {
      Stack() {
        Button('返回')
          .position({ x: 0, y: 0 })
          .backgroundColor('#20101010')
          .onClick(() => {
            router.back()
          })

        if (!this.isBegin) {
          // 开始按钮
          Button('游戏开始')
            .onClick(() => {
              animateTo({ duration: 1000 }, () => {
                // 点击后显示图片
                this.isBegin = true
              })
            })
        } else {
          // 图片
          Image(this.src)
            .position({ x: this.fishX - 20, y: this.fishY - 20 })
            .rotate({ angle: this.angle, centerX: '50%', centerY: '50%' })
            .width(40)
            .height(40)
            .transition({ type: TransitionType.Insert, opacity: 0, translate: { x: -250 } })
        }

        Row() {
          Button('←').backgroundColor('#20101010')
            .onClick(() => {
              animateTo({ duration: 500 }, () => {
                this.fishX -= 20
                this.src = $r('app.media.fish_rev')
              })
            })
          Column({ space: 40 }) {
            Button('↑').backgroundColor('#20101010')
              .onClick(() => {
                animateTo({ duration: 500 }, () => {
                  this.fishY -= 20
                })
              })
            Button('↓').backgroundColor('#20101010')
              .onClick(() => {
                animateTo({ duration: 500 }, () => {
                  this.fishY += 20
                })
              })
          }

          Button('→').backgroundColor('#20101010')
            .onClick(() => {
              animateTo({ duration: 500 }, () => {
                this.fishX += 20
                this.src = $r('app.media.fish')
                console.log(`animRight: ${this.fishX}`)
              })
            })
        }
        .width(240).height(240)
        .justifyContent(FlexAlign.Center)
        .position({ x: 0, y: 120 })
      }
      .height('100%').width('100%')
    }
    .height('100%').width('100%')
    .backgroundImage($r('app.media.sea'))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
}