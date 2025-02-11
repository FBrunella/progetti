
//MEMO FUNZIONAMENTO: oggetto user loggato -> local storange(stringa) = JSON.stringify -> getto user loggato(stringa) = JSON.parse -> mi prende i valori 
const URL = "https://www.themealdb.com/api/json/v1/1/search.php?";

window.onload = async function () {
    const user = localStorage.getItem("loginUser")
    console.log(JSON.parse(user))
    document.getElementById('profile').innerHTML = JSON.parse(user).name
    document.getElementById('cell').innerHTML = JSON.parse(user).cell
    document.getElementById('mail').innerHTML = JSON.parse(user).email
    document.getElementById('name').innerHTML = JSON.parse(user).name

    let allRecepies = JSON.parse(user).myRecepies;
    console.log(allRecepies)

    for(let i = 0; i < allRecepies.length; i++){

        let responce = await fetch(URL + "s=" + allRecepies[i]);
        let recepie = await responce.json();
        recepie = recepie.meals[0];

        let div1 = document.createElement("div");
        div1.classList.add("col-sm-4", "mb-3", "mb-sm-0", "mt-5");

        let div2 = document.createElement("div");
        div2.classList.add("card");
        div1.appendChild(div2);

        let div3 = document.createElement("div");
        div3.classList.add("card-body");
        div2.appendChild(div3);

        let img = document.createElement("img");
        img.setAttribute("src", recepie.strMealThumb)
        img.classList.add("card-img-top");
        div3.appendChild(img);

        let h5 = document.createElement("h5");
        h5.innerHTML = recepie.strMeal
        h5.classList.add("card-title", "mt-2");
        div3.appendChild(h5);

        let p = document.createElement("p");
        p.classList.add("card-text");
        p.innerHTML = recepie.strTags
        div3.appendChild(p);

        let a = document.createElement("a");
        a.innerHTML = "Vai al dettaglio";
        a.setAttribute("href", "../DetailRecipie/DetailRecipie.html?name=" + recepie.strMeal)
        a.classList.add("btn", "btn-primary");
        div3.appendChild(a);


        document.getElementById("allRecepies").appendChild(div1);
    }
};



function deleteUser() {
    let loginUser = JSON.parse(localStorage.getItem("loginUser"))
    let users = JSON.parse(localStorage.getItem("users") || "[]");
    let userToSave = [];
    users.forEach(userCheck => {
        let parse_userCheck = JSON.parse(userCheck)
        if (parse_userCheck.id !== loginUser.id) {
            userToSave.push(JSON.stringify(parse_userCheck))
        }
    });
    localStorage.setItem("users", JSON.stringify(userToSave))
    localStorage.setItem("loginUser", null);
    window.location.href = "C:/Users/Utente/Desktop/ricette/componets/Login/Login.html";
}

