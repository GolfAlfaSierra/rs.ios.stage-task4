import Foundation

final class CallStation {
    private var _usersConnected = Set<User>()
    private var _callHistory = [Call]()
}


extension CallStation: Station {
    func users() -> [User] {
        return _usersConnected.shuffled()
    }
    /// stationAddUser
    func add(user: User) {
        _usersConnected.insert(user)
    }
    /// stationRemoveUser
    func remove(user: User) {
        _usersConnected.remove(user)
    }
    
    /// execute Call
    func execute(action: CallAction) -> CallID? {
        
        
        switch action {
        
        case .start(from: let caller, to: let receiver):
            var call: Call
            
            if !_usersConnected.contains(caller) {
                return nil
                
            }
            
            if !_usersConnected.contains(receiver) {
                call = Call(id: UUID(), incomingUser: receiver, outgoingUser: caller,
                            status: .ended(reason: .error))
                addCall(call)
                return call.id
            }
            
            
            
            if currentCall(user: receiver) != nil || currentCall(user: caller) != nil {
                call = Call(id: UUID(), incomingUser: receiver, outgoingUser: caller,
                            status: .ended(reason: .userBusy))
                
                addCall(call)
                return call.id
            }
            
            
            
            call = Call(id: UUID(), incomingUser: receiver, outgoingUser: caller,
                        status: .calling)
            
            addCall(call)
            return call.id
            
            
            
            
            
            
        case .answer(from: let caller):
            guard let currentCall = currentCall(user: caller) else {return nil}
            
            if !users().contains(caller) {
               
                renewCallStatus(call: currentCall, with: .ended(reason: .error))
                return nil
            }
            
            renewCallStatus(call: currentCall, with: .talk)
            
            return currentCall.id
            
        case .end(from: let caller):
            guard let currentCall = currentCall(user: caller) else {return nil}
            if currentCall.status == .calling {
                
                renewCallStatus(call: currentCall, with: .ended(reason: .cancel))
                
            } else {

                renewCallStatus(call: currentCall, with: .ended(reason: .end))
            }
            
            
            
            return currentCall.id
        }
    }
    
    /// getStationCalls
    func calls() -> [Call] {
        return _callHistory
    }
    
    
    /// Call service
    
    /// getCallsOfUser
    func calls(user: User) -> [Call] {
        return _callHistory.filter {$0.incomingUser.id == user.id || $0.outgoingUser.id == user.id}
    }
    
    /// getCallById
    func call(id: CallID) -> Call? {
        return _callHistory.first(where: {$0.id == id})
        
    }
    /// return call user call .calling
    func currentCall(user: User) -> Call? {
        return _callHistory.first(
            where:{($0.incomingUser == user || $0.outgoingUser == user) && ($0.status == .calling || $0.status == .talk)})
    }
    
    func addCall(_ call : Call) {
        _callHistory.append(call)
    }
    
    func renewCallStatus(call: Call, with status: CallStatus) {
        _callHistory.removeAll(where: {$0.id == call.id})
        let newState =  Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: status)
        _callHistory.append(newState)
    }
}
