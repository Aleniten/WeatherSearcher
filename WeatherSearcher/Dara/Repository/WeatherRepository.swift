//
//  WeatherRepository.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Alamofire

struct DefaultWeatherRepository {
    func create() {
        let request = AF.request("https://www.metaweather.com/api/location/search/?query=london")
        
        request.responseJSON(completionHandler: { (data) in
            print(data)
        })
    }
}

// THIS IS With search NAME LOCATION

//success(<__NSSingleObjectArrayI 0x600000f80800>(
//{
//    "latt_long" = "51.506321,-0.12714";
//    "location_type" = City;
//    title = London;
//    woeid = 44418;
//}
//)
//)


// THIS IS With WOETID
//success({
//    "consolidated_weather" =     (
//                {
//            "air_pressure" = 1025;
//            "applicable_date" = "2022-03-14";
//            created = "2022-03-14T15:59:03.450897Z";
//            humidity = 65;
//            id = 6438133605335040;
//            "max_temp" = "13.285";
//            "min_temp" = "5.305";
//            predictability = 73;
//            "the_temp" = "12.13";
//            visibility = "9.177341823749304";
//            "weather_state_abbr" = s;
//            "weather_state_name" = Showers;
//            "wind_direction" = "226.4491649436398";
//            "wind_direction_compass" = SW;
//            "wind_speed" = "5.18057334568785";
//        },
//                {
//            "air_pressure" = "1021.5";
//            "applicable_date" = "2022-03-15";
//            created = "2022-03-14T15:59:03.444357Z";
//            humidity = 63;
//            id = 5966528915701760;
//            "max_temp" = "14.695";
//            "min_temp" = "6.220000000000001";
//            predictability = 71;
//            "the_temp" = "14.035";
//            visibility = "11.19431271375169";
//            "weather_state_abbr" = hc;
//            "weather_state_name" = "Heavy Cloud";
//            "wind_direction" = "137.332753728081";
//            "wind_direction_compass" = SE;
//            "wind_speed" = "4.276485893130784";
//        },
//                {
//            "air_pressure" = 1017;
//            "applicable_date" = "2022-03-16";
//            created = "2022-03-14T15:59:03.461471Z";
//            humidity = 79;
//            id = 6269710086701056;
//            "max_temp" = "15.295";
//            "min_temp" = "8.629999999999999";
//            predictability = 75;
//            "the_temp" = "14.005";
//            visibility = "9.157768631193829";
//            "weather_state_abbr" = lr;
//            "weather_state_name" = "Light Rain";
//            "wind_direction" = "111.2372222191306";
//            "wind_direction_compass" = ESE;
//            "wind_speed" = "5.330977361677139";
//        },
//                {
//            "air_pressure" = 1032;
//            "applicable_date" = "2022-03-17";
//            created = "2022-03-14T15:59:03.044507Z";
//            humidity = 54;
//            id = 4725508014080000;
//            "max_temp" = "13.05";
//            "min_temp" = "5.05";
//            predictability = 71;
//            "the_temp" = "12.215";
//            visibility = "14.35305316949018";
//            "weather_state_abbr" = hc;
//            "weather_state_name" = "Heavy Cloud";
//            "wind_direction" = "321.112492479745";
//            "wind_direction_compass" = NW;
//            "wind_speed" = "5.403923895657361";
//        },
//                {
//            "air_pressure" = "1040.5";
//            "applicable_date" = "2022-03-18";
//            created = "2022-03-14T15:59:03.052970Z";
//            humidity = 55;
//            id = 6236113946542080;
//            "max_temp" = "14.23";
//            "min_temp" = "4.245";
//            predictability = 68;
//            "the_temp" = "13.14";
//            visibility = "14.2551872067128";
//            "weather_state_abbr" = c;
//            "weather_state_name" = Clear;
//            "wind_direction" = "72.93681505881996";
//            "wind_direction_compass" = ENE;
//            "wind_speed" = "7.645780120488349";
//        },
//                {
//            "air_pressure" = 1034;
//            "applicable_date" = "2022-03-19";
//            created = "2022-03-14T15:59:05.864039Z";
//            humidity = 57;
//            id = 6462030803369984;
//            "max_temp" = "11.43";
//            "min_temp" = "5.695";
//            predictability = 68;
//            "the_temp" = "10.58";
//            visibility = "9.999726596675416";
//            "weather_state_abbr" = c;
//            "weather_state_name" = Clear;
//            "wind_direction" = 75;
//            "wind_direction_compass" = ENE;
//            "wind_speed" = "7.509799172830669";
//        }
//    );
//    "latt_long" = "51.506321,-0.12714";
//    "location_type" = City;
//    parent =     {
//        "latt_long" = "52.883560,-1.974060";
//        "location_type" = "Region / State / Province";
//        title = England;
//        woeid = 24554868;
//    };
//    sources =     (
//                {
//            "crawl_rate" = 360;
//            slug = bbc;
//            title = BBC;
//            url = "http://www.bbc.co.uk/weather/";
//        },
//                {
//            "crawl_rate" = 480;
//            slug = "forecast-io";
//            title = "Forecast.io";
//            url = "http://forecast.io/";
//        },
//                {
//            "crawl_rate" = 360;
//            slug = hamweather;
//            title = HAMweather;
//            url = "http://www.hamweather.com/";
//        },
//                {
//            "crawl_rate" = 180;
//            slug = "met-office";
//            title = "Met Office";
//            url = "http://www.metoffice.gov.uk/";
//        },
//                {
//            "crawl_rate" = 360;
//            slug = openweathermap;
//            title = OpenWeatherMap;
//            url = "http://openweathermap.org/";
//        },
//                {
//            "crawl_rate" = 720;
//            slug = wunderground;
//            title = "Weather Underground";
//            url = "https://www.wunderground.com/?apiref=fc30dc3cd224e19b";
//        },
//                {
//            "crawl_rate" = 360;
//            slug = "world-weather-online";
//            title = "World Weather Online";
//            url = "http://www.worldweatheronline.com/";
//        }
//    );
//    "sun_rise" = "2022-03-14T06:17:06.136380Z";
//    "sun_set" = "2022-03-14T18:03:16.579633Z";
//    time = "2022-03-14T16:51:46.229465Z";
//    timezone = "Europe/London";
//    "timezone_name" = LMT;
//    title = London;
//    woeid = 44418;
//})
