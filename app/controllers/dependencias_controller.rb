require 'will_paginate'

class DependenciasController < ApplicationController
  unloadable

  def index
    dependencias = Dependencia.all(:order => "nombre")
	@deps = dependencias.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    return render_403 unless User.current.admin?
    @dependencia = Dependencia.new
  end

  def create
    return render_403 unless User.current.admin?
    @dependencia = Dependencia.new(params[:dependencia])
    if @dependencia.save
      redirect_to :action => 'show', :id => @dependencia
    else
      render :action => 'new'
    end
  end

  def update
    return render_403 unless User.current.admin?
    @dependencia = Dependencia.find(params[:id])
    if @dependencia.update_attributes(params[:dependencia])
      redirect_to :action => 'show', :id => @dependencia
    else
      render :action => 'edit'
    end
  end

  def destroy
    return render_403 unless User.current.admin?
    Dependencia.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def edit
    return render_403 unless User.current.admin?
    @dependencia = Dependencia.find(params[:id])
  end

  def show
    @dep = Dependencia.find(params[:id])
	ress = IssueResource.find(:all, :conditions => [ "dependencia_id IN (?)", @dep.id])
	issues = ress.collect { |res| res.issue }
	@issues = issues.paginate(:page => params[:page], :per_page => 20)
  end
  
  def search
	qs = params[:s]
	qs = "%#{qs}%"
	dependencias = Dependencia.all(:conditions => ["nombre LIKE ? OR cod4 LIKE ? OR cod8 LIKE ? OR telefonos LIKE ? OR fax LIKE ? OR direccion LIKE ?", qs, qs, qs, qs, qs, qs], :order => "nombre")
	@deps = dependencias.paginate(:page => params[:page], :per_page => 20)
  end

end
