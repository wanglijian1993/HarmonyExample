import { BusinessError } from '@kit.BasicServicesKit'
import { fileIo } from '@kit.CoreFileKit'
import { common, Context } from '@kit.AbilityKit'
import taskpool from '@ohos.taskpool'
import { ErrorEvent, worker } from '@kit.ArkTS'
import Handle from '../../utils/Handle'

@Entry
@Component
struct ThreadPoolPage{

   workerInstance: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/MyWorker.ts');

  /**
   * Promise 处理异步对象，提供resolve，reject二个回调函数参数，一个成功一个失败，
   * 并发的操作 并发就是在异步操作等待异步完成回调
   * Promise 三种状态:pending 进行中，fulfilled 已完成，rejected 已拒绝
   */
   promise:Promise<number> =new Promise((resolve:Function,reject:Function)=>{

  setTimeout(()=>{

    const radomNumber:number=Math.random()

    if(radomNumber>0.5){
      resolve(0.5)
    }else{
      reject(new Error('Random number is too small'))
    }

  },1000)


})

  async testFileFunc():Promise<void>{
     let context = getContext() as common.UIAbilityContext;
     let path= context.filesDir+"/text.txt"
     console.info(`path:${path}`)
     let file:fileIo.File=await fileIo.open(path,fileIo.OpenMode.READ_WRITE| fileIo.OpenMode.CREATE)
    this.write("hello world",file).then(()=>{
      console.info('Succeeded in writing data.');
      fileIo.close(file)
    }).catch((err: BusinessError)=>{
      console.info('failed in writing data.');
      fileIo.close(file)
    })


  }

  async write(data:string,file:fileIo.File):Promise<void>{

    fileIo.write(file.fd,data).then((writeLen:number)=>{
      console.info('write data length is: ' + writeLen)
    }).catch((err:BusinessError)=>{
      console.error(`Failed to write data. Code is ${err.code}, message is ${err.message}`);
    })


  }




  async myAsyncFunction():Promise<void>{
     //ry catch去捕捉异常
    try {
      const result:string =await new Promise((resolve:Function)=>{
        setTimeout(()=>{
          resolve('hello wrold')
        },3000)

      });
      console.info(result)
    }catch (e){
      console.info(`error:${e}`)
    }

  }


  textWorker(){
   let done=false

    this.workerInstance.onmessage=((value:Object)=>{
      console.info('Myworker.ts onmessage'+value)
      if(!done){
        this.workerInstance.postMessage({ 'type': 1, 'value': 0 });
        done=true
      }
    })

    this.workerInstance.onerror = ((err: ErrorEvent) => {
      // 接收Worker子线程的错误信息
      console.info(`error:${err}`)
    })

    // 向Worker子线程发送训练消息
    this.workerInstance.postMessage({ 'type': 0 });

  }



  build() {
    Column(){
      Button('promise调用')
        .onClick(()=>{
          // 1.promise 调用
          this.promise.then((value:number)=>{
            console.info(`Random number is ${value}`);
          }).catch((error:BusinessError)=>{
            console.error(error.message);
          })
        })
      Button('async awaitd调用')
        .onClick(()=>{
          // 2.async代替promise语法糖
          this.myAsyncFunction()
        })
      Button('磁盘写入数据')
        .onClick(()=>{
          //3. 往磁盘写入文件
          this.testFileFunc();
        })
      Button('ThreadPool')
        .onClick(()=>{
          let buffer: ArrayBuffer = new ArrayBuffer(24);
          histogramStatistic(buffer);
        })
      Button('Worker')
        .onClick(()=>{
          this.textWorker()
        })
      Button('并发同步数据')
        .onClick(()=>{
          // 步骤3: 执行并发操作
          asyncGet();
          let num: number = Handle.syncSet(100);
          console.info("this is Main_Thread!")
        })
    }
  }

  aboutToDisappear(): void {
    // 销毁Worker线程
    this.workerInstance.terminate();

  }



}
// 步骤1: 定义并发函数，内部调用同步方法
@Concurrent
async function func(num: number): Promise<number> {
  // 调用静态类对象中实现的同步等待调用
  // 先调用syncSet方法并将其结果作为syncSet2的参数，模拟同步调用逻辑
  let tmpNum: number = Handle.syncSet(num);
  console.info("this is Child_Thread")
  return Handle.syncSet2(tmpNum);
}

// 步骤2: 创建任务并执行
async function asyncGet(): Promise<void> {
  // 创建task、task2并传入函数func
  let task: taskpool.Task = new taskpool.Task(func, 1);
  let task2: taskpool.Task = new taskpool.Task(func, 2);
  // 执行task、task2任务，await保证其同步执行
  let res: number = await taskpool.execute(task) as number;
  let res2: number = await taskpool.execute(task2) as number;
  // 打印任务结果
  console.info("taskpool: task res is: " + res);
  console.info("taskpool: task res2 is: " + res2);
}

@Concurrent
function   imageProcessing(dataSlice:ArrayBuffer):ArrayBuffer{
  // 步骤1: 具体的图像处理操作及其他耗时操作
  return dataSlice
}

function histogramStatistic(pixelBuffer:ArrayBuffer){

  // 步骤2: 分成三段并发调度
  let number: number = pixelBuffer.byteLength / 3;
  let buffer1: ArrayBuffer = pixelBuffer.slice(0, number);
  let buffer2: ArrayBuffer = pixelBuffer.slice(number, number * 2);
  let buffer3: ArrayBuffer = pixelBuffer.slice(number * 2);
  let group:taskpool.TaskGroup= new taskpool.TaskGroup()
  group.addTask(imageProcessing,buffer1)
  group.addTask(imageProcessing, buffer2);
  group.addTask(imageProcessing, buffer3);

  taskpool.execute(group,taskpool.Priority.MEDIUM).then((rec:Object)=>{
    // 步骤3: 结果数组汇总处理
    console.info(`rec:${rec.toString()}}`)
  })

}