class Order < ActiveRecord::Base
  belongs_to :address
  belongs_to :user


  def price
    quantity * 3
  end

  def vat
    price * 0.2
  end

  def total
    price + vat
  end
end
