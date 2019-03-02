
function fillModal(element,state){
    console.log(state)
    let userId=element.dataset.id; 
    let userUsername=element.dataset.username;
    let userEmail=element.dataset.email; 
    let userRoles=element.dataset.roles;

    let modalUsername=document.getElementById("modalUsername");
    let modalEmail=document.getElementById("modalEmail");
    let modalRoles=document.getElementById("modalRoles");

    if(state==="view"){
        document.getElementById("modalSubmit").style.display="none";
        document.getElementById("modalSave").style.display="none";

        

    }else if(state==="edit"){
        document.getElementById("modalSubmit").style.display="inline-block";
        document.getElementById("modalSave").style.display="inline-block";
    }

    modalUsername.value=userUsername; 
    modalEmail.value=userEmail;
    modalRoles.value=userRoles;
    
    console.log(userId,userUsername,userEmail,userRoles);


}