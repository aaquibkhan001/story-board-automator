'use strict';

/**
 * Automator util
 */

// below function is to check access of the user whether he is rightful user or
// not
function checkAccess() {

	if (!isEmpty(sessionStorage.userDetails)
			&& sessionStorage.userDetails != 'undefined') {
		// console.log("User Details are " + sessionStorage.userDetails);
		var userdata = JSON.parse(sessionStorage.userDetails);
		if (userdata.userRole == "normal" || userdata.userRole == "admin") {
			// console.log("User is not authorized to view this page");

			return true;
		} else {
			// console.log("User is authorized to view this page");
			return false;
		}
	} else {

		window.location.replace("/Automator");
	}
}

function checkAccessForButtons() {

	if (!isEmpty(sessionStorage.userDetails)
			&& sessionStorage.userDetails != 'undefined') {
		// console.log("User Details are " + sessionStorage.userDetails);
		var userdata = JSON.parse(sessionStorage.userDetails);
		if (userdata.userRole == "normal" || userdata.userRole == "admin") {
			// console.log("User is not authorized to view this page");

			return true;
		} else {
			// console.log("User is authorized to view this page");
			return false;
		}
	} else {

		window.location.replace("/Automator");
	}
}

function isEmail(str){
	//var reg = /^([a-zA-Z0-9]+[_|\_|\.|\-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	var reg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
	if(reg.test(str))
		return true;
	else
		return false;
}

function toDate(dateStr) {
    const [day, month, year] = dateStr.split("-")
    return new Date(year, month - 1, day)
}

function showDialog(str){
	 $.confirm({
         'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
         'message': str,
         'buttons': {
             'OK': {
                 'class': 'blue',
                 'action': function() {
                     window.open('', '_self', '');
                 }
             },
         }
     });
     return false;
}

function isEmpty(str) {
	try {
		if (typeof str == 'undefined')
			return true;

		if (str == false)
			return true;

		// when defined, but empty
		if ((str.length == 0) || (str == "") || (str.replace(/\s/g, "") == "")
				|| (!/[^\s]/.test(str)) || (/^\s*$/.test(str)))
			return true;

		return false;

	} catch (err) {
		return true;
	}
}

function isNumeric(str) {
	if (isEmpty(str))
		return false;
	var regex = new RegExp("^[0-9]+$");
	if (regex.test(str)) {
		return true;
	}
	return false;
}

function isAlphaNumeric(str) {
	if (isEmpty(str))
		return false;
	var regex = new RegExp("^[A-Za-z0-9]+$");
	if (regex.test(str)) {
		return true;
	}
	return false;
}

function isAlphaNumericSpace(str) {
	if (isEmpty(str))
		return false;
	var regex = new RegExp("^[A-Za-z0-9 ]+$");
	if (regex.test(str)) {
		return true;
	}
	return false;
}

