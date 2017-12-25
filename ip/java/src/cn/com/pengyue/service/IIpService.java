package cn.com.pengyue.service;

import cn.com.pengyue.pojo.Ip;
import cn.com.pengyue.pojo.PlaceOnFile;

public interface IIpService extends IBaseService<Ip, Integer>{
	public Ip findByIp(String ip);
}
