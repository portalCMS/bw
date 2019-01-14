package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingBet67BBINLive implements Serializable {

	private static final long serialVersionUID = 1L;

	private String betId; // 注单号,
	private Date betTime; // 下单时间,
	private String gKind; // 游戏类型 （3真人 5电子）,
	private String gType; // 游戏代号,
	private String serialId; // 局号（真人）,
	private Double betMoney; // 投注金额,
	private Double okBetMoney; // 有效下单金额,
	private Double betResult; // 输赢情况,
	private String isbill; // 是否已结算,
	private String userName; // 用户名,
	private String enterprisecode; // 企业编码,
	private String brandcode; // 企业品牌编码,
	private String employeecode; // 员工编码,
	private String parentemployeecode; // 员工上级编码,
	private String gamebigtype; // 游戏大类,

	public String getBetId() {
		return betId;
	}

	public void setBetId(String betId) {
		this.betId = betId;
	}

	public Date getBetTime() {
		return betTime;
	}

	public void setBetTime(Date betTime) {
		this.betTime = betTime;
	}

	public String getgKind() {
		return gKind;
	}

	public void setgKind(String gKind) {
		this.gKind = gKind;
	}

	public String getgType() {
		return gType;
	}

	public void setgType(String gType) {
		this.gType = gType;
	}

	public String getSerialId() {
		return serialId;
	}

	public void setSerialId(String serialId) {
		this.serialId = serialId;
	}

	public Double getBetMoney() {
		return betMoney;
	}

	public void setBetMoney(Double betMoney) {
		this.betMoney = betMoney;
	}

	public Double getOkBetMoney() {
		return okBetMoney;
	}

	public void setOkBetMoney(Double okBetMoney) {
		this.okBetMoney = okBetMoney;
	}

	public Double getBetResult() {
		return betResult;
	}

	public void setBetResult(Double betResult) {
		this.betResult = betResult;
	}

	public String getIsbill() {
		return isbill;
	}

	public void setIsbill(String isbill) {
		this.isbill = isbill;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEnterprisecode() {
		return enterprisecode;
	}

	public void setEnterprisecode(String enterprisecode) {
		this.enterprisecode = enterprisecode;
	}

	public String getBrandcode() {
		return brandcode;
	}

	public void setBrandcode(String brandcode) {
		this.brandcode = brandcode;
	}

	public String getEmployeecode() {
		return employeecode;
	}

	public void setEmployeecode(String employeecode) {
		this.employeecode = employeecode;
	}

	public String getParentemployeecode() {
		return parentemployeecode;
	}

	public void setParentemployeecode(String parentemployeecode) {
		this.parentemployeecode = parentemployeecode;
	}

	public String getGamebigtype() {
		return gamebigtype;
	}

	public void setGamebigtype(String gamebigtype) {
		this.gamebigtype = gamebigtype;
	}
}
