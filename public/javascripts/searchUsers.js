$(document).ready(function(){
    
})


function searchUsers(str,who) {
    alert(who)
    let allRows=document.getElementsByClassName("tr")
    var xmlhttp = new XMLHttpRequest();
    while( allRows[0] ) {
        allRows[0].parentNode.removeChild( allRows[0] );
    }
   
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                console.log("MEN NI WI MANMAN:"+this.responseText);
                arrayOfResults=JSON.parse(this.responseText);
                let table=document.getElementById("searchResults")
                console.log(table)
                
                
                

                arrayOfResults.forEach((function(user){
                    let tr=document.createElement("tr");
                    tr.className="tr";
                    let td1=document.createElement("td");
                    let td2=document.createElement("td");
                    let td3=document.createElement("td");
                    let td4=document.createElement("td");
                    let td5=document.createElement("td");
                    let td6=document.createElement("td");
                    let td7=document.createElement("td");
                    
                    let viewLink=document.createElement("a")
                    viewLink.href=`#`
                    viewLink.innerText="View"
                    viewLink.className="btn btn-success";
                    viewLink.setAttribute("data-username",`${user.username}`);
                    viewLink.setAttribute("data-id",`${user.id}`);
                    viewLink.setAttribute("data-email",`${user.email}`);
                    viewLink.setAttribute("data-roles",`${user.roles}`)
                    viewLink.setAttribute("onclick","fillModal(this,'view')");
                    viewLink.setAttribute("data-toggle","modal");
                    viewLink.setAttribute("data-target","#exampleModalCenter");
                    
                    //data-id="<%= user.id %>" data-username="<%= user.username %>" data-email="<%= user.email%>" data-roles="<%= user.roles.collect{|role| role.label}.join(",") %>" onClick="fillModal(this,'view')" data-toggle="modal" data-target="#exampleModalCenter"

                    let editLink=document.createElement("a")
                    editLink.href=`#`
                    editLink.innerText="Edit"
                    editLink.className="btn btn-secondary"

                    editLink.setAttribute("data-username",`${user.username}`);
                    editLink.setAttribute("data-id",`${user.id}`);
                    editLink.setAttribute("data-email",`${user.email}`);
                    editLink.setAttribute("data-roles",`${user.roles}`)
                    editLink.setAttribute("onclick","fillModal(this,'edit')");
                    editLink.setAttribute("data-toggle","modal");
                    editLink.setAttribute("data-target","#exampleModalCenter");

                    let deleteLink=document.createElement("a")
                    deleteLink.href=`#`
                    deleteLink.innerText="Delete"
                    deleteLink.className="btn btn-danger"

                    deleteLink.setAttribute("data-username",`${user.username}`);
                    deleteLink.setAttribute("data-id",`${user.id}`);
                    deleteLink.setAttribute("data-email",`${user.email}`);
                    deleteLink.setAttribute("data-roles",`${user.roles}`)
                    deleteLink.setAttribute("onclick","fillModal(this,'delete')");
                    deleteLink.setAttribute("data-toggle","modal");
                    deleteLink.setAttribute("data-target","#exampleModalCenter");

                    td1.innerHTML=user.username; 
                    td2.innerHTML=user.email; 
                    td3.innerHTML=user.roles;
                    td4.appendChild(viewLink)
                    td5.appendChild(editLink)
                    td6.appendChild(deleteLink)
                    td7.innerHTML=user.id;
                    
                    tr.appendChild(td7);
                    tr.appendChild(td1);
                    tr.appendChild(td2);
                    tr.appendChild(td3);
                    tr.appendChild(td4);
                    tr.appendChild(td5);
                    tr.appendChild(td6);

                    
                    table.appendChild(tr);

                    
                }))

                table.className="table table-striped table-sm"
            }
        };

        if (str.length<=0){
            str="all"
        }
    
     let url=`/admin/search/users/${str}`
    xmlhttp.open("GET",url, true);
    xmlhttp.send();
}


