/**
 * Index首页
 */
import PreferencesUtil from '../common/util/PreferencesUtil'
import IndexFontSizePanel from '../view/IndexFontSizePanel'
import RouterItem from '../view/RouterItem'
import RouterInfo from '../viewmodel/RouterInfo'

/** 路由数据列表，可以独立放到一个文件里面 */
const routers: RouterInfo[] = [
  new RouterInfo('pages/HelloWorld', 'HelloWorld'),
  new RouterInfo('pages/device/DeviceInfo', '设备信息'),
  new RouterInfo('pages/ImageSizeDemo', '图片缩放'),
  new RouterInfo('pages/StatePage', 'State'),
  new RouterInfo('pages/ProvidePage', 'Provide'),
  new RouterInfo('pages/AnimationPage', '动画'),
  new RouterInfo('pages/AnimationPage2', '动画摇杆'),
  new RouterInfo('pages/PhoneProductList', '商品列表'),
  new RouterInfo('pages/StatePage', 'state状态'),
  new RouterInfo('pages/TaskListManager', '任务列表增删'),
  new RouterInfo('pages/LifeCirclePage', '组件生命周期'),
  new RouterInfo('pages/TestPage1', '页面跳转时生命周期'),
  new RouterInfo('pages/ShopPage', '网络商品列表'),
  new RouterInfo('pages/TaskManagePage', '任务列表持久化'),
  new RouterInfo('pages/WebLocalH5', 'web容器'),
  new RouterInfo('pages/VideoDemo', '视频播放'),
  new RouterInfo('pages/NotificationPage', '通知案例'),
]

@Entry
@Component
struct Index {
  message: string = '页面列表'
  @State showPanel: boolean = true
  @Provide fontSize: number = 16

  async aboutToAppear() {
    this.fontSize = await PreferencesUtil.getToSync('MyPerencees', 'IndexFontSize', 16) as number
  }

  build() {
    Column() {
      // 顶部标题
      this.Title()

      // 导航列表
      this.RouterList()

      // 字体修改面板
      if (this.showPanel) {
        IndexFontSizePanel()
          .transition({
            translate: { y: 115 }
          })
      }
    }
    .width('90%')
    .height('100%')
  }

  @Builder
  Title() {
    Row() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)

      Image($r('app.media.ic_public_settings'))
        .width(30)
        .onClick(() => {
          animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
            this.showPanel = !this.showPanel
          })
        })
    }.justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }

  @Builder
  RouterList() {
    List({ space: 15 }) {
      ForEach(routers, (router: RouterInfo, index) => {
        ListItem() {
          RouterItem({ r: router, i: index + 1 })
        }
      })
    }
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Center)
    .width('100%')
  }
}
