
@Preview
@Entry
@Component
struct StatePage{
  @State coloumnHeight:number=200
  aboutToAppear(): void {
    console.info('MyText-------StatePage:')
  }
  build() {

    Flex({direction:FlexDirection.Column,wrap:FlexWrap.NoWrap}){


      Column(){
        MyText({value:'文本1'})
      }
      .height(this.coloumnHeight)
      .width('100%')
      .backgroundColor($r('app.color.theme_color'))
      .onClick(()=>{
          this.coloumnHeight+=100
      })
      Column(){
        MyText({value:'文本2'})
      }
      .height(this.coloumnHeight)
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))
      .onClick(()=>{
        this.coloumnHeight-=100

      })

    }

  }

}

@Component
struct MyText{
  @State value:string=''
  build() {
  Text(this.value)
    .height(200)
    .backgroundColor($r('app.color.start_window_background'))
    .align(Alignment.Center)
  }

  aboutToAppear(): void {
    console.info('MyText-------aboutToAppear:'+this.value)
  }

}