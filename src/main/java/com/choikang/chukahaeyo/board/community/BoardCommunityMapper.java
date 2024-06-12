package com.choikang.chukahaeyo.board.community;


import com.choikang.chukahaeyo.board.model.CommunityVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardCommunityMapper {
    List<CommunityVO> getCommunityList(CommunityVO communityVO);


    int count(CommunityVO vo);

    int insertCommunity(CommunityVO vo);

    CommunityVO getCommunityDetail(CommunityVO vo);
}
