//
//  CardGroupViewModel.swift
//  CardStore
//
//  Created by Sravya Chandrapati on 16/08/24.
//
import Foundation
import Combine

struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}
class CardViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var bookmarks: [Card] = []
    @Published var errorMessage: ErrorMessage? = nil
    @Published var isLoading : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkManager.shared,useMockData: Bool = false) {
        self.networkService = networkService
        if useMockData {
            loadMockCards()
        } else {
            fetchCards()
        }
    }
    
    func fetchCards() {
        isLoading = true
        networkService.fetchCards()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.isLoading = false
                        self?.handleError(error)
                    case .finished:
                        self?.isLoading = false
                        break
                    }
                }, receiveValue: { [weak self] (cards : [Card]) in
                    self?.isLoading = false
                    self?.cards = cards
                })
                .store(in: &cancellables)
    }
    
    func loadMockCards() {
 
        NetworkManager.shared.loadMockCards()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (cards : [Card]) in
                self?.cards = cards
            })
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
           let errorMessage: String
           switch error {
           case NetworkError.invalidURL:
               errorMessage = "The URL is invalid. Please try again."
           case NetworkError.fileNotFound:
               errorMessage = "The requested file could not be found."
           case DecodingError.decodingFailed:
               errorMessage = "Failed to decode the data. Please try again."
           default:
               errorMessage = "Failed to load cards: \(error.localizedDescription)"
           }
           self.errorMessage = ErrorMessage(message: errorMessage)
       }

    
    func toggleBookmark(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isBookmarked.toggle()
            
            if cards[index].isBookmarked {
                bookmarks.append(cards[index])
            } else {
                if let bookmarkIndex = bookmarks.firstIndex(where: { $0.id == card.id }) {
                    bookmarks.remove(at: bookmarkIndex)
                }
            }
        }
    }
    
    func groupedCards() -> [String: [Card]] {
        Dictionary(grouping: cards, by: { $0.creditCardType })
    }

}


