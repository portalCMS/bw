package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingYSB implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String betId;
	
	private String selectionPlace;
	
	private Date betTime;
	
	private Date billTime;
	
	private Double betAmount;
	
	private Double valBetAmount;
	
	private Double winOrLoss;
	
	private String sportType;
	
	private String oddFormat;
	
	private String betStatus;
	
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

	public String getSelectionPlace() {
		return selectionPlace;
	}

	public void setSelectionPlace(String selectionPlace) {
		this.selectionPlace = selectionPlace;
	}

	public Date getBetTime() {
		return betTime;
	}

	public void setBetTime(Date betTime) {
		this.betTime = betTime;
	}

	public Date getBillTime() {
		return billTime;
	}

	public void setBillTime(Date billTime) {
		this.billTime = billTime;
	}

	public Double getBetAmount() {
		return betAmount;
	}

	public void setBetAmount(Double betAmount) {
		this.betAmount = betAmount;
	}

	public Double getValBetAmount() {
		return valBetAmount;
	}

	public void setValBetAmount(Double valBetAmount) {
		this.valBetAmount = valBetAmount;
	}

	public Double getWinOrLoss() {
		return winOrLoss;
	}

	public void setWinOrLoss(Double winOrLoss) {
		this.winOrLoss = winOrLoss;
	}

	public String getSportType() {
		return sportType;
	}

	public void setSportType(String sportType) {
		this.sportType = sportType;
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

	public String getOddFormat() {
		return oddFormat;
	}

	public void setOddFormat(String oddFormat) {
		this.oddFormat = oddFormat;
	}
	
}
