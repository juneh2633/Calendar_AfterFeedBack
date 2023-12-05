function modalAppearEvent(idx, month) {
     console.log("ㅎㅎ",grantWrite);
    if (grantWrite == true) {
        makeScheduleInputForm();  
        var scheduleDay = document.getElementById("scheduleDay");
        var scheduleMonth = document.getElementById("scheduleMonth");
        var scheduleYear = document.getElementById("scheduleYear");
        scheduleDay.value = idx;
        scheduleMonth.value = document.getElementById("monthArea").innerText.slice(0, -1);
        scheduleYear.value = document.getElementById("yearArea").innerText.slice(0, -1); 
    }
    showSchedule(idx, month);
    var modalPage = document.getElementById("modalPage");
    modalPage.style.display = "flex";
    var modalDate = document.getElementById("modalDate");
    modalDate.innerHTML = idx + "일";
    document.getElementById("modalOverlay").style.display = "block";
}
function modalDisappearEvent() {
    var modalPage = document.getElementById("modalPage");
    modalPage.style.display = "none";    
    document.getElementById("modalOverlay").style.display = "none";
    if (grantWrite == true) {
        document.getElementById("modalMain").remove();
    }   
    document.getElementById("modalFooter").remove();
}
function scheduleUpdateEvent(idx) {
    var scheduleBox = document.getElementById("scheduleBox" + idx);
    var scheduleUpdateBox = document.getElementById("scheduleUpdateBox" + idx);
    scheduleBox.style.display = "none";
    scheduleUpdateBox.style.display = "flex";
}
function scheduleDeleteEvent(idx) {
    var uid = document.getElementById("uid" + idx).innerText;
    location.href = "action/scheduleDeleteAction.jsp?uid=" + uid;
} 
function scheduleConfirmEvent(idx) {
    var uid = document.getElementById("uid" + idx).innerText;
    var scheduleUpdateTime = document.getElementById("scheduleUpdateTime" + idx).value;
    var scheduleUpdateText = document.getElementById("scheduleUpdateText" + idx).value
    if (scheduleUpdateTime.value == "") {
        alert("시간을 넣어주세요");
        return;
    }
    if (scheduleUpdateText.value=="") {
        alert("일정을 넣어주세요");
        return;
    }
    location.href = "action/scheduleUpdateAction.jsp?uid="+uid+"&scheduleUpdateTime="+scheduleUpdateTime+"&scheduleUpdateText="+scheduleUpdateText;    
}
function scheduleCancleEvent(idx) {
    var scheduleBox = document.getElementById("scheduleBox" + idx);
    var scheduleUpdateBox = document.getElementById("scheduleUpdateBox" + idx);
    scheduleBox.style.display = "flex";
    scheduleUpdateBox.style.display = "none";
}
function insertScheduleEvent() {
    var modalInputTime = document.getElementById("modalInputTime");
    if (modalInputTime.value == "") {
        alert("시간을 넣어주세요");
        return;
    }
    var modalInputSchedule = document.getElementById("modalInputSchedule");
    if (modalInputSchedule.value=="") {
        alert("일정을 넣어주세요");
        return;
    }
    console.log(modalInputTime.value);
    console.log(modalInputSchedule.value);
    document.inputScheduleForm.submit();
}

function showSchedule(idx, month) {
    var scheduleList = scheduleTreeJson[dateToString(idx, month)];
    var modalFooter = document.createElement('div'); 
    modalFooter.id = "modalFooter";
    modalFooter.className = "modalFooter"; 
    document.getElementById("modalPage").appendChild(modalFooter);
    if (scheduleList == null) {
        //일정이 없는경우
        return;
    }   
    console.log("스케쥴리스트", scheduleList);
    for (var idx = 0; idx < scheduleList.length; idx++){
        var scheduleElementTime = scheduleList[idx].scheduleTime.slice(0, -3);
        var scheduleElementText = scheduleList[idx].scheduleText;
        var scheduleElementUid = scheduleList[idx].scheduleUid;
        makeScheduleBox(idx, scheduleElementTime, scheduleElementText, scheduleElementUid);
        makeScheduleUpdateBox(idx, scheduleElementTime, scheduleElementText, scheduleElementUid);
    }
}
function makeScheduleBox(idx, scheduleElementTime, scheduleElementText, uid) {
    var scheduleBox = document.createElement('div'); 
    scheduleBox.id = "scheduleBox" + idx;
    scheduleBox.className = "scheduleBox";  
    document.getElementById("modalFooter").appendChild(scheduleBox);

    var scheduleTime = document.createElement('div'); 
    scheduleTime.id = "scheduleTime"+ idx;
    scheduleTime.className = "scheduleTime"; 
    document.getElementById("scheduleBox" + idx).appendChild(scheduleTime);
    document.getElementById("scheduleTime" + idx).innerHTML = scheduleElementTime;

    var scheduleText = document.createElement('div'); 
    scheduleText.id = "scheduleText"+ idx;
    scheduleText.className = "scheduleText";  
    document.getElementById("scheduleBox" + idx).appendChild(scheduleText);
    document.getElementById("scheduleText" + idx).innerHTML = scheduleElementText;
    
    var saveUid = document.createElement('div');
    saveUid.id = "uid" + idx;
    saveUid.style.display = "none";
    document.getElementById("scheduleBox" + idx).appendChild(saveUid);
    document.getElementById("uid" + idx).innerHTML = uid;
    if (grantWrite == true) {
        var scheduleUpdate = document.createElement('input'); 
        scheduleUpdate.id = "scheduleUpdate" + idx;
        scheduleUpdate.className = "scheduleUpdate";
        scheduleUpdate.type = "button";
        scheduleUpdate.value = "수정";
        scheduleUpdate.onclick = function() {
            scheduleUpdateEvent(idx);
        };
        document.getElementById("scheduleBox" + idx).appendChild(scheduleUpdate);
        
        var scheduleDelete = document.createElement('input'); 
        scheduleDelete.id = "scheduleDelete" + idx;
        scheduleDelete.className = "scheduleDelete";
        scheduleDelete.type = "button";
        scheduleDelete.value = "삭제";
        scheduleDelete.onclick = function () {
            scheduleDeleteEvent(idx);
        }    
        document.getElementById("scheduleBox" + idx).appendChild(scheduleDelete);
    }
}
function makeScheduleUpdateBox(idx, scheduleElementTime, scheduleElementText, uid) {
    var scheduleUpdateBox = document.createElement('div'); 
    scheduleUpdateBox.id = "scheduleUpdateBox" + idx;
    scheduleUpdateBox.className = "scheduleUpdateBox"; 
    scheduleUpdateBox.style.display = "none";
    document.getElementById("modalFooter").appendChild(scheduleUpdateBox);

    var scheduleUpdateTime = document.createElement('input'); 
    scheduleUpdateTime.id = "scheduleUpdateTime" + idx;
    scheduleUpdateTime.className = "scheduleUpdateTime";
    scheduleUpdateTime.type = "time";
    scheduleUpdateTime.value = scheduleElementTime;
    document.getElementById("scheduleUpdateBox" + idx).appendChild(scheduleUpdateTime); 

    var scheduleUpdateText = document.createElement('input'); 
    scheduleUpdateText.id = "scheduleUpdateText" + idx;
    scheduleUpdateText.className = "scheduleUpdateText";
    scheduleUpdateText.type = "text";
    scheduleUpdateText.maxLength = "50";
    scheduleUpdateText.value = scheduleElementText;
    document.getElementById("scheduleUpdateBox" + idx).appendChild(scheduleUpdateText); 

    var saveUpdateUid = document.createElement('div');
    saveUpdateUid.id = "uidUpdate" + idx;
    saveUpdateUid.style.display = "none";
    document.getElementById("scheduleUpdateBox" + idx).appendChild(saveUpdateUid);
    document.getElementById("uidUpdate" + idx).innerHTML = uid;
    
    var scheduleConfirm = document.createElement('input'); 
    scheduleConfirm.id = "scheduleConfirm" + idx;
    scheduleConfirm.className = "scheduleUpdate";
    scheduleConfirm.type = "button";
    scheduleConfirm.value = "확인";
    scheduleConfirm.onclick = function () {
        scheduleConfirmEvent(idx);
    }
    document.getElementById("scheduleUpdateBox" + idx).appendChild(scheduleConfirm);

    var scheduleCancel = document.createElement('input'); 
    scheduleCancel.id = "scheduleCancel" + idx;
    scheduleCancel.className = "scheduleDelete";
    scheduleCancel.type = "button";
    scheduleCancel.value = "취소";
    scheduleCancel.onclick = function () {
        scheduleCancleEvent(idx);    
    }
    document.getElementById("scheduleUpdateBox" + idx).appendChild(scheduleCancel);
}
function makeScheduleInputForm() {
    var modalMain = document.createElement("div");
    modalMain.id = "modalMain";
    modalMain.className = "modalMain";
    document.getElementById("modalPage").appendChild(modalMain);
    var modalMain = document.getElementById("modalMain");
    // 새로운 div 요소를 생성
    var modalMainInput = document.createElement('div');
    modalMainInput.id = "modalMainInput";
    modalMainInput.className = "modalMainInput";
    // form 요소 생성
    var form = document.createElement('form');
    form.name = "inputScheduleForm";
    form.action = "action/scheduleInsertAction.jsp";
    // 각 input 요소 생성 및 설정
    var scheduleDayInput = document.createElement('input');
    scheduleDayInput.id = "scheduleDay";
    scheduleDayInput.name = "scheduleDay";
    scheduleDayInput.value = "0";
    scheduleDayInput.type = "text";
    scheduleDayInput.style.display = "none";

    var scheduleMonthInput = document.createElement('input');
    scheduleMonthInput.id = "scheduleMonth";
    scheduleMonthInput.name = "scheduleMonth";
    scheduleMonthInput.value = "0";
    scheduleMonthInput.type = "text";
    scheduleMonthInput.style.display = "none";

    var scheduleYearInput = document.createElement('input');
    scheduleYearInput.id = "scheduleYear";
    scheduleYearInput.name = "scheduleYear";
    scheduleYearInput.value = "0";
    scheduleYearInput.type = "text";
    scheduleYearInput.style.display = "none";

    var modalInputTimeInput = document.createElement('input');
    modalInputTimeInput.id = "modalInputTime";
    modalInputTimeInput.name = "modalInputTime";
    modalInputTimeInput.className = "modalInputTime";
    modalInputTimeInput.type = "time";

    var modalInputScheduleInput = document.createElement('input');
    modalInputScheduleInput.id = "modalInputSchedule";
    modalInputScheduleInput.name = "modalInputSchedule";
    modalInputScheduleInput.className = "modalInputSchedule";
    modalInputScheduleInput.type = "text";
    modalInputScheduleInput.maxLength = "50";
    modalInputScheduleInput.placeholder = "50자 제한";
    // input 요소들을 form에 추가
    form.appendChild(scheduleDayInput);
    form.appendChild(scheduleMonthInput);
    form.appendChild(scheduleYearInput);
    form.appendChild(modalInputTimeInput);
    form.appendChild(modalInputScheduleInput);

    // form을 modalMainInput에 추가
    modalMainInput.appendChild(form);

    // modalMainInput을 modalMain에 추가
    modalMain.appendChild(modalMainInput);

    // 추가 버튼 생성
    var modalInputButton = document.createElement('input');
    modalInputButton.id = "modalInputButton";
    modalInputButton.className = "modalInputButton";
    modalInputButton.type = "button";
    modalInputButton.value = "추가";
    modalInputButton.onclick = insertScheduleEvent;

    // modalMain에 추가 버튼 추가
    modalMain.appendChild(modalInputButton);

}