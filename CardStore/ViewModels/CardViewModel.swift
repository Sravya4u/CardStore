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
                        self?.errorMessage = ErrorMessage(message: "Failed to load cards: \(error.localizedDescription)")
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
                    self?.errorMessage = ErrorMessage(message: "Failed to load cards: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (cards : [Card]) in
                self?.cards = cards
            })
            .store(in: &cancellables)
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


