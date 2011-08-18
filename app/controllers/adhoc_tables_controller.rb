class AdhocTablesController < ApplicationController
  # GET /adhoc_tables
  # GET /adhoc_tables.xml
  def index
    @adhoc_tables = AdhocTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adhoc_tables }
    end
  end

  # GET /adhoc_tables/1
  # GET /adhoc_tables/1.xml
  def show
    @adhoc_table = AdhocTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adhoc_table }
    end
  end

  # GET /adhoc_tables/new
  # GET /adhoc_tables/new.xml
  def new
    @adhoc_table = AdhocTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adhoc_table }
    end
  end

  # GET /adhoc_tables/1/edit
  def edit
    @adhoc_table = AdhocTable.find(params[:id])
  end

  # POST /adhoc_tables
  # POST /adhoc_tables.xml
  def create
    @adhoc_table = AdhocTable.new(params[:adhoc_table])

    respond_to do |format|
      if @adhoc_table.save
        format.html { redirect_to(@adhoc_table, :notice => 'Adhoc table was successfully created.') }
        format.xml  { render :xml => @adhoc_table, :status => :created, :location => @adhoc_table }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adhoc_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adhoc_tables/1
  # PUT /adhoc_tables/1.xml
  def update
    @adhoc_table = AdhocTable.find(params[:id])

    respond_to do |format|
      if @adhoc_table.update_attributes(params[:adhoc_table])
        format.html { redirect_to(@adhoc_table, :notice => 'Adhoc table was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adhoc_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adhoc_tables/1
  # DELETE /adhoc_tables/1.xml
  def destroy
    @adhoc_table = AdhocTable.find(params[:id])
    @adhoc_table.destroy

    respond_to do |format|
      format.html { redirect_to(adhoc_tables_url) }
      format.xml  { head :ok }
    end
  end
end
