class ApiConstant {
  static const baseURL = "https://techblog.sasansafari.com/Techblog/api/";
  static const baseHostImageURL = "https://techblog.sasansafari.com";
  static const getHomeItems = "${baseURL}home/?command=index";
  static const getArticleList = "${baseURL}article/get.php?command=new&user_id=";
  static const postRegister = "${baseURL}register/action.php";
  static const postArticle = "${baseURL}article/post.php";
}