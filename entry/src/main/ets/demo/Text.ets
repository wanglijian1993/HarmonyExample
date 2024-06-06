export class Person {
  name?: string|undefined // 可能为`undefined`

  setName(n:string): void {
    this.name = n;
  }

  // 编译时错误：name可以是"undefined"，所以将这个API的返回值类型标记为string
  getNameWrong(): string|undefined {
    return this.name;
  }

  getName(): string | undefined { // 返回类型匹配name的类型
    return this.name;
  }

}

export function  toAdd( x :number,y:number): string{

  return (x+y).toString();
}

let map:Record<string,string> ={'zhangsan,':'14','lisi':'15'};
map['zhangsan']

interface Style{
  color:String
}

function main(){
  console.log('this is the program entry');
}

let person:Person=new Person()
export default person as Person

// interface Style{
//   get color():string
//   set color(x:string)
// }