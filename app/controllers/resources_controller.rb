require 'will_paginate'

class ResourcesController < ApplicationController
  unloadable

  def index
    @ress = IssueResource.paginate(:page => params[:page], :per_page => 20)
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def show
  end
end
