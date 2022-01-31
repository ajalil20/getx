
class APIEndpoints{
  static const baseURL = "https://pawander-api.thewebtestlink.xyz";

  static const UserController = "users/";
  static const Authentication = "Authentication/";
  static const Home = "home/";
  static const Products = "products/";
  static const Shelters = "shelter/";
  static const Orders = "orders/";
  static const Breeds = "breeds/";
  static const Contents = "b_content/";


  static const String signupURL=Authentication+"register";
  static const String signinURL=Authentication+"login";
  static const String resetPassword=Authentication+"resetpassword";
  static const String updateprofileURL=UserController+"updateProfile";
  static const String petsData =Home+"getprofile";
  static const String allPetsData =Products+"getAllProfile";
  static const String userData =UserController+"getProfile";
  static const String recentPetView =Products+"recentProductView";
  static const String postFavourite =Products+"postFavourites";
  static const String shelterData =Shelters+"getAllProfile";
  static const String addPetData =Products+"postProfile";
  static const String adoptPet =Orders+"postProfile";
  static const String addRecentProduct =Products+"addRecentProductView";
  static const String getShelterPets =Products+"getShelterWiseProfile";
  static const String getFavorites =Products+"getFavouriteProducts";
  static const String getNearyByPets =Products+"nearByPets";
  static const String getRecentAddedPet =Products+"getProductsByVolunteer";
  static const String getBreeds = Home+"getBreedList";
  static const String getAllBreeds = Breeds+"getRegisteredBreeds";
  static const String getCharacteristicsList = Home+"getCharacteristicsList";
  static const String getPetCategoryList = Home+"getPetCategoryList";
  static const String getColor = Breeds+"getBreedColors?breed_id=61d420a950da4b307c594543";
  static const String updatePetPreferences = UserController+"updatePetPreferences";
  static const String getNearByShelters =Shelters+"nearByShelters";
  static const String getFavouriteShelters =Shelters+"getFavouriteShelters";
  static const String getMassiveShelters =Shelters+"getMassiveShelters";
  static const String filterPets =Products+"searchProfile";
  static const String getTermsCondition =Contents+"getTermsCondition";
  static const String getFaqList =Contents+"getFaqList";
  static const String getUserOrder =Orders+"getUserOrder";
  static const String searchPets =Products+ "getProducts?q=";
  static const String searchShelters =Shelters+ "getShelter?q=";
  static const String updateTermsConditions =UserController+ "updateTermsConditions";
  static const String deleteOrder =Orders+ "DeleteOrder?order_id=";
  static const String updateDeviceToken =UserController+ "updateDeviceToken";
  static const String getUserNotifications =UserController+ "getUserNotifications";
  static const String turnOffNotifications =UserController+ "logOutUser";
}
