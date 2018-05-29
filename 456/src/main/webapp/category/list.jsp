<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    $('#panel_create').show();
    $('#panel_update').hide();
    
  });

  function update(categoryno){
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do",
      type: "GET",
      cache: false,
      dataType: "json", // or html
      data: 'categoryno=' + categoryno,
      success: function(data){
        var frm_update = $('#frm_update'); // id 검색
        $('#categoryno', frm_update).val(data.categoryno);
        $('#categrpno', frm_update).val(data.categrpno);
        $('#title', frm_update).val(data.title);
        $('#seqno', frm_update).val(data.seqno);
        $('#visible', frm_update).val(data.visible); // SELECT 자동 선택됨.
        
        $('#ids', frm_update).val(data.ids);
        
        
      },
      // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
      error: function (request, status, error){  
        var msg = "에러가 발생했습니다. <br><br>";
        msg += "다시 시도해주세요.<br><br>";
        msg += "request.status: " + request.status + "<br>";
        msg += "request.responseText: " + request.responseText + "<br>";
        msg += "status: " + status + "<br>";
        msg += "error: " + error;

        var panel = "";
        panel += "<DIV id='panel' class='popup1' style='height: 350px;'>";
        panel += msg;
        panel += "<br>[<A href=\"javascript: $('#main_panel').hide()\">CLOSE</A>]";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);      
        $('#main_panel').show();
      }
    });
  }

  function create_update_cancel(){
    var frm_create = $('#frm_create');
    $('#categrpno', frm_create).val('');            
    $('#title', frm_create).val('');            
    $('#seqno', frm_create).val('');
    $('#visible', frm_create).val('');    
    
    $('#ids', frm_create).val('');    
    
    $('#panel_create').show();
    $('#panel_update').hide();

    $('#name', frm_create).focus(); // show() 호출후 선언
  }

  function deleteOne(categoryno) {
    var msg = "카테고리를 삭제합니다. <br><br>";
    msg += "삭제하면 복구 할 수 없습니다.<br><br>";

    var panel = "";
    panel += "<DIV id='panel' class='popup1' style='height: 250px;'>";
    panel += msg;
    // panel += "<br>[<A href='./delete.do?categrpno="+categrpno+"' class='menu_link' >삭제 진행</A>]";
    
    var frm_delete = $('#frm_delete');
    $('#categoryno', frm_delete).val(categoryno);
    
    panel += "<br>[<A href='javascript: frm_delete.submit();' class='menu_link' >삭제 진행</A>]";
    panel += "[<A href=\"javascript: $('#main_panel').hide()\" class='menu_link' >CLOSE</A>]";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);      
    $('#main_panel').show();
  }

  // 우선순위 up 10 -> 1
  function seqnoUp(categoryno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#categoryno', frm_seqno).val(categoryno);
    frm_seqno.submit();
  }

  // 우선순위 down 1 -> 10
  function seqnoDown(categoryno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#categoryno', frm_seqno).val(categoryno);
    frm_seqno.submit();
  }
  
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>
  <DIV class='title'>카테고리</DIV>
  
  <DIV id='main_panel'></DIV>

  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='categoryno' id='categoryno' value=''>
  </FORM>
  
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='categoryno' id='categoryno' value=''>
  </FORM>
    
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <!-- 개발시 임시 값 사용 -->
      <!-- 
      <input type='hidden' name='categrpno' id='categrpno' value='1'>
       -->
       
      <label for='title'>카테고리 그룹 번호</label>
      <input type='text' name='categrpno' id='categrpno' size='5' value='' required="required" style='width: 3%;'>
      
      <label for='title'>카테고리 이름</label>
      <input type='text' name='title' id='title' size='10' value='' required="required" style='width: 10%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'>
  
      <label for='visible'>출력 형식</label>
      <!-- 
      <input type='text' name='visible' id='visible' value='' required="required" style='width: 2%;'>
       -->
       <select name='visible'>
         <option value='Y' selected="selected">Y</option>
         <option value='N'>N</option>
       </select>
       
      <label for='ids'>접근 계정</label>
      <input type='text' name='ids' id='ids' value='admin' required="required" style='width: 10%;'>

      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='categoryno' id='categoryno' value=''> 

      <label for='title'>카테고리 그룹 번호</label>
      <input type='text' name='categrpno' id='categrpno' size='5' value='' required="required" style='width: 3%;'>
      
      <label for='name'>카테고리 이름</label>
      <input type='text' name='title' id='title' size='15' value='' required="required" style='width: 20%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'>
  
      <label for='visible'>출력 형식</label>
      <select name='visible' id='visible'>
        <option value='Y'>Y</option>
        <option value='N'>N</option>
      </select>
       
      <label for='ids'>접근 계정</label>
      <input type='text' name='ids' id='ids' value='admin' required="required" style='width: 10%;'>

      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>

  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>categrpno</TH>
    <TH style='text-align: center ;'>name</TH>
    <TH>seqno</TH>
    <TH style='text-align: center ;'>categoryno</TH>
    <TH style='text-align: center ;'>title</TH>
    <TH style='text-align: center ;'>category_seqno</TH>
    <TH style='text-align: center ;'>visible</TH>
    <TH style='text-align: center ;'>ids</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>
  <tbody>
    <c:forEach var="categrp_CategoryVO" items="${list }">
      <TR>
        <TD style='text-align: center ;'>${categrp_CategoryVO.categrpno}</TD>
        <TD style='text-align: center ;'>${categrp_CategoryVO.name}</TD>
        <TD>${categrp_CategoryVO.seqno}</TD>
        <TD>${categrp_CategoryVO.categoryno}</TD>
        <TD>${categrp_CategoryVO.title}</TD>
        <TD>${categrp_CategoryVO.category_seqno}</TD>
        <TD>${categrp_CategoryVO.visible}</TD>
        <TD>${categrp_CategoryVO.ids}</TD>
        <TD style='text-align: center;'>
          <A href="javascript:update(${categrp_CategoryVO.categoryno })"><IMG src='./images/update.png' title='수정'></A>
          <A href="javascript:deleteOne(${categrp_CategoryVO.categoryno })"><IMG src='./images/delete.png' title='삭제'></A>
          <A href="javascript:seqnoUp(${categrp_CategoryVO.categoryno })"><IMG src='./images/up.jpg' title='우선 순위 높임' style='width: 16px;'></A>
          <A href="javascript:seqnoDown(${categrp_CategoryVO.categoryno })"><IMG src='./images/down.jpg' title='우선 순위 감소' style='width: 16px;'></A>
        </TD>
      </TR>
    </c:forEach>
  </tbody>
  


</TABLE>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 