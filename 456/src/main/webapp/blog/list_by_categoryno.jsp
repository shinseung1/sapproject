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

function create() {
  $('#panel_create').show();
  
}
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     

  <ASIDE style='float: left;'>
    <A href='../category/list.do'>게시판 목록</A>
    <span style='font-size: 1.2em;'>></span> 
    <A href='./list_by_categoryno.do?categoryno=${categoryVO.categoryno }'>${categoryVO.title }</A> 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='javascript:create();'>등록</A>
  </ASIDE> 
         
  <div style='width: 100%;'>
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
                  <IMG id='thumb' src='./storage/${blogVO.thumb }'> <!-- 이미지 파일명 출력 -->
                </c:when>
                <c:when test="${blogVO.file1 != '' }">
                  ${blogVO.file1 } <!-- 일반 파일명 출력 -->
                </c:when>
                <c:otherwise>
                  <!-- 파일이 존재하지 않는 경우 -->
                  <IMG src='./images/none1.jpg' style='width: 120px; height: 80px;'>
                </c:otherwise>
              </c:choose>
            </td>
            
            <td style='vertical-align: middle;'>
              <a href="./read.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}">${blogVO.title}</a> 
            </td> 

            <td style='vertical-align: middle;'>${blogVO.rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${blogVO.good}</td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?blogno=${blogVO.blogno}&categoryno=${blogVO.categoryno}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              ${blogVO.categoryno} / ${blogVO.mno }
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>

  <DIV name="panel_create" id="panel_create" class='popup2' 
          style='width: 94%; display: none;'>
  <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='categoryno' id='categoryno' value='${param.categoryno }'>
      <input type='hidden' name='mno' id='mno' value='1'>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='text' class="form-control input-lg" name='title' id='title' value='' required="required" style='width: 80%;' placeholder="제목">
        </div>
      </div>   
      <div class="form-group">   
        <div class="col-md-12">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' placeholder="내용"></textarea>
        </div>
      </div>
      <div class="form-group">   
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='word' id='word' value='' placeholder="검색어">
        </div>
      </div>
      <div class="form-group">   
        <div class="col-md-12">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="$('#panel_create').hide();">취소</button>
      </DIV>
  </FORM>

  
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>
 
 