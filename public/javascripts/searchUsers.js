$(document).ready(function(){
    console.log("HELLO BITHC!!")
})


function searchUser(str) {
    let allRows=document.getElementsByClassName("tr")

    while( allRows[0] ) {
        allRows[0].parentNode.removeChild( allRows[0] );
    }
    if (str.length == 0) { 
        return;
    } else {
    
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                console.log("MEN NI WI MANMAN:"+this.responseText);
                arrayOfResults=JSON.parse(this.responseText);
                let table=document.getElementsByClassName("table-striped")[0]
                console.log(table)
                
              
                arrayOfResults.forEach((function(user){
                    let tr=document.createElement("tr");
                    tr.className="tr";
                    let td1=document.createElement("td");
                    let td2=document.createElement("td");
                    let td3=document.createElement("td");
                    td1.innerHTML=user.username; 
                    td2.innerHTML=user.email; 
                    td3.innerHTML=user.roles; 
                    tr.appendChild(td1);
                    tr.appendChild(td2);
                    tr.appendChild(td3);
                    // create action links 
                

                    
                    table.appendChild(tr);

                    
                }))
               
                // let results=this.responseText.split(", ")
                //  results.forEach(function(element){
                //    let tr=document.createElement('tr')
                //    tr.innerHTML=element 
                //    //let tbody=document.getElementById("table_tbody");
                //    table.append(tr);

                //    //table.append(tr) 
                // })
            }
        };
        url=`/admin/search/users/${str}`
        xmlhttp.open("GET",url, true);
        xmlhttp.send();
    }
}