// リスト 8.31:リファクタリング済みJavaScriptコード（PCとモバイルの両方でメニューをトグルする）
// メニュー操作
// トグルリスナーを追加する
function addToggleListener(selected_id, menu_id, toggle_class) {
  let selected_element = document.querySelector(`#${selected_id}`);
  selected_element.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector(`#${menu_id}`);
    menu.classList.toggle(toggle_class);
  });
}

// クリックをリッスンするトグルリスナーを追加する
document.addEventListener("turbo:load", function() {
  addToggleListener("hamburger", "navbar-menu",   "collapse");
  addToggleListener("account",   "dropdown-menu", "active");
});


// リスト 8.24:AccountメニューをトグルするJavaScriptコード
// メニュー操作
// トグルリスナーを追加してクリックをリッスンする
// document.addEventListener("turbo:load", function() {
//   // リスト 8.29:モバイルメニューをトグルするJavaScriptコード
//   let hamburger = document.querySelector("#hamburger");
//   if (hamburger){
//     hamburger.addEventListener("click", function(event) {
//       event.preventDefault();
//       let menu = document.querySelector("#navbar-menu");
//       menu.classList.toggle("collapse");
//     });
//   }

//   let account = document.querySelector("#account");
//   if (account) {
//     account.addEventListener("click", function(event) {
//       event.preventDefault();
//       let menu = document.querySelector("#dropdown-menu");
//       menu.classList.toggle("active");
//     });
//   }
// });
