class SpotActivitiesController < ApplicationController
  # GET /spot_activities
  # GET /spot_activities.xml
  def index
    @spot_activities = SpotActivity.all :order => 'id DESC', :limit => 50
    @spot_activities_by_address = {}
    @spot_activities.each do |v|
      @spot_activities_by_address[v.address] ||= []
      @spot_activities_by_address[v.address] << v
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spot_activities }
    end
  end

  # GET /spot_activities/1
  # GET /spot_activities/1.xml
  def show
    @spot_activity = SpotActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spot_activity }
    end
  end

  # GET /spot_activities/new
  # GET /spot_activities/new.xml
  def new
    @spot_activity = SpotActivity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spot_activity }
    end
  end

  # GET /spot_activities/1/edit
  def edit
    @spot_activity = SpotActivity.find(params[:id])
  end

  # POST /spot_activities
  # POST /spot_activities.xml
  def create
    @spot_activity = SpotActivity.new(params[:spot_activity])

    respond_to do |format|
      if @spot_activity.save
        format.html { redirect_to(@spot_activity, :notice => 'SpotActivity was successfully created.') }
        format.xml  { render :xml => @spot_activity, :status => :created, :location => @spot_activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spot_activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spot_activities/1
  # PUT /spot_activities/1.xml
  def update
    @spot_activity = SpotActivity.find(params[:id])

    respond_to do |format|
      if @spot_activity.update_attributes(params[:spot_activity])
        format.html { redirect_to(@spot_activity, :notice => 'SpotActivity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spot_activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spot_activities/1
  # DELETE /spot_activities/1.xml
  def destroy
    @spot_activity = SpotActivity.find(params[:id])
    @spot_activity.destroy

    respond_to do |format|
      format.html { redirect_to(spot_activities_url) }
      format.xml  { head :ok }
    end
  end
end
