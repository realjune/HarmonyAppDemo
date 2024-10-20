import { Header } from '../component/Header'
import ShopModel, { SHOP_HOST } from '../model/ShopModel'
import ShopItem from '../view/ShopItem'
import ShopInfo from '../viewmodel/ShopInfo'

@Entry
@Component
struct ShopPage {
  // 列表数据
  @State shops: ShopInfo[] = []
  // 是否加载中
  isLoading: boolean = false
  // 是否有更多
  isMore: boolean = true



  aboutToAppear() {
    // 加载数据
    ShopModel.pageNo = 1
    this.loadShopInfo()
  }

  build() {
    Column() {
      Header({ title: '商铺列表' })

      // 列表容器
      List({ space: 10 }) {
        ForEach(this.shops, (item: ShopInfo, index) => {
          ListItem() {
            ShopItem({ shop: item })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(() => {
        console.log('触底了')
        if (!this.isLoading && this.isMore) {
          // 翻页
          ShopModel.pageNo++
          this.loadShopInfo()
        }
      })
    }
    .height('100%')
    .width('100%')
    .padding(10)
    .backgroundColor('#E2E2E2')
  }

  loadShopInfo() {
    this.isLoading = true
    console.log(`ShopPage loadShopInfo.. size: ${this.shops?.length}, isLoading: ${this.isLoading}, hasMore:${this.isMore}, page:${ShopModel.pageNo}`)
    // 加载数据
    ShopModel.getShopListAxios()
      .then(shops => {
        shops.forEach(s => {
          s.images.forEach((src, i) => {
            console.log(`getShopList ${src}`)
            // 修正图片下载地址
            s.images[i] = `${SHOP_HOST}${src}`
          })
        })
        this.shops = this.shops.concat(shops)
        console.log(`ShopPage ShopData Changed.. size: ${this.shops?.length}`)
        this.isLoading = false
        if (!shops || shops.length === 0) {
          this.isMore = false
        }
      })
  }
}
