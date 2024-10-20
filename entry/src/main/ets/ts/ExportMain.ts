// 模块示例的主文件
// 导入关键字import {导入的类、函数、接口等，使用','分隔} from '导入路径'
import { Area, Shape, Rect } from './ExportShape'

class Square implements Area {
  area(width: number, height: number) {
    console.log(this.getName() + ' area: ' + (width * height))
  }

  test() {
    Rect.getName()
  }

  getName(): string {
    return Shape.RECTANGLE
  }
}
