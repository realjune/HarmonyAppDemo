import http from '@ohos.net.http'
import ShopInfo from '../viewmodel/ShopInfo'
import axios from '@ohos/axios'

export const SHOP_HOST = 'http://192.168.7.19:3000'

class ShopModel {
  baseUrl: string = SHOP_HOST
  pageNo: number = 1

  getShopListAxios(): Promise<ShopInfo[]> {
    let url = `${this.baseUrl}/shops?pageNo=${this.pageNo}&pageSize=3`
    return new Promise((resolve, reject) => {
      axios.get(url,
        // `${SHOP_HOST}/shop?`,
        // {
        //   params: { pageNo: this.pageNo, pageSize: 3 } // 直接填写参数不需要手动拼字符串
        // }
        )
        .then(resp => {
          if (resp.status === 200) {
            // 查询成功
            console.log('查询商铺成功！', JSON.stringify(resp.data))
            resolve(resp.data)
          } else {
            console.log('查询商铺信息失败！error：', JSON.stringify(resp))
            reject('查询商铺失败！')
          }
        })
        .catch(error => {
          console.log('查询商铺信息失败！error：', JSON.stringify(error))
          reject('查询商铺失败！')
        })
    })

  }

  // getShopList(): Promise<ShopInfo[]> {
  //   return new Promise((resolve, reject) => {
  //     // 1. 创建http对请求对象，不可复用
  //     let httpRequest = http.createHttp()
  //     let url = `${this.baseUrl}/shops?pageNo=${this.pageNo}&pageSize=3`
  //     console.log(`getShopList ${url}`)
  //     // 2.发送请求
  //     httpRequest.request(
  //       url, {
  //       method: http.RequestMethod.GET
  //     }
  //     )
  //       .then(resp => {
  //         if (resp.responseCode == 200) {
  //           // 查询成功
  //           console.log('查询商铺成功！', resp.result)
  //           resolve(JSON.parse(resp.result.toString()))
  //         } else {
  //           // 查询失败
  //           console.log('查询商铺信息失败! error:', JSON.stringify(resp))
  //           reject('查询商铺失败')
  //         }
  //       })
  //       .catch(error => {
  //         console.log('查询商铺信息失败！ error：', JSON.stringify(error))
  //         reject('查询商铺失败')
  //       })
  //
  //   })
  //
  // }
}

const shopModel = new ShopModel();

export default shopModel as ShopModel;