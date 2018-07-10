class ExpensesController < ApplicationController 

    def index
        expenses = if params[:sort] == 'largest_price'
                     Expense.all.order(:price).reverse_order
                     elsif params[:sort] == 'smallest_price'
                     Expense.all.order(:price)
                    elsif params[:sort] == 'largest_quantity'
                      Expense.all.order(:quantity).reverse_order
                    elsif params[:sort] == 'smallest_quantity'
                      Expense.all.order(:quantity)
                    elsif params[:sort] == 'newest'
                      Expense.all.order(:date).reverse_order
                    elsif params[:sort] == 'oldest'
                      Expense.all.order(:date)
                    elsif params[:sort] == 'quantity_range'
                       Expense.where(quantity: 2..10)
                    elsif params[:sort] == 'selected_price'
                        #Expense.where(quantity: [5.0,250.0,999999.0])
                        Expense.where(price:5.0).or(Expense.where(price:999999))
                    elsif params[:sort] == "show_only_title"
                        Expense.select("title")
                    elsif params[:sort] == "show_only_title_and_price"
                        Expense.select("title, price")
                    elsif params[:sort] == "distinct_price"
                        Expense.select(:price).distinct
                    elsif params[:sort] == "largest_price_3"
                        Expense.all.order(:price).reverse_order.limit(3)
                    else
                     Expense.all   
                   end 
        render json: expenses
    end

    def find_largest_price
       #largest_price = 0
       #largest = 1
      # for count in 1..Expense.count
          #  if Expense.find(id=count).price > largest_price
         #       largest_price = Expense.find(id=count).price 
        #        largest = count
       #     end
      # end
      # render json: Expense.find(id=largest)

      #add user, get user, destroy user, user controller, create relationships between user and expense
      #user will have name, email, password

       render json: Expense.maximum("price")
       
    end

    def find_smallest_price
        smallest_price = 9999999999
        smallest = 1
        for count in 1..Expense.count
             if Expense.find(id=count).price < smallest_price
                 smallest_price = Expense.find(id=count).price 
                 smallest = count
             end
        end
        render json: Expense.find(id=smallest)
    end
    
    def find_largest_quantity
        largest_quantity = 0
        largest = 1
        for count in 1..Expense.count
             if Expense.find(id=count).quantity > largest_quantity
                 largest_quantity = Expense.find(id=count).quantity
                 largest = count
             end
        end
        render json: Expense.find(id=largest)
     end

     def find_smallest_quantity
        smallest_quantity = 9999999999
        smallest = 1
        for count in 1..Expense.count
             if Expense.find(id=count).quantity < smallest_quantity
                 smallest_quantity = Expense.find(id=count).quantity
                 smallest = count
             end
        end
        render json: Expense.find(id=smallest)
     end

   

    def new
        render json: Expense.new
    end

    def create #Make sure that when you create an expense, it goes through a user 

     #   u.expenses.create({title: 'User 1 Expense', price: 100, quantity: 2, date: Date.today})

       # user =  User.find(params[:id])
          #expense = user.expenses.create(expense_params)
         expense = Expense.create(expense_params)
          render json: expense
    end
      

    def show #just one expense
        render json: Expense.find(params[:id])
    end

    def update 
        expense = Expense.find(params[:id])
        expense.update_attributes(expense_params)
        render json: expense
    end

    def destroy
        Expense.destroy(params[:id])
    end

    def expense_params
        params.require(:expense).permit(:title, :price, :quantity, :date, :user_id)
    end

     #filter by date, price, quantity

     def show_price
        render json: Expense.find(params[:id]).price
     end

     def search
     end

end