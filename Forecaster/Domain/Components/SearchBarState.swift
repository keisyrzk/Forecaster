enum SearchBarState: Equatable {
    case empty
    case valid(String)
    case invalid(String)

    var text: String {
        switch self {
        case .empty: ""
        case .valid(let text), .invalid(let text): text
        }
    }
}
