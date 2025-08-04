 import Foundation
struct CountryListBase: Codable {
	let name: String?
	let countrycode: String?
    let code: String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case countrycode = "dial_code"
        case code = "code"

	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		countrycode = try values.decodeIfPresent(String.self, forKey: .countrycode)
        code = try values.decodeIfPresent(String.self, forKey: .code)
	}

}
