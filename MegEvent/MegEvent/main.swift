/*import Foundation

// Model
struct Records: Codable {
    let records: [Schedule]?
}

struct Records_Speak: Codable {
    let records: [Speakers]?
}

struct Schedule: Codable, Hashable {
    let fields: Fields_Schedule

    func hash(into hasher: inout Hasher) {
        hasher.combine(fields.name)
        hasher.combine(fields.type)
        hasher.combine(fields.location)
        hasher.combine(fields.debut)
        hasher.combine(fields.fin)
    }

    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.fields.name == rhs.fields.name &&
            lhs.fields.type == rhs.fields.type &&
            lhs.fields.location == rhs.fields.location &&
            lhs.fields.debut == rhs.fields.debut &&
            lhs.fields.fin == rhs.fields.fin
    }
}

struct Speakers: Codable {
    let id: String
    let fields: Fields_Speakers
}

struct Fields_Schedule: Codable {
    let name: String
    let type: String!
    let location: String
    let debut: String
    let fin: String
    let speakers: [String]!
    let notes: String?
    enum CodingKeys: String, CodingKey {
        case name = "Activity"
        case type = "Type"
        case location = "Location"
        case debut = "Start"
        case fin = "End"
        case speakers = "Speaker(s)"
        case notes = "Notes"
    }
}

struct Fields_Speakers: Codable {
    let name: String
    let company: String
    let role: String
    let email: String
    let phone: String
    let viens: Bool
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case company = "Company"
        case role = "Role"
        case email = "Email"
        case phone = "Phone"
        case viens = "Confirmed?"
    }
}

enum RequestType: String {
    case get = "GET"
}

enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}


// Request Factory
protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params:
                       [String]?) -> URLRequest
    func getScheduleList(callback: @escaping ((errorType: CustomError?,
                                                errorMessage: String?), [Schedule]?) -> Void)
    func getSpeakersList(callback: @escaping ((errorType: CustomError?,
                                                errorMessage: String?), [Speakers]?) -> Void)
}

private let ScheduleUrl =
"https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule"

private let SpeakersUrl =
"https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers?maxRecords=3&view=All%20speakers"

class RequestFactory: RequestFactoryProtocol {
    internal func createRequest(urlStr: String, requestType: RequestType,
                                params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            print(urlParams)
            url = URL(string: urlParams)!
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        
        let accessToken = "keymaCPSexfxC2hF9"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization")
        return request
    }
    
    func getScheduleList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: ScheduleUrl, requestType: .get, params: nil)) {
            (data, response, error)
            in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?
                            JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError, error.debugDescription), nil)
            }
        }
        task.resume()
    }
    
    func getSpeakersList(callback: @escaping ((errorType: CustomError?,
                                               errorMessage: String?), [Speakers]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: SpeakersUrl, requestType: .get, params: nil)) {
            (data, response, error)
            in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?
                            JSONDecoder().decode(Records_Speak.self, from: data) {
                            callback((nil, nil), response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError,
                       error.debugDescription), nil)
            }
        }
        task.resume()
    }
}
//controller
/*let requestFactory = RequestFactory()
    
    requestFactory.getScheduleList { (errorHandle, furnitures) in
    if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
            print(errorMessage)
    }
    else if let list = furnitures{
        print(list[0].fields.speakers![1])
        
    }
    else {
        print("Houston we got a problem")
    }
}

    requestFactory.getSpeakersList { (errorHandle, furnituress) in
    if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
        print(errorMessage)
    }
    else if let lists = furnituress{
        print(lists[2].id)
    }
    else {
        print("Houston we got a problem")
    }
}*/
*/
