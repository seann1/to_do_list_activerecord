class Task < ActiveRecord::Base
  belongs_to(:list)

  def self.not_done
    where({:done => false})
  end
end
