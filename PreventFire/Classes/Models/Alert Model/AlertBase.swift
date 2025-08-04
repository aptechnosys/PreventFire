import Foundation

struct AlertBase: Codable {
	let status: Int?
	let concern: [AlertConcern]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case concern = "concern"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		concern = try values.decodeIfPresent([AlertConcern].self, forKey: .concern)
	}

}
