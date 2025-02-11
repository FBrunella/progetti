const URL = "https://www.themealdb.com/api/json/v1/1/search.php?";
const URLfilter = "https://www.themealdb.com/api/json/v1/1/filter.php?"

async function ricercaAPI() {
    let recepieName = document.getElementById("recepieName").value;
    let allRecepies = [];

    let responce = await fetch(URL + "s=" + recepieName);
    let recepies = await responce.json();
    if (recepies) {
        allRecepies = allRecepies.concat(recepies.meals);
    }

    responce = await fetch(URL + "f=" + Array.from(recepieName)[0]);
    recepies = await responce.json();
    if (recepies) {
        allRecepies = allRecepies.concat(recepies.meals);
    }

    console.log(allRecepies);

    allRecepies.map((recepie) => {
        console.log(recepie)
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
        a.setAttribute("href", "../DetailRecipie/DetailRecipie.html?name="+recepie.strMeal)
        a.classList.add("btn", "btn-primary");
        div3.appendChild(a);


        document.getElementById("allRecepies").appendChild(div1);
    })

}

function logout(){
    localStorage.setItem("loginUser", null);
    window.location.href = "C:/Users/Utente/Desktop/ricette/componets/Login/login.html";
}