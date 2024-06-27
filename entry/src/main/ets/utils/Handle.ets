

export default class Handle{
  private static instance:Handle=new Handle

  static getInstance(){
    return Handle.instance
  }

  static syncGet(): void {
    // 同步Get方法
  }

  static syncSet(num:number): number{

    // 模拟同步步骤1
    console.info("taskpool: this is 1st print!");
    // 模拟同步步骤2
    console.info("taskpool: this is 2nd print!");
    return ++num;

  }
  static syncSet2(num: number): number {
    // 模拟同步步骤1
    console.info("taskpool: this is syncSet2 1st print!");
    // 模拟同步步骤2
    console.info("taskpool: this is syncSet2 2nd print!");
    return ++num;
  }

}