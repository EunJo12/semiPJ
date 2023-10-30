function idCheck(id) {
	regFrm.idbtncheck.value = "idCheck";
	if(id == ""){
		alert("아이디를 입력해주세요");
		regFrm.id.focus();
		return;
	}
	url = "idCheck.jsp?id=" + id;		/*파일명?넘겨줄파라미터이름=파라미터값 =>공백없이*/
	window.open(url, "IDCheck", "width=500, height=300");
	
}

function inputIdChk() {				//id입력란에 키보드를 누르면 다시 중복체크 알림뜨게 idUnCheck만들기
	regFrm.idbtncheck.value = "idUncheck";
}

function inputCheck() {
	if(regFrm.id.value == "") {
		alert("아이디를 입력해 주세요");
		regFrm.id.focus();
		return;
	}
	if(regFrm.idbtncheck.value != "idCheck"){
		alert("아이디 중복체크를 해주세요");
		return;
	}
	if(regFrm.pwd.value == "") {
		alert("비밀번호를 입력해 주세요");
		regFrm.pwd.focus();
		return;
	}
	if(regFrm.repwd.value == "") {
		alert("비밀번호를 다시 입력해 주세요");
		regFrm.repwd.focus();
		return;
	}
	if(regFrm.pwd.value != regFrm.repwd.value) {
		alert("비밀번호가 일치하지 않습니다");
		regFrm.repwd.value="";			//잘못 입력된 거 지우기(""로)
		regFrm.repwd.focus();
		return;
	}
	if(regFrm.name.value == "") {
		alert("이름을 입력해주세요");
		regFrm.name.focus();
		return;
	}
	
	
	
	
	const id = regFrm.id.value;
    let userinsert1 = /^[a-z][a-z0-9]{3,11}$/i;


    const pwd = regFrm.pwd.value;
    let userinsert2 = /^[0-9a-z#?!@$ %^&*-]{8,15}$/i;


    const repwd = regFrm.repwd.value;


    const name = regFrm.name.value;
    let userinsert3 = /^[가-힣]{2,4}$/;
            
            
	if (!userinsert1.test(id)|!userinsert2.test(pwd)|!userinsert3.test(name)|!(pwd == repwd)) {
            alert("잘못 입력된 항목이 있습니다");
            return;
    }
            
	regFrm.submit();				//submit이 아니라 button에 적용했기 때문에 꼭 마지막에 submit()을 명령해야 한다
}
