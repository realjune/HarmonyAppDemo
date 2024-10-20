@Entry
@Component
struct ImageSizeDemo {
  @State message: string = '调整图片高度'
  @State imgWidth: number = 100

  build() {
    Column() {
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Row() {
        Image($r('app.media.icon'))
          .interpolation(ImageInterpolation.High) // 图片质量
          .width(this.imgWidth)
          .backgroundColor('#889900')
        // Image('https://img0.baidu.com/it/u=17675285,320806080&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313')
        //   .width(100)
      }.height(400)
      .width('100%')
      .margin({ top: 20, left: 20, right: 20, bottom: 20 })
      .justifyContent(FlexAlign.Center)

      Row() {
        Text($r('app.string.image_width_label')).fontSize(20)
          .fontWeight(FontWeight.Bold) // 文字样式

        TextInput({ placeholder: '宽度', text: this.imgWidth.toFixed(0) }) // toFixed
          .backgroundColor('#FFF')
          .type(InputType.Number) // 输入类型
          .onChange(value => {
            this.imgWidth = parseInt(value)
          })
      }
      .width('100%')
      .padding({ left: 14, right: 14 })
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().width('91%')

      Row() {
        Button('放大').width(80).height(20).type(ButtonType.Capsule)
          .onClick(() => {
            this.imgWidth += 20
          })
        Button('缩小').width(80).height(20).type(ButtonType.Capsule) // button样式
          .onClick(() => {
            this.imgWidth -= 20
          })
      }.width('100%')
      .margin({ top: 35, bottom: 30 })
      .justifyContent(FlexAlign.SpaceAround)

      Slider({
        min: 100,
        max: 300,
        value: this.imgWidth,
        step: 10, // 步长
        style: SliderStyle.OutSet, // Inset：滑块在内部，OutSet：滑块在外部
        direction: Axis.Horizontal, // 横竖向
        reverse: false // 是否反向滑动
      })
        .width('100%')
        .trackThickness(5) // ?
        .showTips(true)
        .onChange(value => {
          this.imgWidth = value
        })
    }
    .width('90%')
    .height('100%')
    .margin({ left: '5%', top: 20, right: 20, bottom: '5%' })
    // .justifyContent(FlexAlign.SpaceAround)
  }
}