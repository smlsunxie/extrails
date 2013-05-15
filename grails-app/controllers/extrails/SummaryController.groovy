package extrails

import java.util.Calendar
class SummaryController {

		@Secured(['ROLE_OPERATOR'])
    def unreceiveMoneyList={

        def query = Event.where{
        	totalPrice!=receivedMoney
        }

        def results = query.list(sort:"date", order:"desc")

        [events:results]

    }

    @Secured(['ROLE_ADMIN'])
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


    	[resultList:resultList]

    }

    @Secured(['ROLE_ADMIN'])
    def turnoverMonthList={

    	def thisYear=params.year
    	def months=0..11

    	def resultList=[]


    	months.each(){

    		params.month=it
    	  def query = Event.where {
				    year(date) == params.year
				    month(date) == params.month
				}

        def results = query.list()
        def record=[year:params.year,month: it, totalMoney:results.totalPrice.sum()]
        if(record.totalMoney)
        	resultList << record

    	}


    	[resultList:resultList]

    }


}
