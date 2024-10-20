@Entry
@Component
struct AnimationTest {
  @State message: string = 'Hello World'
  @State x:number = 40
  @State y:number = 40
  @State angle:number = 0


  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Image($r('app.media.fish'))
          .width(80)
          .height(80)
          .position({ x: this.y, y: this.y })
          .rotate({ angle: this.angle, centerX: '50%', centerY: '50%' })
          .animation({duration:500, iterations:1, curve:Curve.EaseInOut})
          // .translate({ x: 20, y: 40, z: 0 })
          .onClick(()=>{
            this.y+=5;
            this.angle+=20
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}