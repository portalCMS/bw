package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

public class BettingBet67AGLive implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String betId;
	private Date betTime;
	private String playType;
	private Double betMoney;
	private Double okBetMoney;
	private Double betResult;
	private String gameType;
	private String isbill;
	private String gameCode;
	private String tableCode;
	private String userName;
	private String enterprisecode;
	private String brandcode;
	private String employeecode;
	private String parentemployeecode;
	private String gamebigtype;
	
	/* 查询条件:开始条数*/
	private Integer start;
	/* 查询条件:查询条数 */
	private Integer limit;
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
	public String getPlayType() {
		return playType;
	}
	public void setPlayType(String playType) {
		this.playType = playType;
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
	public String getGameType() {
		return gameType;
	}
	public void setGameType(String gameType) {
		this.gameType = gameType;
	}
	public String getIsbill() {
		return isbill;
	}
	public void setIsbill(String isbill) {
		this.isbill = isbill;
	}
	public String getGameCode() {
		return gameCode;
	}
	public void setGameCode(String gameCode) {
		this.gameCode = gameCode;
	}
	public String getTableCode() {
		return tableCode;
	}
	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
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
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
}
