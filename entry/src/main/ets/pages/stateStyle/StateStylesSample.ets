
@Entry
@Component
struct StatestylesSample{

  build(){
    Column(){
      Button('Button1')
        .stateStyles({
          focused:{
           .backgroundColor(Color.Pink)
          },
          pressed:{
            .backgroundColor(Color.Black)
          },
          normal:{
            .backgroundColor(Color.Red)
          }
           }
        )
        .margin(20)
      Button('Button2')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
          },
          pressed: {
            .backgroundColor(Color.Black)
          },
          normal: {
            .backgroundColor(Color.Red)
          }
        })
    }
    .margin('30%')
  }
}