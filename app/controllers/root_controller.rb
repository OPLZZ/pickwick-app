class RootController < ApplicationController
  def index
    if stale?(Time.now)
    end
  end
end
