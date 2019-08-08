
struct Show: Codable{
    let show: ShowInfo
}

struct ShowInfo: Codable{
    let id: Int
    let name: String
    let rating: RatingWrapper?
    let image: Image?
}

struct Image: Codable{
    let medium: String?
    let original: String?
}

struct RatingWrapper: Codable{
    let average: Double?
}
