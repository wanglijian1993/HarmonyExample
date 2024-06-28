import { get } from '../../axios/AxiosHttp';

@Entry
@Component
struct AxiosPage{

  build() {

    Column(){
      Button('网络请求')
        .onClick(()=>{
         this.harmonyHttp()
        })
    }

  }


  harmonyHttp(){
    console.info("AxisoPage----request--network")
    // 使用 MyAxiosCallBack 实例来调用 get 函数
    get<string>('banner/json')
      .then((result:string)=>{
         console.info(`value:${result}`)
      })
      .catch((err:Error)=>{
        console.info(`err:${err.message}`)
       })
    console.info("AxisoPage----request--ended ")
  }


}

