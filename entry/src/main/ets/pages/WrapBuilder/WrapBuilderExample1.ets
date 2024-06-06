

@Builder
function MyBuilder(value:string,size:number){

  Text(value)
    .fontSize(size)

}


let gobalBuilder:WrappedBuilder<[string,number]> = wrapBuilder(MyBuilder)

@Preview
@Entry
@Component
struct Index{

  @State message:string='Hello world'

  build() {
    Row() {
      Column() {
        gobalBuilder.builder(this.message,20)
      }
      .width('100%')
    }
    .height('100%')
  }

}