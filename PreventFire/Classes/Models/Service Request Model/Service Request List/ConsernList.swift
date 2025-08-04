import Foundation
struct ConsernList: Codable {
	let status: Int?
	let concern: [Concern]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case concern = "concern"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		concern = try values.decodeIfPresent([Concern].self, forKey: .concern)
	}

}
