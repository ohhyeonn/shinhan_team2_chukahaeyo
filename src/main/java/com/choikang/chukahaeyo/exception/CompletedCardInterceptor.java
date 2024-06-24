package com.choikang.chukahaeyo.exception;

import com.choikang.chukahaeyo.card.CardService;
import com.choikang.chukahaeyo.visitor.VisitorService;
import com.choikang.chukahaeyo.visitor.model.VisitorVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.UUID;

@Component
public class CompletedCardInterceptor implements HandlerInterceptor {
    @Autowired
    CardService cardService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Map<String, String> pathVariables = (Map<String, String>) request
                                .getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        System.out.println(pathVariables.get("cardID"));
        int cardID = Integer.parseInt(pathVariables.get("cardID"));
        if(!checkCardIsPublic(cardID)) {
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }
        return true;
    }

    private boolean checkCardIsPublic(int cardID) {
        return cardService.selectCardIsPublic(cardID);
    }
}
