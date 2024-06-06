import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index02{

  build() {

    Column(){
      Text('页面2')
      Button('关闭页面')
        .onClick(()=>{
          router.back()
        })
    }

  }

}