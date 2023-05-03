import SwiftUI
import Combine

class MortgageViewModel: ObservableObject {
    @Published var loanAmount: String = ""
    @Published var downPayment: String = ""
    @Published var downPaymentAsPercentage: Bool = true
    @Published var interestRate: String = ""
    @Published var loanTerm: Int = 15
    @Published var loanType: MortgageLoanType = .fixedRate
    @Published var propertyTaxes: String = ""
    @Published var homeownersInsurance: String = ""
    @Published var homeownersAssociationFees: String = ""
    @Published var includeTaxes: Bool = false
    @Published var includeInsurance: Bool = false
    @Published var includeHOAFees: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $loanAmount
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellableSet)
        
        $downPayment
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellableSet)
        
        $interestRate
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellableSet)
    }
    
    var totalMonthlyPayment: Double {
        let loanAmountValue = Double(loanAmount) ?? 0
        let downPaymentValue = downPaymentAsPercentage ? (loanAmountValue * (Double(downPayment) ?? 0) / 100) : Double(downPayment) ?? 0
        let interestRateValue = Double(interestRate) ?? 0
        let propertyTaxesValue = includeTaxes ? Double(propertyTaxes) : nil
        let homeownersInsuranceValue = includeInsurance ? Double(homeownersInsurance) : nil
        let homeownersAssociationFeesValue = includeHOAFees ? Double(homeownersAssociationFees) : nil
        
        let mortgage = Mortgage(loanAmount: loanAmountValue, downPayment: downPaymentValue, interestRate: interestRateValue, loanTerm: loanTerm, loanType: loanType, propertyTaxes: propertyTaxesValue, homeownersInsurance: homeownersInsuranceValue, homeownersAssociationFees: homeownersAssociationFeesValue)
        
        return mortgage.totalMonthlyPayment()
    }
}
