@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State imageWidth: number = 30

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Image($r('app.media.icon'))
          .width(this.imageWidth)
          .interpolation(ImageInterpolation.High)

        Text($r('app.string.image_width_label'))
          .fontSize(20)
          .fontWeight(FontWeight.Normal)

        TextInput({ placeholder: 'pls input something', text: this.imageWidth.toFixed(0) }) // toFixed转字符串保留小数位数
          .width(120)
          .backgroundColor('#FF0000')
          .type(InputType.Number)
          .onChange(value => {
            this.imageWidth = parseInt(value)
            console.log('textInput:' + value)
          })
        Button('缩小')
          .width(100)
          .fontSize(20)
          .onClick(event => {
            if (this.imageWidth >= 10) {
              this.imageWidth -= 5
            } else {
              this.imageWidth = 0;
            }
          })

        Button('放大')
          .width(100)
          .type(ButtonType.Normal)
          .onClick(event => {
            if (this.imageWidth < 300) {
              this.imageWidth += 5
            } else {
              this.imageWidth = 0;
            }
          })
        Slider({
          min: 2,
          max: 300,
          value: this.imageWidth,
          step: 10,
          direction: Axis.Horizontal
        })
          .width('90%')
          .trackThickness(5)
          .showTips(true)
          .blockColor('#36D')
          .onChange((value => {
            this.imageWidth = value
          }))
      }
      .width('100%')
    }
    .height('100%')
  }
}