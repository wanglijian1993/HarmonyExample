
@Preview
@Entry
@Component
struct MyComponent{

  @Styles normalStyle(){
    .backgroundColor(Color.Gray)
  }

  @Styles pressedStyle(){
    .backgroundColor(Color.Red)
  }

  build() {
    Column(){
      Text('Text1')
        .fontSize(50)
        .fontColor(Color.White)
        .stateStyles({
           normal:this.normalStyle,
           pressed:this.pressedStyle
        })
    }
  }

}