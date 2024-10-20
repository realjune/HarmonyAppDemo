// 可被作为模块导入的类、接口、函数等，添加export关键字
export enum Shape {
  RECTANGLE = 'rectangle',
  SQUARE = "SQUARE",
  CIRCle = 'circle',
  TRIANGLE = "triangle"
}


export interface Area {
  area(width: number, height: number): void
}

class Rectangle implements Area {
  area(width: number, height: number) {
    console.log(this.getName() + ' area: ' + (width * height))
  }

  getName(): string {
    return Shape.RECTANGLE
  }
}
// 共享对象
export const Rect = new Rectangle()