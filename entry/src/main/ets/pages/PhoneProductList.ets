import { Header } from '../component/Header'

class Item {
  name: string
  image: ResourceStr
  price: number
  discount: number

  constructor(name: string,
    image: ResourceStr,
    price: number,
    discount: number) {
    this.name = name
    this.image = image;
    this.price = price;
    this.discount = discount
  }
}

/*
 * 构建函数@Builder，应用范围可局部，可全局，看定义所在的域；
 * 函数参数，函数体域普通函数相同，编写布局内容即可；
 @Builder function Xyz(param:Type) {
  Row({space:10}) {
    Image(item.image).width(100)
  }
  .width('100%')
}
* 引用时，同普通函数一样引用；
Xyz(type)

 */
@Builder
function ItemCard(item: Item) {
  Row({ space: 10 }) {
    Image(item.image).width(100)
    Column() {
      if (item.discount > 0) {
        Text(item.name).fontSize(20).fontWeight(FontWeight.Bold).maxLines(1)
        Text('原价：￥' + item.price.toString()).priceText()
          .decoration({ type: TextDecorationType.LineThrough })
        Text('折扣价：￥' + (item.price - item.discount)).priceText()
        Text('补贴：￥' + item.discount).priceText()
      } else {
        Text(item.name).fontSize(20).fontWeight(FontWeight.Bold).maxLines(1)
        Text('原价：￥' + item.price.toString()).priceText()
        // Text('折扣价：￥'+this.item.discount.toString())
        // Text('补贴：￥'+(this.item.price-this.item.discount))
      }
    }.height('100%').layoutWeight(1).alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .height(120)
  .backgroundColor('#FFF')
  .borderRadius(10)
  .padding(10)
}

/*
 * @Styles装饰器
 * 仅可设置基类（通用）组件的属性，如width、background等；
 * 不可设置子组件特有属性，如fontSize
 */
@Styles
function fillScreen() {
  .width('100%')
  .height('100%')
  .backgroundColor('#EFEFEF')
  .padding(10)
}

/*
@Extend装饰器
* 仅可定义在全局，可以设置指定组件的特有属性，如Text的fontSize,
*
* 调用：直接作为组件函数调用，如：直接再组件Text()对象后调用.priceText()。
 */
@Extend(Text)
function priceText() {
  .width('100%')
  .fontSize(18)
  .fontColor('#EF0000')
}

@Entry
@Component
struct ProductList {
  @State message: string = 'Hello World'
  it: Item = new Item('华为Mate60',
    'https://img10.360buyimg.com/n7/jfs/t1/97904/23/42086/41945/64edc70bFee56a0c6/f4a02f8cb5ed37c2.jpg',
    7579,
    200)
  //商品列表
  private items: Item[] = [
    new Item(
      '华为Mate60',
      'https://img10.360buyimg.com/n7/jfs/t1/97904/23/42086/41945/64edc70bFee56a0c6/f4a02f8cb5ed37c2.jpg',
      7579,
      200
    ),
    new Item(
      '华为X50',
      'https://m.360buyimg.com/babel/jfs/t1/73664/1/20569/30324/659f5c44Fd113e487/e9901e632ed527bb.jpg',
      8799,
      100),
    new Item(
      '小米13Ultra 徕卡光学全焦段四摄 第二代骁龙8处理器 2K超色准屏 IP68防水 16GB+512GB橄榄绿 官方标配',
      'https://m.360buyimg.com/babel/jfs/t1/150522/31/33155/76236/6531030aFd122a378/8ce6edacca9eef45.jpg',
      4379,
      500
    ),
    new Item(
      'OppoFind12',
      'https://m.360buyimg.com/babel/jfs/t1/225279/28/1670/47898/6540a538Fca94a848/a14c9f28bb959691.jpg',
      3299, 0
    ),
    new
    Item
    (
      '魅族（MEIZU）20PRO 骁龙8Gen2 Flyme系统 超大电池 50W无线充电 5G游戏学生拍照 领克手机域 破晓灰 12+256GB',
      'https://m.360buyimg.com/babel/jfs/t20260625/69667/37/25914/9473/6498ea3cFc8cb23b4/42fd874fcb4e03ff.jpg',
      3799,
      300
    ),
    new
    Item
    (
      'Apple iPhone 15 Pro (A3104) 256GB 蓝色钛金属 支持移动联通电信5G 双卡双待手机',
      'https://m.360buyimg.com/babel/jfs/t20270402/223030/18/29011/46156/660bf1fdF74b90aff/da6e27172b7df5ec.jpg',
      6968, 0
    ),
    new
    Item
    (
      '金立2024全新4G全网通老人手机 超长待机移动联通电信广电大字大声双卡双待学生老年人功能机 蓝色',
      'https://m.360buyimg.com/babel/jfs/t20270218/243815/11/4791/49110/65d2ecbaFd73156eb/8046729c1b5bc685.jpg',
      115, 0
    ),
    new
    Item
    (
      '天语（K-Touch）T2老年人手机4G全网通超长待机移动联通电信直板按键大字体大声音学生备用功能机 红色',
      'https://m.360buyimg.com/babel/jfs/t1/247020/17/4066/113461/65bcaf6aFe8a73a33/4861dff9d827fe32.jpg',
      89, 0
    )
  ]

  build() {
    Column() {
      // 标题部分
      Header({ title: '商品列表' }).width('100%')
        .margin({ bottom: 10 })

      // 商品列表部分
      List({ space: 8 }) {
        ForEach(this.items, (item: Item, index: number) => {
          ListItem() {
            ItemCard(item)
          }
        }
        )
      }.width('100%')
    }
    .fillScreen()
  }
}