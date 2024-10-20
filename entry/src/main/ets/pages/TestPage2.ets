import router from '@ohos.router'
@Entry
@Component
struct TestPage2 {
  @State message: string = 'TestPage2'
  @State tag:string='TestPage2'

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
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Row(){
          Button('pushPage2')
            .onClick(()=>{
              router.pushUrl({url:'pages/TestPage1'})
            })
          Button('replacePage2')
            .onClick(()=>{
              router.replaceUrl({url:'pages/TestPage1'})
            })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}