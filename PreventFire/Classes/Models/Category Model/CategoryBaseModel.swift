import Foundation
struct CategoryBaseModel : Codable {
	let status : Int?
	let catinfo : [Catinfo]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case catinfo = "catinfo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		catinfo = try values.decodeIfPresent([Catinfo].self, forKey: .catinfo)
	}

}
