import ShopInfo from '../viewmodel/ShopInfo'

@Component // 组件
export default struct ShopItem { // 组件定义
  shop!: ShopInfo // 组件参数

  constructor(shop: ShopInfo) {
    super()
    this.shop = shop
  }

  build() { // 组件入口，必要
    Column({ space: 5 }) { // 布局容器
      Row() { // 商铺名称
        Text(this.shop.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .ellipsisTextOverFlow()
      }.width('100%')

      Row() { // 商铺地址
        Text(this.shop.address) // 文本组件
          .fontColor('#a3a3a3')
          .ellipsisTextOverFlow() // 引用自定义样式
      }.width('100%')

      Row({ space: 5 }) {
        Rating({ rating: this.shop.score / 10, indicator: true }).stars(5).stepSize(0.1)
        Text(`${this.shop.score / 10}`).fontColor('#FFB04D')
        Text(`${this.shop.comments}条`).fontColor('#222')
        Blank()
        Text(`￥${this.shop.avgPrice}/人`)
      }.width('100%')

      List({ space: 10 }) {
        ForEach(this.shop.images, (image:string) => {
          ListItem() {
            Column() {
              Image(image)
                .width(150).aspectRatio(1.1).borderRadius(5)
            }
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .width('100%')
    }
    .width('100%')
    .height(240)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(15)
    .shadow({ radius: 6, color: '$1F000000', offsetX: 2, offsetY: 4 })
  }
}

// 样式处理
@Extend(Text) // 扩展指定样式
function ellipsisTextOverFlow(line: number = 1) {
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .maxLines(line)
}