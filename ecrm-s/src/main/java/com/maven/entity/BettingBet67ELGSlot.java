package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingBet67ELGSlot implements Serializable {

	private static final long serialVersionUID = 1L;

	private String betId;
	private String gameCode;
	private String gameName;
	private Date betTime;
	private Double betMoney;
	private Double valBetAmount;
	private Double winOrLoss;
	private Double betBefore;
	private Double billBefore;
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

	public String getGameCode() {
		return gameCode;
	}

	public void setGameCode(String gameCode) {
		this.gameCode = gameCode;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public Date getBetTime() {
		return betTime;
	}

	public void setBetTime(Date betTime) {
		this.betTime = betTime;
	}

	public Double getBetMoney() {
		return betMoney;
	}

	public void setBetMoney(Double betMoney) {
		this.betMoney = betMoney;
	}

	public Double getWinOrLoss() {
		return winOrLoss;
	}

	public void setWinOrLoss(Double winOrLoss) {
		this.winOrLoss = winOrLoss;
	}

	public Double getBetBefore() {
		return betBefore;
	}

	public void setBetBefore(Double betBefore) {
		this.betBefore = betBefore;
	}

	public Double getBillBefore() {
		return billBefore;
	}

	public void setBillBefore(Double billBefore) {
		this.billBefore = billBefore;
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

	public Double getValBetAmount() {
		return valBetAmount;
	}

	public void setValBetAmount(Double valBetAmount) {
		this.valBetAmount = valBetAmount;
	}
	
}
