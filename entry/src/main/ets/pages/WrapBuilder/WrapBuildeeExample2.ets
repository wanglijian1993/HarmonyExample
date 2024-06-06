

@Builder
function MyBuilder(value:string,size:number){
  Text(value)
}

@Builder
function YourBuilder(value:string,size:number){
  Text(value)
    .fontColor(Color.Pink)
}


let builderArr:WrappedBuilder<[string,number]>[] =[wrapBuilder(MyBuilder),wrapBuilder(YourBuilder)]

@Entry
@Component
struct Index{


  @Builder textBuilder(){

    ForEach(builderArr,(item:WrappedBuilder<[string]>)=>{
         item.builder('hello world')
    })


  }

  build() {

    Column(){
      this.textBuilder()
    }

  }

}