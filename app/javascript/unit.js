function unit (){
  const FoodName  = document.getElementById("input-food");
  FoodName.addEventListener("change", () => {
    console.log(FoodName);
  });
}

window.addEventListener('load', unit);