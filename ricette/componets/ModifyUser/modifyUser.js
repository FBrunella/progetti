const user = localStorage.getItem("loginUser")
console.log(JSON.parse(user))
document.getElementById('email').value = JSON.parse(user).email;
document.getElementById('password').value = JSON.parse(user).password;
document.getElementById('name').value = JSON.parse(user).name;
document.getElementById('cell').value = JSON.parse(user).cell;

const validateEmail = (email) => {
    return String(email)
      .toLowerCase()
      .match(
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );
  };

function modify(){
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const name = document.getElementById('name').value;
    const cell = document.getElementById('cell').value;
    const sesso = document.getElementById('sesso').value;
    const oldLoginUser = JSON.parse(localStorage.getItem("loginUser"))

    if(password && name && validateEmail(email) && String(cell).length === 10 && sesso !== 'S'){
        let user = {
            name: name,
            sex : sesso,
            email : email,
            password: password,
            cell: cell,
            myRecepies: oldLoginUser.myRecepies,
            myComments: oldLoginUser.myComments,
        };
        
        let users = JSON.parse(localStorage.getItem("users") || "[]");
        localStorage.setItem("loginUser", JSON.stringify(user))
        users = users.map(userForEach => {
            if(userForEach.id === user.id){
                userForEach.name = user.name;
                userForEach.sex = user.sex;
                userForEach.email = user.email;
                userForEach.password = user.password;
                userForEach.cell = user.cell;
            }
            return JSON.stringify(user);
        })
        localStorage.setItem("users", JSON.stringify(users))
        
        window.location.href = "C:/Users/Utente/Desktop/ricette/componets/User/user.html";
    }else{
        alert('Modifica non effettuata')
    }
}