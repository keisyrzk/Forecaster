//
//  WeatherCondition.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

enum WeatherCondition: Int, Sendable, Codable, CaseIterable {
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3

    case fog = 45
    case depositingRimeFog = 48

    case lightDrizzle = 51
    case moderateDrizzle = 53
    case denseDrizzle = 55
    case lightFreezingDrizzle = 56
    case denseFreezingDrizzle = 57

    case slightRain = 61
    case moderateRain = 63
    case heavyRain = 65
    case lightFreezingRain = 66
    case heavyFreezingRain = 67

    case slightSnowfall = 71
    case moderateSnowfall = 73
    case heavySnowfall = 75
    case snowGrains = 77

    case slightRainShowers = 80
    case moderateRainShowers = 81
    case violentRainShowers = 82

    case slightSnowShowers = 85
    case heavySnowShowers = 86

    case thunderstorm = 95
    case thunderstormWithSlightHail = 96
    case heavyThunderstorm = 97
    case thunderstormWithHeavyHail = 99
}

/// AI supported
extension WeatherCondition {
    var textIcon: String {
        switch self {
        case .clearSky, .mainlyClear:
            "sun.max.fill"

        case .partlyCloudy:
            "cloud.sun.fill"

        case .overcast:
            "cloud.fill"

        case .fog, .depositingRimeFog:
            "cloud.fog.fill"

        case .lightDrizzle, .moderateDrizzle, .denseDrizzle:
            "cloud.drizzle.fill"

        case .lightFreezingDrizzle, .denseFreezingDrizzle:
            "cloud.sleet.fill"

        case .slightRain, .moderateRain, .heavyRain, .slightRainShowers, .moderateRainShowers, .violentRainShowers:
            "cloud.rain.fill"

        case .lightFreezingRain, .heavyFreezingRain:
            "cloud.sleet.fill"

        case .slightSnowfall, .moderateSnowfall, .heavySnowfall, .snowGrains, .slightSnowShowers, .heavySnowShowers:
            "cloud.snow.fill"

        case .thunderstorm, .heavyThunderstorm:
            "cloud.bolt.rain.fill"

        case .thunderstormWithSlightHail, .thunderstormWithHeavyHail:
            "cloud.hail.fill"
        }
    }
    
    var forecastTitle: String {
        switch self {
        case .clearSky:
            "Clear sky"
            
        case .mainlyClear:
            "Mostly clear"
            
        case .partlyCloudy:
            "Partly cloudy"
            
        case .overcast:
            "Overcast"
            
        case .fog, .depositingRimeFog:
            "Fog"
            
        case .lightDrizzle, .moderateDrizzle, .denseDrizzle:
            "Drizzle"
            
        case .lightFreezingDrizzle, .denseFreezingDrizzle:
            "Freezing drizzle"
            
        case .slightRain, .moderateRain, .heavyRain:
            "Rain"
            
        case .lightFreezingRain, .heavyFreezingRain:
            "Freezing rain"
            
        case .slightSnowfall, .moderateSnowfall, .heavySnowfall, .snowGrains:
            "Snow"
            
        case .slightRainShowers, .moderateRainShowers, .violentRainShowers:
            "Rain showers"
            
        case .slightSnowShowers, .heavySnowShowers:
            "Snow showers"
            
        case .thunderstorm, .heavyThunderstorm:
            "Thunderstorm"
            
        case .thunderstormWithSlightHail, .thunderstormWithHeavyHail:
            "Thunderstorm with hail"
        }
    }
}

extension WeatherCondition {
    static func from(code: Int) -> WeatherCondition? {
        WeatherCondition(rawValue: code)
    }
}
