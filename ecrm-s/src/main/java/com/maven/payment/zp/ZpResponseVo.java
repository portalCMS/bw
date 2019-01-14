package com.maven.payment.zp;

public class ZpResponseVo {

	private String order_no;
	private String status;
	private String channel;

	public ZpResponseVo(String order_no, String status, String channel) {
		this.order_no = order_no;
		this.status = status;
		this.channel = channel;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

}
