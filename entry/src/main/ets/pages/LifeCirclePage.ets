import { Header } from '../component/Header'

@Entry
@Component
struct LifeCirclePage {
  @State show: boolean = false
  @State arr: string[] = []
  tag: string = 'TestTagLifeCirclePage'

  build() {
    Column() {
      Header({ title: '测试组件生命周期' })

      Button('切换显示')
        .onClick(() => {
          this.show = !this.show
        })

      Row() {
        if (this.show) {
          MyText({ message: 'HelloWorld' })
        }
      }
      .height(30)

      // 新增按钮
      Button('新增数据')
        .onClick(() => this.arr.push('user_' + this.arr.length))
      ForEach(this.arr, (item:string, index) => {
        MyText({ message: item, index: index, delete: this.delete.bind(this) })
      })
    }
    .width('100%')
    .height('100%')
  }

  delete(index: number = -1) {
    if (index > -1) {
      this.arr.splice(index, 1)
    }
  }

  aboutToAppear() {
    console.log(this.tag, 'aboutToAppear')
  }

  onPageShow() {
    console.log(this.tag, 'onPageShow')
  }

  onBackPress() {
    console.log(this.tag, 'onBackPress')
  }

  onPageHide() {
    console.log(this.tag, 'onPageHide')
  }
}

@Component
struct MyText {
  message!: string
  index?: number
  delete!: (index?: number) => void
  tag: string = 'TestTagLifeMyTextPage'

  aboutToAppear() {
    console.log(this.tag, 'aboutToAppear')
  }

  onPageShow() {
    console.log(this.tag, 'onPageShow')
  }

  onBackPress() {
    console.log(this.tag, 'onBackPress')
  }

  onPageHide() {
    console.log(this.tag, 'onPageHide')
  }

  build() {
    Row() {
      Text(this.message)
        .fontSize(20)
      if (this.delete) {
        Image($r('app.media.ic_public_delete'))
          .width(20)
          .onClick(() => this.delete(this.index))
      }
    }
  }
}