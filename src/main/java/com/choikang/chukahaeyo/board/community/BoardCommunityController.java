package com.choikang.chukahaeyo.board.community;


import com.choikang.chukahaeyo.board.model.CommunityVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/board")
public class BoardCommunityController {

    @Autowired
    BoardCommunityService boardCommunityService;



    @GetMapping("/service")
    public String serviceFaq() {

        return "board/service/faq";
    }


    @GetMapping("/community/list")
    public String communityList(@ModelAttribute CommunityVO vo , HttpServletRequest req) {



        req.setAttribute("map", boardCommunityService.getCommunityList(vo));


        return "board/comunityList";
    }


    @GetMapping("/community/detail")
    public String communityDetail(CommunityVO vo,HttpServletRequest req , HttpSession session) {
        if( session.getAttribute("memberID") == null){
            vo.setMemberID("0");
        }else {
            vo.setMemberID(String.valueOf(session.getAttribute("memberID")));
        }
        if( session.getAttribute("memberName") == null){
            vo.setMemberName("");
        }else {
            vo.setMemberName(String.valueOf(session.getAttribute("memberName")));
        }


        req.setAttribute("object" , boardCommunityService.getCommunityDetail(vo));


        return "board/communityDetail";
    }



    @GetMapping("/community/write")
    public String communityWriteView() throws UnsupportedEncodingException {

        return "board/communityPost";
    }

    @GetMapping("/community/update")
    public String communityUpdateView(CommunityVO vo , HttpServletRequest req , HttpSession session) throws UnsupportedEncodingException {
        if( session.getAttribute("memberID") == null){
            vo.setMemberID("0");
        }else {
            vo.setMemberID(String.valueOf(session.getAttribute("memberID")));
        }
        if( session.getAttribute("memberName") == null){
            vo.setMemberName("");
        }else {
            vo.setMemberName(String.valueOf(session.getAttribute("memberName")));
        }




        req.setAttribute("object" ,boardCommunityService.getCommunityDetail(vo));



        return "board/communityUpdate";
    }

    @PostMapping("/community/update")
    public String communityUpdateAction(CommunityVO vo) throws UnsupportedEncodingException {


        boardCommunityService.updateCommunity(vo);



        return "redirect:detail?commID="+vo.getCommID();
    }


    @PostMapping("/community/delete")
    public String communityDeleteAction(CommunityVO vo) throws UnsupportedEncodingException {

        boardCommunityService.deleteCommunity(vo);



        return "redirect:list";
    }






    @PostMapping("/community/write")
    public String communityWriteInsert(@ModelAttribute CommunityVO vo , HttpSession session) throws UnsupportedEncodingException {

        //세션에서 memberId 넣어주고
        vo.setMemberID(String.valueOf(session.getAttribute("memberID")));

        //서비스 타고 no 받는다.
        boardCommunityService.insertCommunity(vo);




        return "redirect:detail?commID="+vo.getCommID();
    }


    @ResponseBody
    @GetMapping("/community/heartred")
    public Map communityHeartred(CommunityVO vo, HttpSession session) {
        if( session.getAttribute("memberId") == null){
            vo.setMemberID("0");
        }else {
            vo.setMemberID(String.valueOf(session.getAttribute("memberId")));
        }
        Map<String, Object> map = new HashMap<>();
        map.put("isRed", boardCommunityService.deleteHeart(vo));
        map.put("boardLike", boardCommunityService.getLikeCount(vo));


        return map;

    }


    @ResponseBody
    @GetMapping("/community/heartblack")
    public Map communityHeartblack(CommunityVO vo, HttpSession session) {
        if( session.getAttribute("memberId") == null){
            vo.setMemberID("0");
        }else {
            vo.setMemberID(String.valueOf(session.getAttribute("memberId")));
        }
        Map<String, Object> map = new HashMap<>();
        map.put("isRed", boardCommunityService.insertHeart(vo));
        map.put("boardLike", boardCommunityService.getLikeCount(vo));


        return map;

    }

}