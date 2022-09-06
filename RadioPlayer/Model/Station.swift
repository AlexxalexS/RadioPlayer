import Foundation

// MARK: - Station
struct Station: Codable {

    let changeuuid: String?
    let stationuuid: String?
    let name: String?
    let url: String?
    let urlResolved: String?
    let homepage: String?
    let favicon: String?
    let tags, country, countrycode: String?
    let state: String?
    let language, languagecodes: String?
    let votes: Int?
    let lastchangetime: String?
    let lastchangetimeIso8601: String?
    let codec: String?
    let bitrate, hls, lastcheckok: Int?
    let lastchecktime: String?
    let lastchecktimeIso8601: String?
    let lastcheckoktime: String?
    let lastcheckoktimeIso8601: String?
    let lastlocalchecktime: String?
    let clicktimestamp: String?
    let clicktimestampIso8601: String?
    let clickcount, clicktrend, sslError: Int?
    let geoLat, geoLong: Double?
    let hasExtendedInfo: Bool?

    static func defaultValue() -> Station {
        Station(
            changeuuid: "",
            stationuuid: "",
            name: "",
            url: "",
            urlResolved: "",
            homepage: "",
            favicon: "",
            tags: "",
            country: "",
            countrycode: "",
            state: "",
            language: "",
            languagecodes: "",
            votes: 0,
            lastchangetime: "",
            lastchangetimeIso8601: "",
            codec: "",
            bitrate: 0,
            hls: 0,
            lastcheckok: 0,
            lastchecktime: "",
            lastchecktimeIso8601: "",
            lastcheckoktime: "", lastcheckoktimeIso8601: "",
            lastlocalchecktime: "",
            clicktimestamp: "",
            clicktimestampIso8601: "",
            clickcount: 0,
            clicktrend: 0,
            sslError: 0,
            geoLat: 0,
            geoLong: 0,
            hasExtendedInfo: false
        )
    }

}
