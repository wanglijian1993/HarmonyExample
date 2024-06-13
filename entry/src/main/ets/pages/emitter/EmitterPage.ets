import { MyEmitterUtil } from './MyEmitterUtil'

@Component
struct MyView {
  @Prop controller: MyEmitterUtil
  @State info: string = ""

  aboutToAppear(): void {
    this.controller.onChild((eventData) => {
      console.info('====eventData', JSON.stringify(eventData))
      if (eventData.flag == "ABC") {
        this.info = eventData.data
      }
    })
  }

  build() {
    Column() {
      Text('子组件接收到的数据：' + this.info)
      Button('向父组件发送数据').onClick(() => {
        this.controller.emitFather("CCC", "EEE")
      })
    }
  }
}

@Entry
@Component
struct EmitterPage {
  controller: MyEmitterUtil = new MyEmitterUtil()
  @State info: string = ""

  aboutToAppear(): void {
    this.controller.onFather((eventData) => {
      console.info('====eventData', JSON.stringify(eventData))
      if (eventData.flag == "CCC") {
        this.info = eventData.data
      }
    })
  }

  build() {
    Row() {
      Column() {
        Text('父组件接收到的数据：' + this.info)
        Button('向子组件发送数据').onClick(() => {
          this.controller.emitChild("ABC", "conter")
        })
        MyView({ controller: this.controller })

      }
      .width('100%')
    }
    .height('100%')
  }
}