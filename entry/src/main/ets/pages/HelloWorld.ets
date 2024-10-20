/**
 * Hello World
 * 测试点击事件
 */
@Entry
@Component
struct Index {
  message: string = "Hello World!"
  @State count: number = 1

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      Button(this.count.toString()).width(100).height(30).type(ButtonType.Capsule)
        .onClick(() => {
          this.count += 1
          console.log("onclick num:" + this.count)
        })
    }
    .width('90%')
    .height('100%')
  }
}