class Room {
  name: string
  id: number
  desk?: Desk

  constructor(name: string, id: number, desk?: Desk) {
    this.name = name
    this.id = id
    this.desk = desk
  }
}

class Desk {
  name: string
  id: number

  constructor(name: string, id: number) {
    this.name = name
    this.id = id
  }
}

/**
 * 验证State对对象、嵌套对象、数组、数组内对象更新的感知
 */

@Entry
@Component
struct StatePage {
  idx: number = 1
  @State p: Room = new Room('直接对象', 1, new Desk('嵌套对象', 1))
  @State rooms: Room[] = [
    new Room('数组对象A', 1),
    new Room('数组对象B', 1)
  ]

  build() {
    Row() {
      Column() {
        Text('@State更新UI测验')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)

        Text('点击对应对象使其数字+1，观察ui是否更新，@State对象的属性同步，但不支持嵌套对象的属性变化更新')
          .fontSize(20)

        Text(`${this.p.name} : ${this.p.id} ++`)
          .fontSize(20)
          .onClick(() => {
            this.p.id++
          })
          .margin({ top: 50 })

        Text(`${this.p.desk?.name}: ${this.p.desk?.id} ++`)
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .onClick(() => {
            this.p.desk!.id++
          })

        Text('数组测验')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 50 })

        Text('@State会更细数组属性变化，如添加或删除元素会更新列表，但不会更新数组内的对象属性，如点击对应对象使其数字+1，UI无更新')
          .fontSize(20)

        Button('数组添加元素')
          .onClick(() => {
            this.idx++;
            this.rooms.push(new Room('新加Room', this.idx))
          })
          .margin({ top: 30 })

        ForEach(this.rooms,
          (p:Room, index) => {
            Row() {
              Text(`${p.name}: ${p.id}`)
                .fontSize(30)
                .onClick(() => {
                  this.rooms[index] = new Room(p.name, p.id++)
                })
              Button('删除')
                .onClick(() => {
                  this.rooms.splice(index, 1)
                })
            }.width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          })
      }
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .padding(10)
  }
}