function navAppearEvent() {
    var navigation = document.getElementById("navigation");
    navigation.style.display = "block";
}
function navDisappearEvent() {
    var navigation = document.getElementById("navigation");
    navigation.style.display = "none";    
}
function makeTeamArea() {
    if (teamId == null) {
        return;
    }
    for (var idx = 0; idx < teamId.length; idx++){
        var teamBox = document.createElement('div'); 
        teamBox.id = "teamBox" + idx;
        teamBox.className = "teamBox";  
        teamBox.onclick = (function(teamBoxId,teamBoxName) {
            return function() { goTeamPage(teamBoxId,teamBoxName); };
        })(teamId[idx],teamName[idx]);              
        document.getElementById("myTeamArea").appendChild(teamBox);

        var teamIdBox = document.createElement('div');
        teamIdBox.id = "teamIdBox" + idx;
        teamIdBox.className = "teamIdBox";
        document.getElementById("teamBox" + idx).appendChild(teamIdBox);
        document.getElementById("teamIdBox" + idx).innerText = teamId[idx];

        var teamNameBox = document.createElement('div');
        teamNameBox.id = "teamNameBox" + idx;
        teamNameBox.className = "teamNameBox";
        document.getElementById("teamBox" + idx).appendChild(teamNameBox);
        document.getElementById("teamNameBox" + idx).innerText = teamName[idx];
    }
}
function goTeamPage(id, name) {
    location.href = "mainPage.jsp?idValue="+id+"&nameValue="+name;
}