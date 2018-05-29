<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
.categrp_category{
  width: 20%;
  margin: 0px auto; 
  border-left: none; 
  border-right: none;
  border-top: solid 1px #DDDDDD;  
  border-bottom: solid 1px #DDDDDD;  
  text-align: left;
}
.categrp_category_list{
  padding-left: 10%; 
  line-height: 15px;
}

.categrp_name{
  font-weight: bold;
  list-style-image: url("${pageContext.request.contextPath}/category/images/name.png");
}
.category_title{
  list-style-image: url("${pageContext.request.contextPath}/category/images/title.png");
}
</style>

<fieldset class='categrp_category' >
  <DIV style='margin-bottom: 0px; padding-bottom: 0px;'>▷ 카테고리</DIV>
  <DIV>
    <img src='${pageContext.request.contextPath}/category/images/title.png'>
    <A href="${pageContext.request.contextPath}/blog/list_total.do">전체 보기</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <UL class='categrp_category_list' >
    <c:forEach var="title" items="${name_title_list}">
      ${title}
    </c:forEach>
  </UL>
</fieldset>
<br>
