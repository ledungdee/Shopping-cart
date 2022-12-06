var btn_quantity = document.querySelectorAll('.btn_quantity');
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