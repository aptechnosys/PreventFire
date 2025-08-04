import Foundation

struct SignUpBase: Codable {
    let message: SignUp?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(SignUp.self, forKey: .message)
    }
}

struct SignUp: Serializable {
    
    let access: String?
    let message: String?
    let user_id: Int?
    let google_map_key: String?
    
    enum CodingKeys: String, CodingKey {
        
        case access
        case message
        case user_id
        case google_map_key
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access = try values.decodeIfPresent(String.self, forKey: .access)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        google_map_key = try values.decodeIfPresent(String.self, forKey: .google_map_key)

    }
}
