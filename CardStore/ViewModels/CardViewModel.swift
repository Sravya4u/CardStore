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
    @Published var errorMessage: ErrorMessage? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(useMockData: Bool = false) {
        if useMockData {
            loadMockCards()
        } else {
            fetchCards()
        }
    }
    
    func fetchCards() {

        NetworkManager.shared.fetchCards()
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
    

}


