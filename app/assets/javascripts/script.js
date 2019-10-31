const addLocation = document.getElementById("addLocation");
const removeLocation = document.getElementById("removeLocation");

addLocation.addEventListener("click", (e) => {
  e.preventDefault();
  console.log("add!");
});

removeLocation.addEventListener("click", (e) => {
  e.preventDefault();
  console.log("remove!");
});
