package extrails

class SummaryController {

    def unreceiveMoneyList={

        def query = Event.where{
        	totalPrice!=receivedMoney
        }

        def results = query.list(sort:"date")

        [events:results]

    }
}
