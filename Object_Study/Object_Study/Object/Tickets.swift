//import Foundation
//
//public class Invitation {
//    private var when: Date
//    
//    init(date: Date) {
//        self.when = date
//    }
//}
//
//public class Ticket{
//    private var fee: Int
//    
//    init(fee: Int) {
//        self.fee = fee
//    }
//    
//    public func getFee() -> Int {
//        return fee
//    }
//}
//
//public class Bag {
//    private var amount: Int
//    private var invitation: Invitation?
//    private var ticket: Ticket?
//    
//    init(amount: Int) {
//        self.amount = amount
//        self.invitation = nil
//    }
//    
//    init(amount: Int, invitation: Invitation?, ticket: Ticket?) {
//        self.amount = amount
//        self.invitation = invitation
//        self.ticket = ticket
//    }
//    
//    public func hasInvitation() -> Bool {
//        return invitation != nil
//    }
//    
//    public func hasTicket() -> Bool {
//        return ticket != nil
//    }
// 
//    public func setTicket(ticket: Ticket) {
//        self.ticket = ticket
//    }
//    
//    public func miniusAmount(amount: Int) {
//        self.amount -= amount
//    }
//    
//    public func plusAmount(amount: Int) {
//        self.amount += amount
//    }
//}
//
//public class Audience {
//    private var bag: Bag
//    
//    init(bag: Bag) {
//        self.bag = bag
//    }
//    
//    public func getBag() -> Bag {
//        return bag
//    }
//}
//
//public class TicketOffice {
//    private var amount: Int
//    private var tickets: [Ticket] = []
//    
//    init(amount: Int, tickets: Ticket) {
//        self.amount = amount
//        self.tickets.append(tickets)
//    }
//    
//    public func getTicket() -> Ticket {
//        return tickets.remove(at: 0)
//    }
//    
//    public func minusAmount(amount: Int) {
//        self.amount -= amount
//    }
//    
//    public func plusAmount(amount: Int) {
//        self.amount += amount
//    }
//}
//
//public class TicketSeller {
//    private var ticketOffice: TicketOffice
//    
//    init(ticketOffice: TicketOffice) {
//        self.ticketOffice = ticketOffice
//    }
//    
//    public func getTicketOffice() -> TicketOffice {
//        return ticketOffice
//    }
//}
//
//public class Theater {
//    private var ticketSeller: TicketSeller
//    
//    init(ticketSeller: TicketSeller) {
//        self.ticketSeller = ticketSeller
//    }
//    
//    public func enter(audience: Audience) {
//        if audience.getBag().hasInvitation() {
//            let ticket = ticketSeller.getTicketOffice().getTicket()
//            audience.getBag().setTicket(ticket: ticket)
//        } else {
//            let ticket = ticketSeller.getTicketOffice().getTicket()
//            audience.getBag().miniusAmount(amount: ticket.getFee())
//            ticketSeller.getTicketOffice().plusAmount(amount: ticket.getFee())
//            audience.getBag().setTicket(ticket: ticket)
//        }
//    }
//}
