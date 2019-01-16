package com.zy.power.mem.common.enmus;

public enum ResponCodeEnmu {

	SUCCESS("200","操作成功"),
	FAIL("400","操作失败");
	
	ResponCodeEnmu(String code, String message) {
		this.code = code;
		this.message = message;
	}
	
	private String code;
	private String message;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
