package com.jeecg.black.task;

import org.jeecgframework.core.util.IpUtil;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.stereotype.Component;

/**
 * 
 * @Title: ProductPushTask
 * @Description:产品推送定时作业，定时任务测试
 * @Author: zhaotf
 * @Since:2018年6月4日 上午11:16:21
 */
@Component("productPushTask")
public class ProductPushTask implements Job {

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		this.run();
	}

	public void run() {
		long start = System.currentTimeMillis();
		org.jeecgframework.core.util.LogUtil
				.info("===================品推送定时作业，定时任务测试：" + IpUtil.getLocalIp() + "-开始===================");
		try {
			// tSSmsService.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
		org.jeecgframework.core.util.LogUtil.info("===================品推送定时作业，定时任务测试：" + IpUtil.getLocalIp() + "-结束===================");
		long end = System.currentTimeMillis();
		long times = end - start;
		org.jeecgframework.core.util.LogUtil.info("总耗时" + times + "毫秒");
	}

}
