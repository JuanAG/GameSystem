var sliderPriceValue = document.getElementById("sliderPriceId");
var outputPrice = document.getElementById("priceValue");
outputPrice.innerHTML = sliderPriceValue.value;

sliderPriceValue.oninput = function() {
  outputPrice.innerHTML = this.value;
}