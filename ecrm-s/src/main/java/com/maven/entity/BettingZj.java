package com.maven.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Model class of betting_zj.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class BettingZj implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 游戏平台记录 id. */
	private String id;

	/** 企业编码. */
	private String enterprisecode;

	/** 企业品牌编码. */
	private String brandcode;

	/** 员工编码. */
	private String employeecode;
	
	/**  用户账号  */
	private String loginaccount;

	/** 员工上级编码. */
	private String parentemployeecode;

	/** 会员名称. */
	private String username;

	/** currency. */
	private String currency;

	/** 下注游戏类型. */
	private String gametype;

	/** 桌号 ID. */
	private String tableinfoid;

	/** 靴号 ID. */
	private String shoeinfoid;

	/** gameInfoId. */
	private String gameinfoid;

	/** 桌名称. */
	private String tablename;

	/** 一个台桌中某一局的唯一标识. */
	private String issueno;

	/** 结果 (注,当结果是”-1”时，为取消). */
	private String bankerresult;

	/** resultList. */
	private String resultlist;

	/** pokerList. */
	private String pokerlist;

	/** 下注额. */
	private Double stakeamount;

	/** 有效投注额. */
	private Double validstake;

	/** 输赢. */
	private Double winloss;

	/** 佣金. */
	private Double comm;

	/** 下注后余额. */
	private Double balanceafter;

	/** 结果时间. */
	private Date endtime;

	/** 下注 IP. */
	private String ip;

	/** 详情. */
	private String details;

	/** 下注时间. */
	private Date bettime;

	/** 数据拉取时间. */
	private Date createtime;

	/**
	 * Constructor.
	 */
	public BettingZj() {
	}

	/**
	 * Set the 游戏平台记录 id.
	 * 
	 * @param id
	 *            游戏平台记录 id
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * Get the 游戏平台记录 id.
	 * 
	 * @return 游戏平台记录 id
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * Set the 企业编码.
	 * 
	 * @param enterprisecode
	 *            企业编码
	 */
	public void setEnterprisecode(String enterprisecode) {
		this.enterprisecode = enterprisecode;
	}

	/**
	 * Get the 企业编码.
	 * 
	 * @return 企业编码
	 */
	public String getEnterprisecode() {
		return this.enterprisecode;
	}

	public String getLoginaccount() {
		return loginaccount;
	}

	public void setLoginaccount(String loginaccount) {
		this.loginaccount = loginaccount;
	}

	/**
	 * Set the 企业品牌编码.
	 * 
	 * @param brandcode
	 *            企业品牌编码
	 */
	public void setBrandcode(String brandcode) {
		this.brandcode = brandcode;
	}

	/**
	 * Get the 企业品牌编码.
	 * 
	 * @return 企业品牌编码
	 */
	public String getBrandcode() {
		return this.brandcode;
	}

	/**
	 * Set the 员工编码.
	 * 
	 * @param employeecode
	 *            员工编码
	 */
	public void setEmployeecode(String employeecode) {
		this.employeecode = employeecode;
	}

	/**
	 * Get the 员工编码.
	 * 
	 * @return 员工编码
	 */
	public String getEmployeecode() {
		return this.employeecode;
	}

	/**
	 * Set the 员工上级编码.
	 * 
	 * @param parentemployeecode
	 *            员工上级编码
	 */
	public void setParentemployeecode(String parentemployeecode) {
		this.parentemployeecode = parentemployeecode;
	}

	/**
	 * Get the 员工上级编码.
	 * 
	 * @return 员工上级编码
	 */
	public String getParentemployeecode() {
		return this.parentemployeecode;
	}

	/**
	 * Set the 会员名称.
	 * 
	 * @param username
	 *            会员名称
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * Get the 会员名称.
	 * 
	 * @return 会员名称
	 */
	public String getUsername() {
		return this.username;
	}

	/**
	 * Set the currency.
	 * 
	 * @param currency
	 *            currency
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * Get the currency.
	 * 
	 * @return currency
	 */
	public String getCurrency() {
		return this.currency;
	}

	/**
	 * Set the 下注游戏类型.
	 * 
	 * @param gametype
	 *            下注游戏类型
	 */
	public void setGametype(String gametype) {
		this.gametype = gametype;
	}

	/**
	 * Get the 下注游戏类型.
	 * 
	 * @return 下注游戏类型
	 */
	public String getGametype() {
		return this.gametype;
	}

	/**
	 * Set the 桌号 ID.
	 * 
	 * @param tableinfoid
	 *            桌号 ID
	 */
	public void setTableinfoid(String tableinfoid) {
		this.tableinfoid = tableinfoid;
	}

	/**
	 * Get the 桌号 ID.
	 * 
	 * @return 桌号 ID
	 */
	public String getTableinfoid() {
		return this.tableinfoid;
	}

	/**
	 * Set the 靴号 ID.
	 * 
	 * @param shoeinfoid
	 *            靴号 ID
	 */
	public void setShoeinfoid(String shoeinfoid) {
		this.shoeinfoid = shoeinfoid;
	}

	/**
	 * Get the 靴号 ID.
	 * 
	 * @return 靴号 ID
	 */
	public String getShoeinfoid() {
		return this.shoeinfoid;
	}

	/**
	 * Set the gameInfoId.
	 * 
	 * @param gameinfoid
	 *            gameInfoId
	 */
	public void setGameinfoid(String gameinfoid) {
		this.gameinfoid = gameinfoid;
	}

	/**
	 * Get the gameInfoId.
	 * 
	 * @return gameInfoId
	 */
	public String getGameinfoid() {
		return this.gameinfoid;
	}

	/**
	 * Set the 桌名称.
	 * 
	 * @param tablename
	 *            桌名称
	 */
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	/**
	 * Get the 桌名称.
	 * 
	 * @return 桌名称
	 */
	public String getTablename() {
		return this.tablename;
	}

	/**
	 * Set the 一个台桌中某一局的唯一标识.
	 * 
	 * @param issueno
	 *            一个台桌中某一局的唯一标识
	 */
	public void setIssueno(String issueno) {
		this.issueno = issueno;
	}

	/**
	 * Get the 一个台桌中某一局的唯一标识.
	 * 
	 * @return 一个台桌中某一局的唯一标识
	 */
	public String getIssueno() {
		return this.issueno;
	}

	/**
	 * Set the 结果 (注,当结果是”-1”时，为取消).
	 * 
	 * @param bankerresult
	 *            结果 (注,当结果是”-1”时，为取消)
	 */
	public void setBankerresult(String bankerresult) {
		this.bankerresult = bankerresult;
	}

	/**
	 * Get the 结果 (注,当结果是”-1”时，为取消).
	 * 
	 * @return 结果 (注,当结果是”-1”时，为取消)
	 */
	public String getBankerresult() {
		return this.bankerresult;
	}

	/**
	 * Set the resultList.
	 * 
	 * @param resultlist
	 *            resultList
	 */
	public void setResultlist(String resultlist) {
		this.resultlist = resultlist;
	}

	/**
	 * Get the resultList.
	 * 
	 * @return resultList
	 */
	public String getResultlist() {
		return this.resultlist;
	}

	/**
	 * Set the pokerList.
	 * 
	 * @param pokerlist
	 *            pokerList
	 */
	public void setPokerlist(String pokerlist) {
		this.pokerlist = pokerlist;
	}

	/**
	 * Get the pokerList.
	 * 
	 * @return pokerList
	 */
	public String getPokerlist() {
		return this.pokerlist;
	}

	/**
	 * Set the 下注额.
	 * 
	 * @param stakeamount
	 *            下注额
	 */
	public void setStakeamount(Double stakeamount) {
		this.stakeamount = stakeamount;
	}

	/**
	 * Get the 下注额.
	 * 
	 * @return 下注额
	 */
	public Double getStakeamount() {
		return this.stakeamount;
	}

	/**
	 * Set the 有效投注额.
	 * 
	 * @param validstake
	 *            有效投注额
	 */
	public void setValidstake(Double validstake) {
		this.validstake = validstake;
	}

	/**
	 * Get the 有效投注额.
	 * 
	 * @return 有效投注额
	 */
	public Double getValidstake() {
		return this.validstake;
	}

	/**
	 * Set the 输赢.
	 * 
	 * @param winloss
	 *            输赢
	 */
	public void setWinloss(Double winloss) {
		this.winloss = winloss;
	}

	/**
	 * Get the 输赢.
	 * 
	 * @return 输赢
	 */
	public Double getWinloss() {
		return this.winloss;
	}

	/**
	 * Set the 佣金.
	 * 
	 * @param comm
	 *            佣金
	 */
	public void setComm(Double comm) {
		this.comm = comm;
	}

	/**
	 * Get the 佣金.
	 * 
	 * @return 佣金
	 */
	public Double getComm() {
		return this.comm;
	}

	/**
	 * Set the 下注后余额.
	 * 
	 * @param balanceafter
	 *            下注后余额
	 */
	public void setBalanceafter(Double balanceafter) {
		this.balanceafter = balanceafter;
	}

	/**
	 * Get the 下注后余额.
	 * 
	 * @return 下注后余额
	 */
	public Double getBalanceafter() {
		return this.balanceafter;
	}

	/**
	 * Set the 结果时间.
	 * 
	 * @param endtime
	 *            结果时间
	 */
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	/**
	 * Get the 结果时间.
	 * 
	 * @return 结果时间
	 */
	public Date getEndtime() {
		return this.endtime;
	}

	/**
	 * Set the 下注 IP.
	 * 
	 * @param ip
	 *            下注 IP
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * Get the 下注 IP.
	 * 
	 * @return 下注 IP
	 */
	public String getIp() {
		return this.ip;
	}

	/**
	 * Set the 详情.
	 * 
	 * @param details
	 *            详情
	 */
	public void setDetails(String details) {
		this.details = details;
	}

	/**
	 * Get the 详情.
	 * 
	 * @return 详情
	 */
	public String getDetails() {
		return this.details;
	}

	/**
	 * Set the 下注时间.
	 * 
	 * @param bettime
	 *            下注时间
	 */
	public void setBettime(Date bettime) {
		this.bettime = bettime;
	}

	/**
	 * Get the 下注时间.
	 * 
	 * @return 下注时间
	 */
	public Date getBettime() {
		return this.bettime;
	}

	/**
	 * Set the 数据拉取时间.
	 * 
	 * @param createtime
	 *            数据拉取时间
	 */
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	/**
	 * Get the 数据拉取时间.
	 * 
	 * @return 数据拉取时间
	 */
	public Date getCreatetime() {
		return this.createtime;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		BettingZj other = (BettingZj) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id)) {
			return false;
		}
		return true;
	}

}