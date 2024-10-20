@Component
export struct Header {
  private title!: ResourceStr
  fontColor: ResourceColor = Color.Black

  build() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(30)
      Text(this.title)
        .fontSize(30)
        .fontColor(this.fontColor)
        .fontWeight(FontWeight.Bold)
      Blank().layoutWeight(1)
      Image($r('app.media.ic_public_refresh'))
        .width(30)
    }
  }
}