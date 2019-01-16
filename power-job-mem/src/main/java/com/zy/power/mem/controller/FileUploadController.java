package com.zy.power.mem.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.DeleteObjectsRequest;
import com.aliyun.oss.model.DeleteObjectsResult;
import com.aliyun.oss.model.GetObjectRequest;
import com.zy.power.mem.common.result.Message;
import com.zy.power.mem.common.util.AliyunOSSClientUtil;
import com.zy.power.mem.common.util.UUIDUtil;
import com.zy.power.mem.core.annotation.SysLogger;

/**
 * 文件上传服务器。
 */
@RestController
public class FileUploadController{

	// 传输协议
	private static final String PROTOCOL;
	// 阿里云API的内或外网域名URI
	private static final String ENDPOINTURI;
	// log日志
	private static Logger logger = LoggerFactory.getLogger(AliyunOSSClientUtil.class);
	// 阿里云API的内或外网域名
	private static final String ENDPOINT;
	// 阿里云API的密钥Access Key ID
	private static final String ACCESS_KEY_ID;
	// 阿里云API的密钥Access Key Secret
	private static final String ACCESS_KEY_SECRET;
	// 阿里云API的bucket名称，即文件的存储空间
	private static final String BUCKET_NAME;
	// 阿里云API的文件夹名称
	private static final String FOLDER;

	static {
		PROTOCOL = "http://";
		ENDPOINTURI = "oss-cn-shenzhen.aliyuncs.com";
		ENDPOINT = PROTOCOL + ENDPOINTURI;
		ACCESS_KEY_ID = "LTAIp2FTTphzWyCM";
		ACCESS_KEY_SECRET = "x5jyKIA2yih5DfG2HIKyGquqgWrHoO";
		BUCKET_NAME = "bhms-fru-dev";
		FOLDER = "images/";
	}

	@SuppressWarnings("deprecation")
	private OSSClient getOSSClient() {
		return new OSSClient(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
	}

	private void closeOSSClient(OSSClient ossClient) {
		if (ossClient != null) {
			ossClient.shutdown();
			logger.info("---结束---");
		}
	}

	/**
	 ** 上传文件
	 *
	 * @param fileName
	 * @param file
	 */
	@RequestMapping(value = "fileUpload", method = RequestMethod.POST)
	@ResponseBody
	@SysLogger("测试")
	public Message upload(@RequestParam("files") MultipartFile[] files) {
		List<String> urls = new CopyOnWriteArrayList<String>();
		
		int length = files.length;
		if(length>0) {
			ExecutorService es = Executors.newFixedThreadPool(3);
			
			for (int item = 0; item < length ; item++) {
				if (!files[item].isEmpty()) {
					UploadThread uploadThread = new UploadThread(files[item]);
					Future<String> future = es.submit(uploadThread);
					try {
						urls.add(future.get());
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (ExecutionException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return Message.success(urls);
	}

	/**
	 ** 下载文件到本地
	 *
	 * @param fileName
	 * @param saveFilePath
	 */
	@GetMapping(value = "download")
	@ResponseBody
	public void download(String fileName, String saveFilePath) {
		OSSClient ossClient = getOSSClient();
		try {
			logger.info("---开始下载---");
			GetObjectRequest getObjectRequest = new GetObjectRequest(BUCKET_NAME, FOLDER + fileName);
			ossClient.getObject(getObjectRequest, new File(saveFilePath));
		} catch (OSSException oe) {
			logger.info("---服务器错误---");
			logger.info("Error Message:" + oe.getErrorMessage());
			logger.info("Error Code:" + oe.getErrorCode());
			logger.info("Request ID:" + oe.getRequestId());
			logger.info("Host ID:" + oe.getHostId());
		} finally {
			closeOSSClient(ossClient);
		}
	}

	/**
	 ** 获取文件URL
	 * 
	 * @param fileName
	 * @return
	 */
	@GetMapping(value = "getUrl")
	@ResponseBody
	public String getUrl(String fileName) {
		return PROTOCOL + BUCKET_NAME + "." + ENDPOINTURI + "/" + FOLDER + fileName;
	}

	/**
	 ** 删除文件
	 *
	 * @param fileName
	 */
	@GetMapping(value = "deleteFile")
	@ResponseBody
	public void deleteFile(String fileName) {
		OSSClient ossClient = getOSSClient();
		try {
			logger.info("---开始删除---");
			ossClient.deleteObject(BUCKET_NAME, FOLDER + fileName);
		} catch (OSSException oe) {
			logger.info("---服务器错误---");
			logger.info("Error Message:" + oe.getErrorMessage());
			logger.info("Error Code:" + oe.getErrorCode());
			logger.info("Request ID:" + oe.getRequestId());
			logger.info("Host ID:" + oe.getHostId());
		} finally {
			closeOSSClient(ossClient);
		}
	}

	/**
	 ** 批量删除文件，返回删除失败的文件
	 *
	 * @param fileNameList
	 * @return List
	 */
	@GetMapping(value = "deleteFileBatch")
	@ResponseBody
	public List<String> deleteFileBatch(List<String> fileNameList) {
		if (fileNameList == null || fileNameList.isEmpty() || fileNameList.size() == 0) {
			logger.info("文件列表为空");
			return null;
		}

		List<String> deleteList = new ArrayList<>();
		for (String fileName : fileNameList) {
			deleteList.add(FOLDER + fileName);
		}

		List<String> failList;
		OSSClient ossClient = getOSSClient();
		try {
			logger.info("---开始批量删除---");
			DeleteObjectsRequest deleteObjectsRequest = new DeleteObjectsRequest(BUCKET_NAME);
			deleteObjectsRequest.setKeys(deleteList);
			deleteObjectsRequest.setQuiet(true);

			DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(deleteObjectsRequest);
			failList = deleteObjectsResult.getDeletedObjects();
			return failList;
		} catch (OSSException oe) {
			logger.info("---服务器错误---");
			logger.info("Error Message:" + oe.getErrorMessage());
			logger.info("Error Code:" + oe.getErrorCode());
			logger.info("Request ID:" + oe.getRequestId());
			logger.info("Host ID:" + oe.getHostId());
		} finally {
			closeOSSClient(ossClient);
		}
		return null;
	}

	/**
	 ** 判断文件是否存在
	 *
	 * @param fileName
	 * @return
	 */
	@GetMapping(value = "doseFileExist")
	@ResponseBody
	public boolean doseFileExist(String fileName) {
		OSSClient ossClient = getOSSClient();
		boolean flag = ossClient.doesObjectExist(BUCKET_NAME, FOLDER + fileName);
		closeOSSClient(ossClient);
		return flag;
	}

	class UploadThread implements Callable<String> {

		MultipartFile file;

		public UploadThread(MultipartFile file) {
			super();
			this.file = file;
		}

		@Override
		public String call() throws Exception {
			// TODO Auto-generated method stub
			OSSClient ossClient = getOSSClient();
			try {
				logger.info("---开始上传---");
				String fileName = file.getOriginalFilename();
				String realyName = getRealyName(fileName);
				InputStream uploadFile = file.getInputStream();
				ossClient.putObject(BUCKET_NAME, FOLDER + realyName, uploadFile);
				String url = getUrl(realyName);
				closeOSSClient(ossClient);
				return url;
			} catch (OSSException oe) {
				logger.info("---服务器错误---");
				logger.info("Error Message:" + oe.getErrorMessage());
				logger.info("Error Code:" + oe.getErrorCode());
				logger.info("Request ID:" + oe.getRequestId());
				logger.info("Host ID:" + oe.getHostId());
				closeOSSClient(ossClient);
			} catch (ClientException ce) {
				logger.info("---客户端上传错误---");
				logger.info("Error Message:" + ce.getMessage());
				closeOSSClient(ossClient);
			} catch (IOException e) {
				logger.info("---获取文件错误---");
				e.printStackTrace();
				closeOSSClient(ossClient);
			}
			closeOSSClient(ossClient);
			return null;
		}
	}
	
	public String getRealyName(String fileName) {
		String uuid = UUIDUtil.generateID();
		String subStr = fileName.substring(0, fileName.lastIndexOf('.'));
		String realyName = fileName.replaceFirst(subStr, uuid);
		return realyName;
	}

}
