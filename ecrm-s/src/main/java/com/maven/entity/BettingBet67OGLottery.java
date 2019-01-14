package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingBet67OGLottery implements Serializable {
	private static final long serialVersionUID = 4470098518120965287L;

	private String betId;
	
	private String gameName;
	
	private String phaseNum;
	
	private Date betTime;
	
	private Double betAmount;
	
	private Double valBetAmount;
	
	private Double winOrLoss;
	
	private String betTypeName;
	
	private String betStatus;
	
	private String userName;
	
	private String enterprisecode;
	
	private String brandcode;
	
	private String employeecode;
	
	private String parentemployeecode;
	
	private String gamebigtype;
	
	private Integer status;

	public String getBetId() {
		return betId;
	}

	public void setBetId(String betId) {
		this.betId = betId;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public String getPhaseNum() {
		return phaseNum;
	}

	public void setPhaseNum(String phaseNum) {
		this.phaseNum = phaseNum;
	}

	public Date getBetTime() {
		return betTime;
	}

	public void setBetTime(Date betTime) {
		this.betTime = betTime;
	}

	public Double getBetAmount() {
		return betAmount;
	}

	public void setBetAmount(Double betAmount) {
		this.betAmount = betAmount;
	}

	public Double getWinOrLoss() {
		return winOrLoss;
	}

	public void setWinOrLoss(Double winOrLoss) {
		this.winOrLoss = winOrLoss;
	}

	public String getBetTypeName() {
		return betTypeName;
	}

	public void setBetTypeName(String betTypeName) {
		this.betTypeName = betTypeName;
	}

	public String getBetStatus() {
		return betStatus;
	}

	public void setBetStatus(String betStatus) {
		this.betStatus = betStatus;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Double getValBetAmount() {
		return valBetAmount;
	}

	public void setValBetAmount(Double valBetAmount) {
		this.valBetAmount = valBetAmount;
	}

	
}
