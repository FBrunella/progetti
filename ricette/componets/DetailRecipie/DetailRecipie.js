const URL = "https://www.themealdb.com/api/json/v1/1/search.php?";

const getParam = window.location.href.split('=')[1].replaceAll("%20", " ");

async function getRicetta() {
    let responce = await fetch(URL + "s=" + getParam);
    let recepie = await responce.json();
    if(recepie && recepie.meals){
        recepie = recepie.meals[0]
    }

    document.getElementById("name").innerHTML = recepie.strMeal;
    document.getElementById("category").innerHTML = recepie.strCategory;
    document.getElementById("myimg").setAttribute("src", recepie.strMealThumb);
    document.getElementById("preparation").innerHTML = recepie.strInstructions
    
    let mylist = document.getElementById("list");
    if(recepie.strIngredient1 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient1 + " " + recepie.strMeasure1
        mylist.appendChild(x);
    }
    if(recepie.strIngredient2 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient2 + " " + recepie.strMeasure2
        mylist.appendChild(x);
    }
    if(recepie.strIngredient3 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient3 + " " + recepie.strMeasure3
        mylist.appendChild(x);
    }

    if(recepie.strIngredient4 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient4 + " " + recepie.strMeasure4
        mylist.appendChild(x);
    }

    if(recepie.strIngredient5 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient5 + " " + recepie.strMeasure5
        mylist.appendChild(x);
    }
    if(recepie.strIngredient6 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient6 + " " + recepie.strMeasure6
        mylist.appendChild(x);
    }
    if(recepie.strIngredient7 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient7 + " " + recepie.strMeasure7
        mylist.appendChild(x);
    }
    if(recepie.strIngredient8 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient8 + " " + recepie.strMeasure8
        mylist.appendChild(x);
    }
    if(recepie.strIngredient9 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient9 + " " + recepie.strMeasure9
        mylist.appendChild(x);
    }

    if(recepie.strIngredient10 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient10 + " " + recepie.strMeasure10
        mylist.appendChild(x);
    }
    if(recepie.strIngredient11 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient11 + " " + recepie.strMeasure11
        mylist.appendChild(x);
    }
    if(recepie.strIngredient12 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient12 + " " + recepie.strMeasure12
        mylist.appendChild(x);
    }

    if(recepie.strIngredient13 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient13 + " " + recepie.strMeasure13
        mylist.appendChild(x);
    }
    if(recepie.strIngredient14 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient14 + " " + recepie.strMeasure14
        mylist.appendChild(x);
    }
    if(recepie.strIngredient15 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient15 + " " + recepie.strMeasure15
        mylist.appendChild(x);
    }
    if(recepie.strIngredient16 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient16 + " " + recepie.strMeasure16
        mylist.appendChild(x);
    }

    if(recepie.strIngredient17 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient17 + " " + recepie.strMeasure17
        mylist.appendChild(x);
    }
    if(recepie.strIngredient18 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient18 + " " + recepie.strMeasure18
        mylist.appendChild(x);
    }
    if(recepie.strIngredient19 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient19 + " " + recepie.strMeasure19
        mylist.appendChild(x);
    }
    if(recepie.strIngredient20 != ""){
        let x = document.createElement("li");
        x.innerHTML = recepie.strIngredient20 + " " + recepie.strMeasure20
        mylist.appendChild(x);
    }
}

function aggiungiRicettario(){
    const user = JSON.parse(localStorage.getItem("loginUser"));
    if(!user.myRecepies.includes(getParam))
        user.myRecepies.push(getParam);
    localStorage.setItem("loginUser", JSON.stringify(user));

    let users = JSON.parse(localStorage.getItem("users") || "[]");
    users = users.map(userForEach => {
        userForEach = JSON.parse(userForEach);
        if(userForEach.id === user.id){
            userForEach.myRecepies = user.myRecepies;
        }
        return JSON.stringify(userForEach);
    })
    localStorage.setItem("users", JSON.stringify(users))

    console.log(JSON.parse(localStorage.getItem("loginUser")), JSON.parse(localStorage.getItem("users")));
    window.location.href = "C:/Users/Utente/Desktop/ricette/componets/User/User.html";
}

function pubblicaCommento(){
    let title = document.getElementById("titolo").value;
    let rating = document.getElementById("rating").value;
    let note = document.getElementById("note").value;

    if(title === "" || note === "" || rating == "" || rating < 0 || rating > 5)
        alert("Recensione non inserite, mancano dei campi")
    else{
        const user = JSON.parse(localStorage.getItem("loginUser"));
        let allUser = JSON.parse(localStorage.getItem("users"));
        user.myComments.push({"recepie": getParam, title, rating, note, user: user.name})
        console.log(user);
        
        allUser = allUser.map(singleUser => {
            let singleUserJson = JSON.parse(singleUser);
            if(singleUserJson.id === user.id){
                singleUserJson.myComments = user.myComments
            }
            return JSON.stringify(singleUserJson);
        })

        console.log(allUser);
        localStorage.setItem("users", JSON.stringify(allUser))
        localStorage.setItem("loginUser", JSON.stringify(user))

        location.reload();
    }
    
}

let recepieName = getParam;
let allReview = [];
const allUser = JSON.parse(localStorage.getItem("users"));
allUser.forEach((user) => {
    const userJsonComments = JSON.parse(user).myComments;
    userJsonComments.forEach(comment => {
        if(comment.recepie === recepieName){
            allReview.push(comment)
        }
    })
    
})
console.log(allReview)


allReview.forEach((review) => {
    let div1 = document.createElement("div");
    div1.classList.add("col-sm-4", "mb-3", "mb-sm-0", "mt-5");

    let div2 = document.createElement("div");
    div2.classList.add("card");
    div1.appendChild(div2);

    let div3 = document.createElement("div");
    div3.classList.add("card-body");
    div2.appendChild(div3);

    let h5 = document.createElement("h5");
    h5.innerHTML = review.title
    h5.classList.add("card-title", "mt-2");
    div3.appendChild(h5);

    let h6 = document.createElement("h6");
    h6.innerHTML = "voto:" + review.rating + "/5"
    h6.classList.add("card-title", "mt-2");
    div3.appendChild(h6);

    let p = document.createElement("p");
    p.classList.add("card-text");
    p.innerHTML = review.note
    div3.appendChild(p);

    let by = document.createElement("p");
    by.classList.add("card-text", "mt-3");
    by.innerHTML = "writed by: " + review.user
    div3.appendChild(by);


    document.getElementById("allReview").appendChild(div1);
})