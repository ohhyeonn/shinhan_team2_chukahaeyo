<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>test</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="/resources/css/pageFrame/common.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <style>
        .sticker3 {
            display: block;
            margin: 200px auto;
            text-align: center;
        }

        .url-container {
            border: none;
            color: black;
            padding: 20px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            border-radius: 10px;
            background-color: #DFDFDF;
            display: block;
            margin: 20px 400px auto;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .button-copy .button {
            border: none;
            color: black;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 10px;
            background-color: #DFDFDF;
        }

        .button-main .button {
            border: none;
            color: black;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 10px;
            background-color: #85A7FF;
            width: 155.23px;
            height: 49.5px;
        }

        .button-copy .button:hover {
            background-color: #B0B0B0;
        }

        .button-main .button:hover {
            background-color: #6690FF;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/include/header.jsp" %>
<main class="main">
    <div class="sticker1"></div>

    <div style="width: 100%; position: relative">
        <div class="sticker3">
            <img src="/resources/img/payment/paySuccessCheck.png" alt="결제 성공 체크 이미지" style="width: 10%;"><br><br>
            <img src="/resources/img/payment/successPayText.png" alt="결제 성공 텍스트 이미지" style="width: 20%;"><br><br><br>
            <div class="url-container">
                카드 URL | <span class="url" id="shortUrl">${param.shortUrl}</span>
            </div>

            <br><br>
            <div class="buttons">
                <div class="button-copy">
                    <button class="button copy" onclick="copyUrl()">URL 복사하기</button>
                </div>
                <div class="button-main">
                    <button class="button main2" onclick="goToMain()">메인으로 이동</button>
                </div>
            </div>
        </div>
    </div>
    <div class="sticker2"></div>
</main>
<%@ include file="/WEB-INF/view/include/footer.jsp" %>

<script>
    function copyUrl() {
        const urlElement = document.getElementById('shortUrl');
        const url = urlElement.textContent;
        navigator.clipboard.writeText(url).then(function() {
            console.log(url);
            alert('URL이 복사되었습니다.');
        }, function(err) {
            console.error('URL 복사 실패: ', err);
        });
    }

    function goToMain() {
        window.location.href = '/';
    }
</script>
</body>
</html>
