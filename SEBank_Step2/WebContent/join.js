/**
 * 
 */

function formCheck() {
	var id = document.getElementsByName("custid");
	if (id[0].value.length > 10 || id[0].value.length < 3) {
		alert('아이디는 3~10자로 입력해 주십시오.');
		return false;
	}

	var pw = document.getElementsByName("password1");
	var pw2 = document.getElementsByName("password2");
	var psw1 = pw[0].value;
	var psw2 = pw2[0].value;
	if (psw1.length > 10 || psw1.length < 3) {
		alert('비밀번호는 3~10자로 입력해 주십시오.');
		return false;
	}
	if (psw2.length > 10 || psw2.length < 3) {
		alert('비밀번호는 3~10자로 입력해 주십시오.');
		return false;
	}

	if (psw1 != psw2) {
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}

	var name = document.getElementById("name");
	if (name.value.length < 1) {
		alert('이름을 입력하여 주십시오.');
		return false;
	}

	var idno = document.getElementById("idno");
	if (idno.value.length < 1) {
		alert('식별번호를 입력하여 주십시오.');
		return false;
	}



	return true;
}

function isSelected(id) {
	opener.document.getElementById("custid").value = id;
	this.close();
}

function formCheckd() {
	var id = document.getElementById("id");
	if (id.value == '') {
		alert('아이디를 입력해 주십시오');
		return false;
	}
	return true;
}

function idCheckOpen() {
	window.open("idCheck.jsp", "idCheckWin", "top=200, left=400, width=400, height=250");
}