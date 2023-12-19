abstract class AppStates {}

class AppInitialStates extends AppStates{}

class AppChangeScreenState extends AppStates{}
class AppLoadingState extends AppStates{}

class AppLoadingHomeDataState extends AppStates{}
class AppSuccessHomeDataState extends AppStates{}

class AppChangeDropdown extends AppStates{}
class AppChangeRadioState extends AppStates{}
class AppChangeCheckBoxState extends AppStates{}

class AppPassportPickedErrorState extends AppStates{}
class AppPassportPickedSuccessState extends AppStates{}

class AppAddToCart extends AppStates{}
class AppLoadingGetCart extends AppStates{}
class AppSuccessGetCart extends AppStates{}
class AppRemoveFromCart extends AppStates{}

class AppSuccessGetOneProduct extends AppStates{}
class AppLoadingGetOneProduct extends AppStates{}
class AppErrorGetOneProduct extends AppStates{}

class AppGetUserLoadingState extends AppStates{}
class AppGetUserSuccessState extends AppStates{}
class AppGetUserErrorState extends AppStates{}

class AppLoadingOrderLicense extends AppStates{}
class AppSuccessOrderLicense extends AppStates{}
class AppErrorOrderLicense extends AppStates{}

class AppLoadingOrderTriptick extends AppStates{}
class AppSuccessOrderTriptick extends AppStates{}
class AppErrorOrderTriptick extends AppStates{}

class AppCouponLoadingState extends AppStates{}
class AppCouponDoneState extends AppStates{}
class AppCouponErrorState extends AppStates{}

class AppGetMyLicensesLoadingState extends AppStates{}
class AppGetMyLicensesDoneState extends AppStates{}
class AppGetMyLicensesErrorState extends AppStates{}