
function fillModal(element,state){
    console.log(state)
    let userId=element.dataset.id; 
    let userUsername=element.dataset.username;
    let userEmail=element.dataset.email; 
    let userRoles=element.dataset.roles;

    let modalUserId=document.getElementById("modalUserId");
    let modalUsername=document.getElementById("modalUsername");
    let modalEmail=document.getElementById("modalEmail");
    let modalRoles=document.getElementById("modalRoles");
    let modalSubmit=document.getElementById("modalSubmit");
    let modalSave=document.getElementById("modalSave");
 
        
    if(state==="view"){
        modalSubmit.style.display="none";
        modalSave.style.display="none";

        modalUsername.readOnly=true;
        modalEmail.readOnly=true;
        modalRoles.readOnly=true;

        document.getElementById("modalTitle").innerHTML=""

    }else if(state==="edit"){

        document.getElementById("modalTitle").innerHTML="Edit The User"
        modalUsername.readOnly=false;
        modalEmail.readOnly=false;
        modalRoles.readOnly=false;
        modalSubmit.style.display="none";
        modalSave.style.display="inline-block";
        
    }

    modalUserId.value=userId;
    modalUsername.value=userUsername; 
    modalEmail.value=userEmail;
    modalRoles.value=userRoles;

    console.log(userId,userUsername,userEmail,userRoles);


}

function saveUser(){
    let modalUserId=document.getElementById("modalUserId").value;
    let modalUsername=document.getElementById("modalUsername").value;
    let modalEmail=document.getElementById("modalEmail").value;
    let modalRoles=document.getElementById("modalRoles").value;

    let xmlHttpRequest=new XMLHttpRequest();
    // xmlHttpRequest.onreadystatechange = function() {
    //     if (this.readyState == 4 && this.status == 200) {
    //         console.log(this.responseText)
    //     }
    // }

    xmlHttpRequest.open("PATCH",`/admin/users/${modalUserId}`, true);
    xmlHttpRequest.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xmlHttpRequest.setRequestHeader('Content-Type', 'application/json');
    xmlHttpRequest.send(JSON.stringify({username:modalUsername,email:modalEmail,roles:modalRoles}));


}