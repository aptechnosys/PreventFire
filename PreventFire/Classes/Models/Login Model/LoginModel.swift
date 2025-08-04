import Foundation

struct LoginBase: Codable {
    let status: Int?
    let uid: String?
    let message: Login?
    
    enum CodingKeys: String, CodingKey {
        
        case status
        case uid
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        uid = try values.decodeIfPresent(String.self, forKey: .uid)
        message = try values.decodeIfPresent(Login.self, forKey: .message)
    }
}

struct Login: Codable {
    let created: String?
    let email: String?
    let language: String?
    let message: String?
    let mobile_no: String?
    let name: String?
    let photo: String?
    let uid: String?
    let user_status: String?
    let user_type: String?
    let username: String?
    let google_map_key: String?
    let firstname: String?
    let lastname: String?
    let countrycode: String?

    enum CodingKeys: String, CodingKey {
        
        case created
        case email
        case language
        case message
        case mobile_no
        case name
        case photo
        case uid
        case user_status
        case user_type
        case username
        case google_map_key
        case firstname
        case lastname
        case countrycode

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        uid = try values.decodeIfPresent(String.self, forKey: .uid)
        user_status = try values.decodeIfPresent(String.self, forKey: .user_status)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        google_map_key = try values.decodeIfPresent(String.self, forKey: .google_map_key)
        
        firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        countrycode = try values.decodeIfPresent(String.self, forKey: .countrycode)

    }
}
