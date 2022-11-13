window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const SalesProfit = document.getElementById("profit");
    const TAX = 10
    function total(price, tax) {
      return Math.round(price * (tax / 100));
    }
    function difference(price, tax) {
      return Math.round(price - (price * (tax / 100)));
    }
    addTaxDom.innerHTML = (total(inputValue, TAX))
    SalesProfit.innerHTML = (difference(inputValue, TAX))
  })
});