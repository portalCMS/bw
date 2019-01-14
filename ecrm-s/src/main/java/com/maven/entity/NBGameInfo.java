package com.maven.entity;

import java.io.Serializable;

/**
 * @author 3hlxw
 * @Description: ${description}
 * @date 2018-05-24 17:17:25
 */
public class NBGameInfo implements Serializable {
    private String betId;
    private String orderNo;
    private String betAmount;
    private String validbet;
    private String winorloss;
    private String betTime;
    private String billTime;
    private String sportNo;
    private String raceName;
    private String macthId;
    private String macthName;
    private String gameType;
    private String gameName;
    private String optionId;
    private String optionName;
    private String odds;
    private String userId;
    private String userName;

    public NBGameInfo(){}

    public String getBetId() {
        return betId;
    }

    public void setBetId(String betId) {
        this.betId = betId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getBetAmount() {
        return betAmount;
    }

    public void setBetAmount(String betAmount) {
        this.betAmount = betAmount;
    }

    public String getValidbet() {
        return validbet;
    }

    public void setValidbet(String validbet) {
        this.validbet = validbet;
    }

    public String getWinorloss() {
        return winorloss;
    }

    public void setWinorloss(String winorloss) {
        this.winorloss = winorloss;
    }

    public String getBetTime() {
        return betTime;
    }

    public void setBetTime(String betTime) {
        this.betTime = betTime;
    }

    public String getBillTime() {
        return billTime;
    }

    public void setBillTime(String billTime) {
        this.billTime = billTime;
    }

    public String getSportNo() {
        return sportNo;
    }

    public void setSportNo(String sportNo) {
        this.sportNo = sportNo;
    }

    public String getRaceName() {
        return raceName;
    }

    public void setRaceName(String raceName) {
        this.raceName = raceName;
    }

    public String getMacthId() {
        return macthId;
    }

    public void setMacthId(String macthId) {
        this.macthId = macthId;
    }

    public String getMacthName() {
        return macthName;
    }

    public void setMacthName(String macthName) {
        this.macthName = macthName;
    }

    public String getGameType() {
        return gameType;
    }

    public void setGameType(String gameType) {
        this.gameType = gameType;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getOptionId() {
        return optionId;
    }

    public void setOptionId(String optionId) {
        this.optionId = optionId;
    }

    public String getOptionName() {
        return optionName;
    }

    public void setOptionName(String optionName) {
        this.optionName = optionName;
    }

    public String getOdds() {
        return odds;
    }

    public void setOdds(String odds) {
        this.odds = odds;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
