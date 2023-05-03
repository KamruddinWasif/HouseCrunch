import Foundation

enum MortgageLoanType: String, CaseIterable, Identifiable {
    case fixedRate = "Fixed Rate"
    case adjustableRate = "Adjustable Rate"
    case interestOnly = "Interest Only"
    case balloon = "Balloon"

    var id: String { self.rawValue }
}

struct Mortgage {
    var loanAmount: Double
    var downPayment: Double
    var interestRate: Double
    var loanTerm: Int
    var loanType: MortgageLoanType
    var propertyTaxes: Double?
    var homeownersInsurance: Double?
    var homeownersAssociationFees: Double?

    var principal: Double {
        return loanAmount - downPayment
    }

    var monthlyInterestRate: Double {
        return interestRate / 100 / 12
    }

    var numberOfPayments: Int {
        return loanTerm * 12
    }

    func fixedRateMonthlyPayment() -> Double {
        let numerator = monthlyInterestRate * pow(1 + monthlyInterestRate, Double(numberOfPayments))
        let denominator = pow(1 + monthlyInterestRate, Double(numberOfPayments)) - 1
        return principal * (numerator / denominator)
    }

    func totalMonthlyPayment() -> Double {
        var payment = 0.0
        
        switch loanType {
        case .fixedRate:
            payment = fixedRateMonthlyPayment()
        case .adjustableRate, .interestOnly, .balloon:
            // Implement other mortgage types here
            break
        }
        
        if let taxes = propertyTaxes {
            payment += taxes / 12
        }
        
        if let insurance = homeownersInsurance {
            payment += insurance / 12
        }
        
        if let hoaFees = homeownersAssociationFees {
            payment += hoaFees / 12
        }
        
        return payment
    }
}
