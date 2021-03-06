module RepositoryHelper

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |element|
      id == element.id
    end
  end

  def find_by_name(name)
    @collection.find do |element|
      element.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @collection.find_all do |element|
      element.name.upcase.include?(name.upcase)
    end
  end

  def find_all_with_description(description)
    @collection.find_all do |element|
      element.description.upcase.include?(description.upcase)
    end
  end

  def find_all_by_status(status)
    @collection.find_all do |element|
      element.status.upcase.include?(status.upcase)
    end
  end

  def find_all_by_price(price)
    @collection.find_all do |element|
      element.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @collection.find_all do |element|
      (range).member?(element.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @collection.find_all do |element|
      element.merchant_id == id
    end
  end

  def find_all_by_customer_id(id)
    @collection.find_all do |element|
      element.customer_id == id
    end
  end

  def create(attributes)
    class_instance = @class.new(attributes)
    class_instance.id = find_max_id + 1
    class_instance.created_at = Time.now
    @collection << class_instance
  end

  def update(id, attributes)
    if find_by_id(id)
      class_instance = find_by_id(id)
      if attributes[:name]
        class_instance.name = attributes[:name]
      end
      if attributes[:first_name]
        class_instance.first_name = attributes[:first_name]
      end
      if attributes[:last_name]
        class_instance.last_name = attributes[:last_name]
      end
      if attributes[:description]
        class_instance.description = attributes[:description]
      end
      if attributes[:unit_price]
        class_instance.unit_price  = attributes[:unit_price]
      end
      if attributes[:status]
        class_instance.status  = attributes[:status]
      end
      if attributes[:quantity]
        class_instance.quantity  = attributes[:quantity]
      end
      if attributes[:result]
        class_instance.result  = attributes[:result]
      end
      class_instance.updated_at = Time.now
    end
  end

  def find_max_id
    max_id_element = @collection.max_by do |element|
      element.id
    end
    max_id_element.id
  end

  def delete(id)
    element = find_by_id(id)
    @collection.delete(element)
  end

  def find_all_by_invoice_id(id)
    @collection.find_all do |element|
      element.invoice_id == id
    end
  end

  def inspect
     "#<#{self.class} #{@collection.size} rows>"
  end
end
