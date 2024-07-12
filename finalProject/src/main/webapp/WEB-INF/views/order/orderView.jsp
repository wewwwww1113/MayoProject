<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.springProject.member.model.vo.Member"%>
<%
    Member loginUser = (Member)session.getAttribute("loginUser");
    
    String alertMsg = (String)session.getAttribute("alertMsg");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 페이지</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .product-list {
            margin-bottom: 20px;
        }

        .product-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .product-item span {
            font-weight: bold;
        }

        .total-price {
            margin-top: 10px;
            font-size: 18px;
            text-align: right;
        }

        .address-form {
            margin-top: 20px;
        }

        .address-form label {
            font-weight: bold;
        }

        .address-form input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .checkout-btn {
            display: block;
            width: 120px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            color: #fff;
            background-color: #212529;
            border: 1px solid #212529;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .checkout-btn:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .checkout-btn:active {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(1px);
        }
        .return-btn {
            display: block;
            width: 120px;
            margin: 10px auto;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            color: #fff;
            background-color: red;
            border: 1px solid #6c757d;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .return-btn:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }

        .return-btn:active {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(1px);
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
        var IMP = window.IMP; 
        IMP.init("imp72535783"); 
        var memberNo = '<%= loginUser.getMemberNo() %>';
        
        function updatePrices() {
            var basePrice = parseInt($("input[name=baseTotalPrice]").val(), 10);
            var productName = $("input[name=productName]").val();
            var quickServicePrice = 30000;
            var totalPrice = basePrice;
            
            if ($('#quickService').is(':checked')) {
                totalPrice += quickServicePrice;
                if (!productName.includes(" +퀵서비스")) {
                    productName += " +퀵서비스";
                }
            } else {
                if (productName.includes(" +퀵서비스")) {
                    productName = productName.replace(" +퀵서비스", "");
                }
            }
            
            $(".total-price").text("총 금액: " + totalPrice + " 원");
            $("input[name=totalPrice]").val(totalPrice);
            $("input[name=productName]").val(productName);
        }

        function requestPay() {
            var totalPrice = parseInt($("input[name=totalPrice]").val(), 10);
            if (totalPrice <= 0) {
                alert("결제 금액이 0원입니다. 다시 확인해주세요.");
                return;
            }

            var productName = $("input[name=productName]").val();
            var userName = $("input[name=name]").val();
            var phone = $("input[name=phone]").val();
            var address = $("input[name=address]").val();
            
            var today = new Date();   
            var hours = today.getHours();
            var minutes = today.getMinutes();
            var seconds = today.getSeconds();
            var milliseconds = today.getMilliseconds();
            var makeMerchantUid = hours + minutes + seconds + milliseconds;

            IMP.request_pay({
                pg: 'html5_inicis',
                pay_method: "card",
                merchant_uid: "IMP" + makeMerchantUid, 
                name: productName,
                amount: totalPrice,
                buyer_name: userName,
                buyer_tel: phone,
                buyer_addr: address
            },
            function (rsp) {
                console.log(rsp);
                if (rsp.success) {
                    $.ajax({
                        url: "insertPay.or",
                        type: "POST",
                        data: {
                            pg: rsp.pg_tid,
                            merchantUid: rsp.merchant_uid,
                            amount: rsp.paid_amount,
                            buyerName: rsp.buyer_name,
                            buyerTel: rsp.buyer_tel,
                            buyerAddr: rsp.buyer_addr,
                            paidAt: rsp.paid_at,
                            receiptUrl: rsp.receipt_url,
                            pdName: rsp.name,
                            memberNo: memberNo
                        },
                        success: function(result) {
                            if (result > 0) {
                                console.log(rsp);
                                console.log("zz" + rsp.merchant_uid);
                                location.href = "pay.or/" + rsp.merchant_uid; // mcUid를 URI에 포함하여 이동
                            } else {
                                alert("결제정보 오류 [관리자에게 문의하세요]");
                            }
                        },
                        error: function() {
                            console.log("통신실패");
                            console.log(rsp);
                        }
                    });
                } else {
                    console.log(rsp);
                }
            });
        }

        $(document).ready(function() {
            $('#quickService').change(function() {
                updatePrices();
            });
            
            $('#payment-form').on('submit', function(event) {
                event.preventDefault();
                requestPay();
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>결제 정보 확인</h2>

        <form id="payment-form">
            <div class="product-list">
                <c:forEach items="${cart}" var="cartItem">
                    <div class="product-item">
                        <span>${cartItem.store.pdName}</span>
                        <span>${cartItem.quantity} 개</span>
                        <span>${cartItem.store.price * cartItem.quantity} 원</span>
                    </div>
                </c:forEach>
            </div>

            <c:set var="productNamesWithQuantities" value="" />
            <c:forEach items="${cart}" var="cartItem">
                <c:set var="productNamesWithQuantities" value="${productNamesWithQuantities}${cartItem.store.pdName}(${cartItem.quantity} 개), " />
            </c:forEach>
            <c:set var="productNamesWithQuantities" value="${fn:substring(productNamesWithQuantities, 0, fn:length(productNamesWithQuantities) - 2)}" />
            
            <c:set var="totalPrice" value="0" />
            <c:forEach items="${cart}" var="cartItem">
                <c:set var="totalPrice" value="${totalPrice + (cartItem.store.price * cartItem.quantity)}" />
            </c:forEach>

            <div class="total-price">
                총 금액: ${totalPrice} 원
            </div>
            <input type="hidden" id="productName" name="productName" value="${productNamesWithQuantities}">
            <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">
            <input type="hidden" name="baseTotalPrice" value="${totalPrice}">

            <div class="address-form">
                <h3>배송 정보 입력</h3>
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="address">주소</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="text" id="phone" name="phone" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="quickService">퀵서비스 30000원 추가 (서울지역만 가능합니다.) 사용시 전화 드립니다.</label>
                <input type="checkbox" id="quickService">
            </div>
            
            <button type="submit" class="checkout-btn">결제하기</button>
            <a href="#" class="return-btn" onclick="history.back();">장바구니로 돌아가기</a>
        </form>
    </div>
    
    <%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
