package com.choikang.chukahaeyo.board.comment;


import com.choikang.chukahaeyo.board.model.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardCommentService {

    @Autowired
    BoardCommentMapper boardCommentMapper;

    public Map index(CommentVO vo) {
        int totalCount = boardCommentMapper.count(vo); // 총 게시물 수

        List<CommentVO> list = boardCommentMapper.list(vo); // 목록

        System.out.println(list);
        Map map = new HashMap();
        map.put("totalCount", totalCount);
        map.put("list", list); // 모델에 직접 넣어줘도 됨


        return map;


    }
}
