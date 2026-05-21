<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.svelte.model.OrderItem"%>

<!-- GET ORDER DATA -->
<%
    List<OrderItem> items =
            (List<OrderItem>) request.getAttribute("items");

    int orderId =
            (Integer) request.getAttribute("orderId");

    double grandTotal = 0;
%>

<!DOCTYPE html>
<html>

<head>
    <!-- PAGE TITLE -->
    <title>Order Details</title>

    <!-- CSS FILE -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/orders.css">

    <!-- PAGE STYLES -->
    <style>

        .details-container{
            max-width:1000px;
            margin:40px auto;
            padding:20px;
        }

        .details-title{
            font-size:38px;
            margin-bottom:30px;
        }

        .item-card{

            display:flex;
            gap:25px;

            background:white;

            padding:20px;

            margin-bottom:25px;

            border:1px solid #e5e5e5;
        }

        .item-image img{

            width:180px;
            height:180px;

            object-fit:cover;
        }

        .item-info{
            flex:1;
        }

        .item-info h2{
            margin-bottom:15px;
        }

        .item-info p{
            margin-bottom:10px;
            color:#555;
        }

        .item-total{
            font-size:20px;
            font-weight:bold;
            margin-top:15px;
        }

        .grand-total{

            text-align:right;

            font-size:28px;
            font-weight:bold;

            margin-top:30px;
        }

        .back-btn{

            display:inline-block;

            margin-top:30px;

            background:black;
            color:white;

            padding:14px 22px;

            text-decoration:none;

            transition:0.3s;
        }

        .back-btn:hover{
            background:#c7b299;
        }

    </style>

</head>

<body>
    
<!-- NAVBAR -->
<jsp:include page="/pages/navbar.jsp" />

<!-- DETAILS CONTAINER -->
<div class="details-container">

    <!-- PAGE TITLE -->
    <h1 class="details-title">
        Order #<%= orderId %>
    </h1>

    <%
        if(items != null && !items.isEmpty()){

            for(OrderItem item : items){

                double itemTotal =
                        item.getPrice()
                        * item.getQuantity();

                grandTotal += itemTotal;
    %>

    <!-- ITEM CARD -->

    <div class="item-card">

        <!-- IMAGE -->

        <div class="item-image">

            <img src="${pageContext.request.contextPath}/watchtemp/<%= item.getImageUrl() %>"
                 alt="watch">

        </div>

        <!-- DETAILS -->

        <div class="item-info">

            <h2>
                <%= item.getProductName() %>
            </h2>

            <p>
                Quantity:
                <%= item.getQuantity() %>
            </p>

            <p>
                Price:
                Rs. <%= item.getPrice() %>
            </p>

            <div class="item-total">

                Total:
                Rs. <%= itemTotal %>

            </div>

        </div>

    </div>

    <%
            }
        }
    %>

    <!-- GRAND TOTAL -->

    <div class="grand-total">

        Grand Total:
        Rs. <%= grandTotal %>

    </div>

    

</div>

</body>
</html>