// 变量声明、条件控制、循环迭代、函数、类和接口、模块
import defaultAppManager from '@ohos.bundle.defaultAppManager'

// 运行示例：
// https://www.typescriptlang.org/play/?#code/PTAEBUE8AcFMGUDGAnAltALoCnUBSBDANzyTU0BC3QL-VABD0Cg5QAqVBTRUDC5QTXTBAA0G8fQaPVABi0FPzQPlKgX4DAMP+B560BUcoA3lQPOJgX4TAkOaAvtUBZ2mUAOpoDtjboCAGAFAAbWBlABbAM4BzAFyhzGNADtLoALygA5AAtYBgwHtQAHd-ZAMAEw89RH9Hc38jADoAywAKDwsbD1AAajMrAEo9PRA7B1RnQCx-0EB1bUAyb0AmORFAe+VAU7lACldAVWVAVH1Ad+VANCNAGeU+w2N8ywAmW3snF3cAIgAJXwDg0Ij56Nj4pJT0zKnsvIOi0ZNHAFdTW0vTACNYZDdQAEYJgGYtuITYZP80jy3B7IaxHUC3U5GEywRx4O5GWx3fw-PCOZ4OC6wL47X57DwwuEIsEE+GwSFjPC2VGQZ4ePBlWZRGLfXb-dJ4SBomYVLK5UB4Ir09xvbE-P4AjlooGPUF8gXFUoXRyoWK2QAqAYAIFW4IkAPAptQD0ZoBwYzUgCxNCTcQC0cmRAABy5q4Z1AF2m5WcoAAPuCrsD3aAkSi0e5vCt-EztmK8UqVVyXby8hcihdni8AAyi1kAyOxT33GVg+N6RPuABmeAM5ixzJx4vSmbRfqMqNlcdOpQA8ncAFawRAYSqAT+1AIYxDugzwA3qAMDBYLYJgAaUDhWDmFDoDC2DzcABC2QAvmncWz5v5O92TNBrPM+dBEpO4Hz5vPF+YL1fEk+V5gikA

// TypeScript在JavaScript的基础上加入了静态类型检查功能，每个变量都有固定的数据类型。
// 格式为：{let|const} <变量名>: [类型] = [初始值]
// 列表：{let|const} <变量名>: [类型][] = [...]
// 常用基础类型：number、string、boolean、any、（union）、（class）
let msg: string = 'hello world'
console.log('msg:' + msg) // [LOG]: "msg:hello world"

// 常量，string： 字符串，可以用单引号或双引号
const msg2: string = "Hello world"
console.log('msg2:' + msg2) // [LOG]: "msg2:Hello world"

let num: number = 123
console.log('number:' + num) // [LOG]: "number:123"

let enable: boolean = true
console.log('enable:' + enable) // [LOG]: "enable:true"

let a: any = 'a string'
console.log('ayn string:' + a) // [LOG]: "ayn string:a string"
a = 12
console.log('ayn number:' + a) // [LOG]: "ayn number:12"

// union: 联合类型，值可以是指定的多个类型中的一个类型
let u: string | number | boolean = 'hello'
console.log('union string:' + u) // [LOG]: "union string:hello"
u = 10
console.log('union number:' + u) // [LOG]: "union number:10"
u = false
console.log('union boolean:' + u) // [LOG]: "union boolean:false"

let array: any[] = [1, false, 'fine'];
console.log("array:" + array[1]) // [LOG]: "array:false"

// Object：对象
let p = { type: 2, descript: '类型B' }
console.log("object p:" + p.type + ", des:" + p.descript) // [LOG]: "object p:2, des:类型B"


// 条件判断
// ts中 空字符串、数字0、null、undefined都为false
let count: number = 12
if (count % 2 === 0) {
  console.log(count + ' 是偶数')
} else {
  console.log(count + ' 是奇数')
}

if (count) {
  console.log(count + ' 非0为true')
}

let obj: any
if (!obj) {
  console.log('obj 空为false')
}
obj = {}
if (obj) {
  console.log("obj 非空为true")
}

// switch语句
let grade: string = 'AA'
switch (grade) {
  case 'AA':
    console.log('优秀')
    break
  case 'B': {
    console.log('合格')
  }
    break
  default: {
    console.log('不合格')
  }
    break
}
// [LOG]: "优秀"

// 循环迭代:for、while与Java用法相同；另外支持Array快捷迭代语法
// for循环
for (let i = 1; i <= 3; i++) {
  console.log('for ' + i)
}
// [LOG]: "for 1"
// [LOG]: "for 2"
// [LOG]: "for 3"

// while循环
let i = 1
while (i <= 3) {
  console.log('while ' + i)
  i++
}
// [LOG]: "while 1"
// [LOG]: "while 2"
// [LOG]: "while 3"

let arr: string[] = ['AA', 'BB', 'CC']
// 快捷迭代-遍历索引
for (const i in arr) {
  console.log(i + ' : ' + arr[i])
}
// [LOG]: "0 : AA"
// [LOG]: "1 : BB"
// [LOG]: "2 : CC"

// 快捷迭代-遍历内容
for (const str of arr) {
  console.log(':' + str)
}
// [LOG]: ":AA"
// [LOG]: ":BB"
// [LOG]: ":CC"

/** 函数
 * 通常有function声名，支持可选参数，默认参数，剪头函数*/

/**
 * 函数声名：两个数相加函数
 * @param b 为默认参数
 */
function sum(a: number, b: number = 0): number {
  return a + b
}

// 调用
console.log('sum函数返回值:' + sum(1, 2)) // [LOG]: "sum函数返回值:3"
console.log('sum函数返回值:' + sum(1)) // [LOG]: "sum函数返回值:1"


// 无返回值时':void'可省略
function message(msg: string) {
  console.log('无返回值函数: ' + msg)
}

// 调用
message('1') // [LOG]: "无返回值函数: 1"

// 箭头函数
let arrow = (a: number, b?: number) => {
  console.log('箭头函数：' + a + ' + ' + b + ' = ' + (a + b!))
}

arrow(2, 3) // [LOG]: "箭头函数：2 + 3 = 5"
arrow(2) // [LOG]: "箭头函数：2 + undefined = NaN"

// 可选参数函数
function param(msg?: string) {
  if (msg) { // null、undefined 为false
    console.log('选参函数有参数： ' + msg)
  } else {
    console.log('选参函数无参数： ' + msg)
  }
}

param('hello!') // [LOG]: "选参函数有参数： hello!"
param() // [LOG]: "选参函数无参数： undefined"

// 默认值参数
function defParam(msg: string = 'defMsg') {
  console.log('函数参数有默认值： ' + msg)
}

defParam('hello') // [LOG]: "函数参数有默认值： hello"
defParam() // [LOG]: "函数参数有默认值： defMsg"


// 类、接口
enum Shape {
  RECTANGLE = 'rectangle',
  SQUARE = "SQUARE",
  CIRCle = 'circle',
  TRIANGLE = "triangle"
}

// 接口
interface Area {
  area(width: number, height: number): void
}

// 类
class Rectangle implements Area {
  area(width: number, height: number) {
    console.log('Rectangle.area: ' + (width * height))
  }

  getName(): string {
    return Shape.RECTANGLE.toString()
  }
}

// 子类
class Square extends Rectangle {
  // 方法签名只匹配方法名, 不允许重名方法
  area(width: number) {
    console.log('Square.area(' + width + ')')
    super.area(width, width)
  }

  // 方法签名只匹配方法名, 不允许重名方法
  // area(width: number, height:number) {
  //   console.log('Square.area(' + width + ')')
  //   super.area(width, width)
  // }

  getName(): string {
    return Shape.SQUARE.toString()
  }
}

// 赋值给接口类型
let obj1: Area = new Rectangle()
obj1.area(10, 20) // [LOG]: "Rectangle.area: 200"

// 直接赋值,自动识别类型
let s = new Square()
s.area(20)
// [LOG]: "Square.area(20)"
// [LOG]: "Rectangle.area: 400"

// 复制给接口类型，按照接口使用
obj1 = s
obj1.area(10, 20)
// [LOG]: "Square.area(10)"
// [LOG]: "Rectangle.area: 100"
