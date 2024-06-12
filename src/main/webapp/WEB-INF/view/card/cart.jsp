<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="/resources/css/pageFrame/common.css"/>
    <link rel="stylesheet" href="/resources/css/pageFrame/cart.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function updateTotal() {
            let total = 0;
            document.querySelectorAll('.card-checkbox:checked').forEach(function (checkbox) {
                total += parseInt(checkbox.value);
            });
            document.getElementById('totalAmount').innerText = total.toLocaleString() + '원';
        }

        function updateReceipt() {
            let receiptList = document.querySelector('.cart-list');
            receiptList.innerHTML = ''; // 기존 영수증 목록 비우기
            document.querySelectorAll('.card-checkbox:checked').forEach(function (checkbox, index) {
                let card = checkbox.closest('.card');
                let cardPrice = card.querySelector('.card-checkbox').value;
                let cardText = card.querySelector('.card-text').textContent;
                receiptList.innerHTML += '<p><span>' + (index + 1) + '&nbsp;&nbsp;&nbsp;&nbsp;' + cardText + '</span> <span style="float: right;">' + parseInt(cardPrice).toLocaleString() + '원</span></p>';
            });
        }

        function deleteCard(cardId, event) {
            if (confirm("정말로 삭제하겠습니까?")) {
                $.ajax({
                    url: '/deleteCard',
                    type: 'POST',
                    data: {cardId: cardId},
                    success: function (response) {
                        if (response.status === 'success') {
                            alert("카드가 삭제되었습니다.");
                            $(event.target).closest('.card').remove(); // DOM에서 카드 제거
                            updateTotal(); // 삭제 후 합계 금액 재계산
                            updateReceipt(); // 삭제 후 영수증 목록 재계산
                        } else {
                            alert("삭제 실패: " + response.message);
                        }
                    }
                });
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            const cards = document.querySelectorAll('.card');
            if (cards.length % 2 !== 0) {
                cards[cards.length - 1].classList.add('align-to-left'); // 마지막 카드 정렬
            }
            updateReceipt(); // 페이지 로드 시 영수증 목록 초기화
        });

        function proceedToPayment() {
            let selectedCards = []; // 결제할 카드 목록을 담은 리스트
            document.querySelectorAll('.card-checkbox:checked').forEach(function (checkbox) {
                let card = checkbox.closest('.card');
                let cardInfo = {
                    cardId: card.querySelector('.close-button').getAttribute('onclick').match(/\d+/)[0],
                    cardName: card.querySelector('.card-text').textContent,
                    cardPrice: card.querySelector('.card-checkbox').value
                };
                selectedCards.push(cardInfo);
            });

            console.log("Selected Cards:", selectedCards);
            if (confirm("결제하시겠습니까?")) {
                // 여기에 결제 로직 추가
                alert("결제가 완료되었습니다.");
            }
        }
    </script>
</head>

<body>
<%@ include file="/WEB-INF/view/include/header.jsp" %>
<main class="main" style="height: 95%">
    <div class="sticker1"></div>
    <div style="width: 100%;">
        <img src="/resources/img/logo/cart_logo.png" alt="장바구니 logo" class="cart-logo">
        <div class="container">
            <div class="cart-grid">
                <c:forEach var="card" items="${cardList}">
                    <div class="card">
                        <img src="${card.templateThumbnail}" alt="템플릿">
                        <div class="card-overlay">
                            <p>${card.cardName}</p>
                            <p>${card.cardStartDate}</p>
                        </div>
                        <button class="close-button" onclick="deleteCard(${card.cardID}, event)">X</button>
                        <div class="card-content">
                            <p class="card-text">${card.cardName}</p>
                            <input type="checkbox" class="card-checkbox" value="${card.cardPrice}"
                                   onclick="updateTotal(); updateReceipt();">
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="cart-payment">
                <div class="cart-receipt">
                    <h1>선택 카드 목록</h1>
                    <hr>
                    <div class="cart-list"></div>
                    <hr>
                    <h2>합계 <span id="totalAmount" style="float: right;">0원</span></h2>
                </div>
                <input type="button" value="결제하기" onclick="proceedToPayment()">
            </div>
        </div>
    </div>
    <div class="sticker2"></div>
</main>
<%@ include file="/WEB-INF/view/include/footer.jsp" %>
</body>
</html>
