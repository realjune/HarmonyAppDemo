import { SSAdvertViewModel } from "./viewmodel/SSAdvertViewModel"
import { UIContext } from "@kit.ArkUI"
// import { UIConstants } from "../../../config/constant/SsUIConstants"
// import { SS_AD_ICON_ADCLOSE } from "../../../config/OnlineMediaResource"

/**
 * 功能简介
 *
 * @author wangjx
 * @version 1.0.0
 * @date 2024/10/17
 **/
@Preview
@Component
export struct SSAdvertView {
  @ObjectLink viewModel: SSAdvertViewModel

  build() {
    RelativeContainer() {
      Image(this.viewModel.adEntity?.img[0]).width(UIConstants.FULL_PARENT).objectFit(ImageFit.Contain)
      Row() {
        Text('广告').fontSize($r('app.float.desc2')).textShadow({
          radius: 1.5,
          color: $r('app.color.text3Light')
        })
        Image(SS_AD_ICON_ADCLOSE).width(13).height(20).padding({ top: 7, bottom: 2, left: 2 }).margin({ right: 7.5 })
      }.alignRules({ right: { anchor: UIConstants.ANCHOR_PARENT, align: HorizontalAlign.End } })
    }
  }
}