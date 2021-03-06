package com.maven.entity;

import java.io.Serializable;

/**
 * Model class of game.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Game implements Serializable,Cloneable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 游戏编码. */
	private String gamecode;

	/** 游戏类型. */
	private String gametype;

	/** 游戏名称. */
	private String gamename;
	
	/** 排序字段. */
	private int sort;
	
	private String picid;
	
	private String android;
	
	private String h5;
	
	private String iso;
	
	private String downloadurl;
	
	/* 是否选择 */
	private Boolean ischoice = false;
	
	
	/**
	 * Constructor.
	 */
	public Game() {
	}
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}
	/**
	 * Set the 游戏编码.
	 * 
	 * @param gamecode
	 *            游戏编码
	 */
	public void setGamecode(String gamecode) {
		this.gamecode = gamecode;
	}

	/**
	 * Get the 游戏编码.
	 * 
	 * @return 游戏编码
	 */
	public String getGamecode() {
		return this.gamecode;
	}

	/**
	 * Set the 游戏类型.
	 * 
	 * @param gametype
	 *            游戏类型
	 */
	public void setGametype(String gametype) {
		this.gametype = gametype;
	}

	/**
	 * Get the 游戏类型.
	 * 
	 * @return 游戏类型
	 */
	public String getGametype() {
		return this.gametype;
	}

	/**
	 * Set the 游戏名称.
	 * 
	 * @param gamename
	 *            游戏名称
	 */
	public void setGamename(String gamename) {
		this.gamename = gamename;
	}

	/**
	 * Get the 游戏名称.
	 * 
	 * @return 游戏名称
	 */
	public String getGamename() {
		return this.gamename;
	}

	public String getPicid() {
		return picid;
	}
	public void setPicid(String picid) {
		this.picid = picid;
	}
	public String getAndroid() {
		return android;
	}
	public void setAndroid(String android) {
		this.android = android;
	}
	public String getH5() {
		return h5;
	}
	public void setH5(String h5) {
		this.h5 = h5;
	}
	public String getIso() {
		return iso;
	}
	public void setIso(String iso) {
		this.iso = iso;
	}
	public String getDownloadurl() {
		return downloadurl;
	}
	public void setDownloadurl(String downloadurl) {
		this.downloadurl = downloadurl;
	}
	public boolean isIschoice() {
		return ischoice;
	}

	public void setIschoice(Boolean ischoice) {
		this.ischoice = ischoice;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((gamecode == null) ? 0 : gamecode.hashCode());
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
		Game other = (Game) obj;
		if (gamecode == null) {
			if (other.gamecode != null) {
				return false;
			}
		} else if (!gamecode.equals(other.gamecode)) {
			return false;
		}
		return true;
	}

	@Override
	public Game clone() throws CloneNotSupportedException {
		return (Game)super.clone();
	}

}
