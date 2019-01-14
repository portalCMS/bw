package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingNB implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String betId;
	
	private String gameName;
	
	private String gameType;
	
	private String raceName;
	
	private String macthName;//比赛名称
	
	private String optionName;//比赛名称
	
	private String phaseNum;
	
	private Date betTime;
	
	private Date billTime;
	
	private Double betAmount;
	
	private Double valBetAmount;
	
	private Double winOrLoss;
	
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

	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public String getMacthName() {
		return macthName;
	}

	public void setMacthName(String macthName) {
		this.macthName = macthName;
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

	public String getRaceName() {
		return raceName;
	}

	public void setRaceName(String raceName) {
		this.raceName = raceName;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	

}
