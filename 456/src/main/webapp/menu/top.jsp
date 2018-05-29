<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
  <!-- 화면 상단 메뉴 -->
  <DIV class='top_menu_label'>힐링 여행/영화 ver 0.6</DIV>
 
  <DIV id='top_menu'
          style="background-image: url('${pageContext.request.contextPath}/menu/images/top_image.jpg')" >
    <NAV class='top_menu_list'>
      <A class='menu_link'  href='${pageContext.request.contextPath}' >HOME</A> <span class='top_menu1'> | </span> 
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <A class='menu_link'  href='${pageContext.request.contextPath}/member/login.do' >Login</A> <span class='top_menu1'> | </span>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <A class='menu_link'  href='${pageContext.request.contextPath}/member/logout.do' >Logout</A> <span class='top_menu1'> | </span>
        </c:otherwise>
      </c:choose>
      <c:choose>
        <c:when test="${sessionScope.id != null}">
          <A class='menu_link'  href='${pageContext.request.contextPath}/categrp/list.do'>카테고리 그룹</A> <span class='top_menu1'> | </span>    
          <A class='menu_link'  href='${pageContext.request.contextPath}/category/list.do'>카테고리</A> <span class='top_menu1'> | </span>
          <A class='menu_link'  href='${pageContext.request.contextPath}/blog/list_all_category.do'>여행 상품</A> <span class='top_menu1'> | </span>    
          <A class='menu_link'  href='${pageContext.request.contextPath}/member/list.do'>회원</A> <span class='top_menu1'> | </span>    
        </c:when>
        <c:otherwise>
          여행/영화 블로그에 오신것을 환영합니다.
        </c:otherwise>
      </c:choose>
    </NAV>
  </DIV>
  
  <!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->  
  <DIV class="row" style='margin-top: 2px;'>
    <DIV class="col-md-2"> <!-- 메뉴 출력 컬럼 -->
      <img src='${pageContext.request.contextPath}/menu/images/myimage.jpg' style='width: 100%;'>
      <div style='margin-top: 5px;'>
        <img src='${pageContext.request.contextPath}/menu/images/myface.png'>왕눈이
      </div>
       ▷ <A class='menu_link_left'  href='./info.jsp'>블로그 소개</A><br>
      <c:choose>
        <c:when test="${sessionScope.id != null}">
          ▷ <A class='menu_link_left'  href='${pageContext.request.contextPath}/member/read_user.do?mno=${sessionScope.mno}' >나의 정보</A><br>
          ▷ <A class='menu_link_left'  href='${pageContext.request.contextPath}/member/update_user.do?mno=${sessionScope.mno}' >비밀번호 변경</A><br>
          ▷ <A class='menu_link_left'  href='${pageContext.request.contextPath}/member/cancel.do?mno=${sessionScope.mno}' >회원 탈퇴</A><br>
        </c:when>
      </c:choose>
      <br>       
       <!-- Spring 출력 카테고리 그룹 / 카테고리 -->
      <c:import url="/category/list_index_left.do" />
    </div>
      
    <DIV class="col-md-10 cont">  <!-- 내용 출력 컬럼 -->  