
@AnimatableExtend(Text) function animatableFontSize(size:number){
  .fontSize(size)
}

@Entry
@Component
struct AnimatablePropertyExample{
  @State fontSize:number=20
  build() {
    Column(){
      Text("AnimatableProperty")
        .animatableFontSize(this.fontSize)
        .animation({duration:1000,curve:"ease"})
      Button("play")
        .onClick(()=>{
          this.fontSize=this.fontSize==20?36:20
        })
        .width("100%")
        .padding(10)
    }
  }
}