class Task < ActiveRecord::Base

  def self.not_done
    where({:done => false})
  end
end
