package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingBet67EbetLive implements Serializable {

	private static final long serialVersionUID = 1L;

	private String betId;
	private String gameRoundId;
	private String gameTypeName;
	private Date betTime;
	private Double betAmount;
	private Double validAmount;
	private Double winOrLoss;
	private String betTypeName;
	private String gameResult;
	private Date billTime;
	private String isBill;
	private String userName;
	private String enterprisecode;
	private String brandcode;
	private String employeecode;
	private String parentemployeecode;
	private String gamebigtype;

	public String getBetId() {
		return betId;
	}

	public void setBetId(String betId) {
		this.betId = betId;
	}

	public String getGameRoundId() {
		return gameRoundId;
	}

	public void setGameRoundId(String gameRoundId) {
		this.gameRoundId = gameRoundId;
	}

	public String getGameTypeName() {
		return gameTypeName;
	}

	public void setGameTypeName(String gameTypeName) {
		this.gameTypeName = gameTypeName;
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

	public Double getValidAmount() {
		return validAmount;
	}

	public void setValidAmount(Double validAmount) {
		this.validAmount = validAmount;
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

	public String getGameResult() {
		return gameResult;
	}

	public void setGameResult(String gameResult) {
		this.gameResult = gameResult;
	}

	public Date getBillTime() {
		return billTime;
	}

	public void setBillTime(Date billTime) {
		this.billTime = billTime;
	}

	public String getIsBill() {
		return isBill;
	}

	public void setIsBill(String isBill) {
		this.isBill = isBill;
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
