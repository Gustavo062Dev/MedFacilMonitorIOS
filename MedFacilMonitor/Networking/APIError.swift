import Foundation
enum APIError: LocalizedError {
    case invalidURL, invalidResponse, httpStatus(Int), decoding, network(Error)
    var errorDescription: String? {
        switch self { case .invalidURL: return "A URL da API é inválida."; case .invalidResponse: return "A resposta da API é inválida."; case .httpStatus(let c): return "A API retornou o erro HTTP \(c)."; case .decoding: return "Não foi possível interpretar os dados da API."; case .network(let e): return e.localizedDescription }
    }
}
