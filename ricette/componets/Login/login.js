console.log(localStorage.getItem("users"))
console.log(localStorage.getItem("loginUser"))
function login(){
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    
    let users = JSON.parse(localStorage.getItem("users") || "[]");
    console.log(users)
    let trovato = false;
    let userTrovato = null;
    users.forEach(user => {
        let x = JSON.parse(user)
        if(x.email == email && x.password == password){
            trovato = true;
            userTrovato = x;
        }
    })

    if(trovato){
        localStorage.setItem("loginUser", JSON.stringify(userTrovato))
        window.location.href = "C:/Users/Utente/Desktop/ricette/componets/Home/Home.html";
    }else{
        alert("utente non trovato")
        console.error("utente non trovato")
    }
}