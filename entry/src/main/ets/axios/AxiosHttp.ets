import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

const axiosHttp = axios.create({
  baseURL: 'https://www.wanandroid.com',
  timeout: 1000,
  headers: {'Content-Type': 'application/json'},
});

// 添加响应拦截器
axiosHttp.interceptors.response.use((response:AxiosResponse)=> {
  // 对响应数据做点什么
  return response;
}, (error:AxiosError)=> {
  // 对响应错误做点什么
  return Promise.reject(error);
});

export async function get<T>(url:string):Promise<T>{
  const reuslt:AxiosResponse=await axiosHttp.request({url:url,method:'get',responseType: 'string' })
  if(reuslt.status==200){
  return  Promise.resolve(reuslt.data)
  }
  return Promise.reject(new Error(reuslt.data))
}

export interface AxiosCallBack<T>{
  success(t:T):void
  error(msg:string):void
}


export async function post(url:string,params:String){

  const reuslt:AxiosResponse=await axiosHttp.request({url:url,method:'post',responseType: 'string',params:params })
  if(reuslt.status==200){
    return  Promise.resolve(reuslt.data)
  }
  return Promise.reject(new Error(reuslt.data))
}


export default axiosHttp;
