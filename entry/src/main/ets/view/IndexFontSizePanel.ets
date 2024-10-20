import PreferencesUtil from '../common/util/PreferencesUtil'

@Component
export default struct IndexFontSizePanel {
  @Consume fontSize: number
  fontSizeLabel: Map<string, string> = new Map()

  aboutToAppear(): void {
    this.fontSizeLabel.set("14", '小')
    this.fontSizeLabel.set('16', '标准')
    this.fontSizeLabel.set('18', '大')
    this.fontSizeLabel.set('20', '特大')
  }

  build() {
    Column() {
      Text(this.fontSizeLabel[this.fontSize]).fontSize(20)
      Row({ space: 5 }) {
        Text('A').fontSize(14).fontWeight(FontWeight.Bold)
        Slider({
          min: 14,
          max: 20,
          step: 2,
          value: this.fontSize
        })
          .showSteps(true)
          .trackThickness(6)
          .layoutWeight(1)
          .onChange(val => {
            // 修改字体大小
            this.fontSize = val
            // 保存
            PreferencesUtil.putToSync('MyPreference', 'fontSize', val)
          })
        Text('A').fontSize(20).fontWeight(FontWeight.Bold)
      }.width('100%')
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#FFF1F0F0')
    .borderRadius(20)
  }
}