function userAddChick(e){
    let userAddChick = document.querySelector('.userAddChick');
    if(e == 'add'){
        userAddChick.style.display = 'block';
    }else{
        userAddChick.style.display = 'none';
    }
}