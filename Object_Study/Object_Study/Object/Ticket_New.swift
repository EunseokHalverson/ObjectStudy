import Foundation

public class Invitation {
    private var when: Date
    
    init(date: Date) {
        self.when = date
    }
}

public class Ticket{
    private var fee: Int
    
    init(fee: Int) {
        self.fee = fee
    }
    
    public func getFee() -> Int {
        return fee
    }
}

public class Bag {
    private var amount: Int
    private var invitation: Invitation?
    private var ticket: Ticket?
    
    init(amount: Int) {
        self.amount = amount
        self.invitation = nil
    }
    
    init(amount: Int, invitation: Invitation?, ticket: Ticket?) {
        self.amount = amount
        self.invitation = invitation
        self.ticket = ticket
    }
    
    public func hold(ticket: Ticket) -> Int {
        if hasInvitation() {
            setTicket(ticket: ticket)
            return 0
        } else {
            miniusAmount(amount: ticket.getFee())
            setTicket(ticket: ticket)
            return ticket.getFee()
        }
    }
    
    public func hasInvitation() -> Bool {
        return invitation != nil
    }
    
    public func hasTicket() -> Bool {
        return ticket != nil
    }
 
    public func setTicket(ticket: Ticket) {
        self.ticket = ticket
    }
    
    public func miniusAmount(amount: Int) {
        self.amount -= amount
    }
    
    public func plusAmount(amount: Int) {
        self.amount += amount
    }
}

public class Audience {
    private var bag: Bag
    
    init(bag: Bag) {
        self.bag = bag
    }
    
    public func buy(ticket: Ticket) -> Int {
        if bag.hasInvitation() {
            bag.setTicket(ticket: ticket)
            return 0
        } else {
            bag.setTicket(ticket: ticket)
            bag.miniusAmount(amount: ticket.getFee())
            return ticket.getFee()
        }
    }
}

public class TicketOffice {
    private var amount: Int
    private var tickets: [Ticket] = []
    
    init(amount: Int, tickets: Ticket) {
        self.amount = amount
        self.tickets.append(tickets)
    }
    
    public func sellTicketTo(audience: Audience) {
        plusAmount(amount: audience.buy(ticket: getTicket()))
    }
    
    public func getTicket() -> Ticket {
        return tickets.remove(at: 0)
    }
    
    public func plusAmount(amount: Int) {
        self.amount += amount
    }
}

public class TicketSeller {
    private var ticketOffice: TicketOffice
    
    init(ticketOffice: TicketOffice) {
        self.ticketOffice = ticketOffice
    }
    
    public func sellTo(audience: Audience) {
        ticketOffice.sellTicketTo(audience: audience)
    }
}

public class Theater {
    private var ticketSeller: TicketSeller
    
    init(ticketSeller: TicketSeller) {
        self.ticketSeller = ticketSeller
    }
    
    public func enter(audience: Audience) {
        ticketSeller.sellTo(audience: audience)
    }
}
