import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper
{
  static SharedPreferences? sharedPref ;
  static init() async
  {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
  {
    required var key ,
    required var value,
}
      ) async
  {


    if(value is String)
    {
      return await sharedPref!.setString(key, value);
    }
    else if(value is double)
    {
      return await sharedPref!.setDouble(key, value);
    }
    else{
      return await sharedPref!.setBool(key, value);
    }




  }



  static dynamic getData(
  {
    required String key,
  }
      )
  {
    return sharedPref!.get(key);
  }

  static Future<bool>logout({
    required key ,
})
  {
    return sharedPref!.remove(key);

  }




}