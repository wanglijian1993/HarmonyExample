import { emitter } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI';


@Entry
@Component
@Preview
struct EmitterTestPage{
  @State value:string='Hellowrold'
  event:emitter.InnerEvent={
    eventId:1
  }
  // 收到eventId为1的事件后执行该回调
  callback = (eventData:emitter.EventData):void=>{
    this.value=JSON.stringify(eventData.data)
    promptAction.showToast({message:this.value,duration:2000})

  }

  listenerEmiiter(){
    emitter.on(this.event,this.callback)
  }
  aboutToAppear(): void {
    this.listenerEmiiter()
  }

  build() {

    Column(){
      Text(this.value)
      Button('切换').onClick(()=>{
        let event: emitter.InnerEvent = {
          eventId: 1,
          priority: emitter.EventPriority.LOW
        };

        let eventData: emitter.EventData = {
          data: {
            content: 'c',
            id: 1,
            isEmpty: false
          }
        };
        emitter.emit(event,eventData)
      })

    }


  }

}
