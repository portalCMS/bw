package com.hy.pull.common.util;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Playtech 
 * @author sum
 *
 */
public class PlaytechApiResponse {
	// 编号
	@JsonProperty("Code")
	private String code;
	
	// 信息
	@JsonProperty("Message")
	private String message;
	
	// 玩家账户余额
	@JsonProperty("Balance")
	private String balance;
	
	// 货币单位
	@JsonProperty("Currency")
	private String currency;
	
	// 游戏地址
	@JsonProperty("Gameurl")
	private String gameurl;
	
	// 用户名
	@JsonProperty("PlaytechUserName")
	private String userName;
	
	// 密码
	@JsonProperty("PlaytechPassword")
	private String password;
	
	// 状态
	@JsonProperty("status")
	private String status;
	
	@JsonProperty("info")
	private String info;

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

	public String getBalance() {
		return balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getGameurl() {
		return gameurl;
	}

	public void setGameurl(String gameurl) {
		this.gameurl = gameurl;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	
}
