import 'package:url_launcher/url_launcher.dart';

class MapsUtils
{
  MapsUtils._();

  //latitude longitude
  static Future<void> openMapWithPosition(double latitude, double longitude) async
  {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await canLaunchUrl(googleMapUrl as Uri))
    {
      await launchUrl(googleMapUrl as Uri);
    }
    else
    {
      throw "Could not open the map.";
    }
  }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async
  {
    String query = Uri.encodeComponent(fullAddress);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if(await canLaunch(googleMapUrl))
    {
      await launch(googleMapUrl);
    }
    else
    {
      throw "Could not open the map.";
    }
  }
}