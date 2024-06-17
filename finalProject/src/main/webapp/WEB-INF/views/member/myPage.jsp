
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
    <%@include file="../common/header.jsp" %>
    
    <div class="content">
        <br> <br>
        <div class="innerOuter">
            <h2>마이페이지</h2>
            <br>
            <!-- updateMember() 메소드를 이용하여 처리하기 
                 성공했을땐 정보수정 성공! 메세지와 함께 마이페이지로 돌아오기 (변경된정보로)
                 실패했을땐 에러페이지로 이동 정보수정 실패! 메세지와 함께 
                 성별도 체크 되어있도록 처리
            -->
            <form action="update.me" method="post">
                <div class="form-group">
                    <label for="enrollMemberId">&nbsp; ID</label>
                    <input type="text" id="enrollMemberId" name="memberId" class="form-control" value="${loginUser.memberId}" readonly> <br>
                    
                    <label for="memberNick">&nbsp; NICKNAME</label>
                    <input type="text" id="memberNick" name="memberNick" class="form-control" value="${loginUser.memberNick}"> <br>
                    
                    <label for="memberPwd">&nbsp; PASSWORD</label>
                    <input type="password" id="memberPwd" name="memberPwd" class="form-control"> <br>
                    
                    <label for="checkPwd">&nbsp; PASSWORD CHECK</label>
                    <input type="password" id="checkPwd" class="form-control"> <br>
                    
                    <label for="birthDate">* BIRTH DATE</label>
                    <input type="text" id="birthDate" name="birthDate" class="form-control" value="${loginUser.birthDate}" placeholder="YYYYMMDD"> <br>
                    
                    <label for="gender"> &nbsp; GENDER</label> &nbsp;&nbsp;
                    <input type="radio" id="male" value="M" name="gender" ${loginUser.gender == 'M' ? 'checked' : ''}>
                    <label for="male">남자</label> &nbsp;&nbsp;
                    <input type="radio" id="female" value="F" name="gender" ${loginUser.gender == 'F' ? 'checked' : ''}>
                    <label for="female">여자</label> &nbsp;&nbsp;

                    <label for="status"> &nbsp; STATUS</label>
                    <input type="text" id="status" name="status" class="form-control" value="${loginUser.status}" readonly> <br>
                    
                    <label for="isAdmin"> &nbsp; ADMIN</label>
                    <input type="text" id="isAdmin" name="isAdmin" class="form-control" value="${loginUser.isAdmin}" readonly> <br>
                </div>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">정보수정</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">회원탈퇴</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        //남자 또는 여자 radio 체크 되어있도록 작업하기
        
        $(function(){
            //필수입력 사항이 아니라 값이 없을 수도 있음
            var gender = "${loginUser.gender}";
            
            //있으면 해당 데이터와 일치하는 radio 선택시키기 
            
            if(gender != ""){//값이 없을땐 ""로 처리되니 없는지 확인하기 
                $("input[value=" + gender + "]").attr("checked",true);
            }
        });
    </script>
    
    <!--메소드명 :  deleteMember 
        성공시 메세지와 함께 메인페이지로 이동(재요청) - 세션로그인 정보 제거 
        실패시 에러페이지 에러메세지와 함께 보내기
    -->
    
    <!-- 회원탈퇴 클릭시 사용될 모달영역 -->
    <div class="modal fade" id="deleteModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원탈퇴</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- 회원탈퇴 요청 처리할 form태그 -->
                <form action="delete.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div align="center">
                            탈퇴 후 복구가 불가능 합니다. <br>
                            정말로 탈퇴하시겠습니까? <br>
                        </div>
                        
                        <label for="memberPwd">PASSWORD :</label>
                        <input type="password" class="form-control mb-2 mr-sm-2" 
                                placeholder="ENTER PASSWORD" id="memberPwd" name="memberPwd">
                                
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger">회원탈퇴</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    
    <%@include file="../common/footer.jsp" %>
</body>
</html>