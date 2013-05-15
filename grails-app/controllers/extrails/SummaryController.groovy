package extrails

import java.util.Calendar
class SummaryController {

    def unreceiveMoneyList={

        def query = Event.where{
        	totalPrice!=receivedMoney
        }

        def results = query.list(sort:"date", order:"desc")

        [events:results]

    }

    def turnoverYearList={

    	def thisYear=(new Date()).getAt(Calendar.YEAR)
    	def years=thisYear..thisYear-2

    	def resultList=[]


    	years.each(){

    		params.year=it
    	  def query = Event.where {
				    year(date) == params.year
				}

        def results = query.list()
        def record=[year:it, totalMoney:results.totalPrice.sum()]
        if(record.totalMoney)
        	resultList << record

    	}


    	[turnoverYearList:resultList]

    }
}
