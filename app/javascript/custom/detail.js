var btn_quantity = $$('.btn_quantity');
var minus1 = btn_quantity[0];
var data1 = btn_quantity[1];
var add1 = btn_quantity[2];

minus1.onclick = () => {
    if (data1.value > 0) {
        data1.value--;
    }
}

add1.onclick = () => {
    data1.value++;
}

const item__sizes = $$('.item__size');
const product__remains = $$('.product__remain');
var product__remain = $('.remain__active');

item__sizes.forEach((value, index) => {
    value.onclick = () => {
        product__remains.forEach((v, i) => {
            v.classList.remove('remain__active');
        })
        product__remains[index + 1].classList.add('remain__active')
        product__remain = product__remains[index + 1]

        if (parseInt(data1.value) > parseInt(product__remain.textContent)) {
            data1.value = product__remain.textContent;
        }

        console.log(product__remain);
    }
})