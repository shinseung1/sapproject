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

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function(){ // window.onload = ...
    $('#panel_create').show(); // <DIV id='panel_create' 
    $('#panel_update').hide(); // <DIV id='panel_update' 
    
  });

  function update(categrpno){
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({ // XMLHttpRequest 객체사용
      url: "./update.do",
      type: "GET",
      cache: false,
      dataType: "json", // or html
      data: 'categrpno=' + categrpno, // 보내는 데이터
      success: function(data){ // data 변수는 변경가능하며 Spring이 보낸 JSON 문자열이 저장
        var frm_update = $('#frm_update'); // <DIV id='panel_update' 검색
        $('#categrpno', frm_update).val(data.categrpno); // frm_update폼에서 categrpno 검색
        $('#name', frm_update).val(data.name);
        $('#seqno', frm_update).val(data.seqno);
        $('#visible', frm_update).val(data.visible);
      },
      // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
      error: function (request, status, error){  
        var msg = "에러가 발생했습니다. <br><br>";
        msg += "다시 시도해주세요.<br><br>";
        msg += "▶ request.status: " + request.status + "<br>";
        msg += "▶ request.responseText: " + request.responseText + "<br>";
        msg += "<br> ▶ status: " + status + "<br>";
        msg += "<br> ▶ error: " + error;

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
    $('#name', frm_create).val('');            
    $('#seqno', frm_create).val('');            
    $('#visible', frm_create).val('');    
    
    $('#panel_create').show();
    $('#panel_update').hide();

    $('#name', frm_create).focus(); // show() 호출후 선언
  }
  
  function deleteOne(categrpno) {
    var name = '';
    $.ajax({ // XMLHttpRequest 객체사용
      url: "./delete.do",
      type: "GET",
      cache: false,
      dataType: "json", // or html
      data: 'categrpno=' + categrpno, // 보내는 데이터
      success: function(data){ // data 변수는 변경가능하며 Spring이 보낸 JSON 문자열이 저장
        // console.log('--> data.name: ' + data.name);
        // name = data.name;
        // console.log('--> name: ' + name);
        
        // $('#main_panel').attr('data-name', name);
        var msg = "'" + data.name + "' 카테고리 그룹을 삭제합니다. <br>";
        msg += "그룹에 소속된 카테고리가 " + data.count + "건 발견되었습니다.<br>"   
        msg += "[<A href='javascript: deleteByCategrpno();' class='menu_link' > "+data.name + "' 카테고리 그룹 삭제 진행</A>]";
        msg += "<br><br>삭제하면 복구 할 수 없습니다.<br><br>";

        var panel = "";
        panel += "<DIV id='panel' class='popup1' style='height: 350px; width: 450px;'>";
        panel += msg;
        // panel += "<br>[<A href='./delete.do?categrpno="+categrpno+"' class='menu_link' >삭제 진행</A>]";
        
        var frm_delete = $('#frm_delete');
        $('#categrpno', frm_delete).val(categrpno);
        
        panel += "<br>[<A href='javascript: frm_delete.submit();' class='menu_link' >삭제 진행</A>]";
        panel += "[<A href=\"javascript: $('#main_panel').hide()\" class='menu_link' >CLOSE</A>]";
        panel += "</DIV>";  
        
        $('#main_panel').html(panel);      
        $('#main_panel').show();
      },
      // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
      error: function (request, status, error){  
        var msg = "에러가 발생했습니다. <br><br>";
        msg += "다시 시도해주세요.<br><br>";

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
  
  function seqnoUp(categrpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#categrpno', frm_seqno).val(categrpno);
    frm_seqno.submit();
  }

  function seqnoDown(categrpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#categrpno', frm_seqno).val(categrpno);
    frm_seqno.submit();
  }
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='categrpno' id='categrpno' value=''>
  </FORM>
  
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='categrpno' id='categrpno' value=''>
  </FORM>
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>카테고리 그룹</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label for='name'>카테고리 그룹 이름</label>
      <input type='text' name='name' id='name' size='15' value='' required="required" style='width: 30%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'>
  
      <label for='visible'>출력 형식</label>
      <select name='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>

      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='categrpno' id='categrpno' value=''>
      
      <label for='name'>카테고리 그룹 이름</label>
      <input type='text' name='name' id='name' size='15' value='' required="required" style='width: 30%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'>
  
      <label for='visible'>출력 형식</label>
      <select name='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
      
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH style='text-align: center ;'>코드</TH>
    <TH>대분류명</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>

  <c:forEach var="categrpVO" items="${list }">
  <TR>
    <TD style='text-align: center;'>${categrpVO.seqno }</TD>
    <TD style='text-align: center;'>${categrpVO.categrpno }</TD>
    <TD>${categrpVO.name }</TD>
    <TD style='text-align: center;'>${categrpVO.rdate.substring(0, 10) }</TD>
    <TD style='text-align: center;'>
      <A href="javascript:update(${categrpVO.categrpno })"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:deleteOne(${categrpVO.categrpno })"><IMG src='./images/delete.png' title='삭제'></A>
      <A href="javascript:seqnoUp(${categrpVO.categrpno })"><IMG src='./images/up.jpg' title='우선 순위 높임' style='width: 16px;'></A>
      <A href="javascript:seqnoDown(${categrpVO.categrpno })"><IMG src='./images/down.jpg' title='우선 순위 감소' style='width: 16px;'></A>
    </TD>
  </TR>
  </c:forEach>

</TABLE>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
   