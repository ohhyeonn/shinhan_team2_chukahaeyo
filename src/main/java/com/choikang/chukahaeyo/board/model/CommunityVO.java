package com.choikang.chukahaeyo.board.model;

import lombok.Data;

import java.util.Date;


@Data
public class CommunityVO {


    public CommunityVO() {
        this.query = "";
        this.querytype = "all";
        this.page = "1";
    }

    private String query;
    private String page;
    private String querytype;



    private String commId;
    private String memberId;
    private String commTitle;
    private String commContents;
    private Date commPostDate;
    private Date commEditedDate;
    private String commViewCount;

    private String boardLike;

    private String memberEmail;
    private String memberPwd;
    private String memberName;


    private int startIdx;

    public int getStartIdx() {
        return (Integer.parseInt(page)-1) * 10;
    }
}
