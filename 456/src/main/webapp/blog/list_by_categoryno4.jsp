<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
$(function(){
 
});
</script>
 
<script type="text/javascript">
</script>
</head>
 
<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>     
  <form name='frm' id='frm' method="get" action="./list_by_categoryno.do">
  <ASIDE style='float: left;'>
    <A href='../category/list.do'>게시판 목록</A>
    >  
    <A href='./list_by_categoryno.do?categoryno=${categoryVO.categoryno }'>${categoryVO.title }</A>
 
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
 
    <c:if test="${sessionScope.id ne null }">
      <span class='menu_divide' >│</span> 
      <A href='./create.do?categoryno=${categoryVO.categoryno }'>등록</A>
    </c:if>
    
    <input type='hidden' name='categoryno' id='categoryno' value='${categoryVO.categoryno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word_find' id='word_find' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_categoryno.do?categoryno=${categoryVO.categoryno }'">전체 보기</button>
  </ASIDE>
  </form>
    
  <div class='menu_line' style='clear: both;'></div>       
 
  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>추천</th>
          <th>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="blogVO" items="${list }">
          <tr>
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${blogVO.thumb != ''}">
                <IMG id='thumb' src='./storage/${blogVO.thumb}' > <!-- 이미지 파일명 출력 -->
              </c:when>
              <c:when test="${blogVO.file1 != ''}"> <!-- 일반 파일명 출력 -->
                 ${blogVO.file1}
              </c:when>
              <c:otherwise>
                <IMG id='thumb' src='./images/none1.jpg' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>          
            <td style='vertical-align: middle;'>
            
              <c:choose>
                <c:when test="${blogVO.ansnum == 0 }"> <!-- 부모글인 경우 -->
                  <img src='./images/ting1.gif'>
                </c:when>
                <c:when test="${blogVO.ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/white.jpg' style='width: ${blogVO.indent * 20}px; opacity: 0.0;'>
                  <img src='./images/reply3.jpg'>
                </c:when>
              </c:choose>
            
              <a href="./read.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}&word_find=${param.word_find}&nowPage=${param.nowPage}">${blogVO.title}</a> 
            </td> 
 
            <td style='vertical-align: middle;'>${blogVO.rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${blogVO.good}</td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}&nowPage=${param.nowPage}&word_find=${param.word_find}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}&nowPage=${param.nowPage}&word_find=${param.word_find}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              <br>
              <!-- 
              grpno: ${blogVO.grpno }<br>
              indent: ${blogVO.indent }<br>
              ansnum: ${blogVO.ansnum }
               -->
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  <DIV class='bottom_menu'>${paging }</DIV>
  <br><br>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
 
 