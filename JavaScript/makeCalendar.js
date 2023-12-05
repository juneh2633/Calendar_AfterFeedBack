function makeDateBoxEvent(month) {
    var day = 0;
    if (month == '2') {
        day = 28;
    }
    if (month == '1'||month == '3'||month == '5'||month == '7'||month == '8'||month == '10'||month == '12') {
        day = 31;
    }
    if (month == '4'||month == '6'||month == '9'||month == '11') {
        day = 30;
    }
    var check = document.getElementById("saveCheck");
    if (check.value == '1') {
        for (var idx = 1; idx <= 35; idx++){
            var dateBox = document.getElementById("dateBox" + idx);
            dateBox.remove();
        }
    }
    for (var idx = 1; idx <= 35; idx++){
        var dateBox = document.createElement('div'); 
        dateBox.id = "dateBox" + idx;
        dateBox.className = "dateBox";
        if (day >= idx) {
            dateBox.onclick = (function(index,month) {
                return function() { modalOpen(index,month); };
            })(idx,month);           
        }
        document.getElementById("calendarBox").appendChild(dateBox);
        var todayBox = document.createElement('div');
        todayBox.id = "todayBox" + idx;
        todayBox.className = "todayBox";
        if (day < idx) {
            continue;
        }
        todayBox.innerHTML = idx;
        document.getElementById("dateBox" + idx).appendChild(todayBox);
        var scheduleCountBox = document.createElement('div'); 
        scheduleCountBox.id = "scheduleCountBox" + idx;
        scheduleCountBox.className = "scheduleCountBox";
        document.getElementById("todayBox" + idx).appendChild(scheduleCountBox);
        scheduleCountInput(idx,month)
    }
    check.setAttribute('value', '1');
    var monthArea = document.getElementById("monthArea");
    monthArea.innerText = month + "월";
}
function yearUpEvent() {
    pageYear = parseInt(pageYear) + 1;
    var yearArea = document.getElementById("yearArea");
    var year = yearArea.innerHTML.slice(0, -1);
    yearArea.innerText = parseInt(year) + 1 + "년";  
    makeDateBoxEvent(1);
}
function yearDownEvent() {
    pageYear = parseInt(pageYear) - 1;
    var yearArea = document.getElementById("yearArea");
    var year = yearArea.innerHTML.slice(0, -1);
    yearArea.innerText = parseInt(year) - 1 + "년";    
    makeDateBoxEvent(1);
}
function scheduleCountInput(idx,month) {
    var scheduleList= scheduleTreeJson[dateToString(idx,month)];
    if (scheduleList == null) {
        return;
    }
    var scheduleCount = scheduleList.length;
    if (scheduleCount >= 10) {
        scheduleCount = '9+';
    }
    document.getElementById("scheduleCountBox" + idx).innerHTML = scheduleCount;
}
function modalOpen(idx,month) {
    modalAppearEvent(idx,month);
    console.log("모달창 달 확인", month);
}
function dateToString(day,month) {
    var dayString = day;
    if (day < 10) {
        dayString = '0' + day;
    }
    var s = pageYear + "-" + month + "-" + dayString; 
    return s;
}