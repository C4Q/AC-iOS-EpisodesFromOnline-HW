
struct Episode: Codable{
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let runtime: Int
    let image: ImageWrapper?
    let summary: String?
    
}

struct ImageWrapper: Codable{
    var medium: String?
    var original: String?
    
}
