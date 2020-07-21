require 'pry'

class VendorOrderObserver < ActiveRecord::Observer
  # This will only actually update the requisition to 'processing' status the
  # first time, we just ignore subsequent failures
  def after_process(vendor_order, transition)
    puts "SUPERMAN FLIES"

    return true if vendor_order.requisition.nil?

    vendor_order.requisition.process
    return true
  end
end
