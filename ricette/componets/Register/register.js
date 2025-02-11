const validateEmail = (email) => {
    return String(email)
      .toLowerCase()
      .match(
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );
  };


function register(){
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const name = document.getElementById('name').value;
    const cell = document.getElementById('cell').value;
    const privacy = document.getElementById('privacy').checked;
    const sesso = document.getElementById('sesso').value;

    if(password && name && validateEmail(email) && String(cell).length === 10 && privacy && sesso !== 'S'){
        let users = JSON.parse(localStorage.getItem("users") || "[]");

        let id = 0;
        console.log(users, users.length)
        if(users.length > 0){
            id = JSON.parse(users[users.length - 1]).id + 1; 
        }

        let emailExists = users.some(user => JSON.parse(user).email === email);

        if (emailExists) {
            errorDiv.textContent = 'Registrazione non effettuata';
            return;
        }

        let user = {
            name: name,
            sex : sesso,
            email : email,
            password: password,
            cell: cell,
            myRecepies: [],
            myComments: [],
            id: id,
        };

        localStorage.setItem("loginUser", JSON.stringify(user))
        users.push(JSON.stringify(user))
        localStorage.setItem("users", JSON.stringify(users))
        
        window.location.href = "C:/Users/Utente/Desktop/ricette/componets/Home/Home.html";
    }else{
        alert('Registrazione non effettuata')
    }
}