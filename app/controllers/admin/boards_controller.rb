class Admin::BoardsController < AdminController
  load_and_authorize_resource
  
  alias_method :board_url, :admin_board_url
  
  # GET /admin/boards
  # GET /admin/boards.json
  def index
    @boards = Board.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  # GET /admin/boards/1
  # GET /admin/boards/1.json
  def show
    redirect_to :action => "edit", :id => params[:id]
  end

  # GET /admin/boards/new
  # GET /admin/boards/new.json
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  # GET /admin/boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /admin/boards
  # POST /admin/boards.json
  def create
    @board = Board.create(params[:board])

    respond_to do |format|
      if @board.persisted?
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render json: @board, status: :created, location: @board }
      else
        format.html { render action: "new" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/boards/1
  # PUT /admin/boards/1.json
  def update
    #@board = Board.find(params[:id])
    return
    
    fields = params[:board]
    
    respond_to do |format|
      if @board.update_attributes(fields)
        @board.save!
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/boards/1
  # DELETE /admin/boards/1.json
  def destroy
    #@board = Board.find(params[:id])
    return
    @board.destroy

    respond_to do |format|
      format.html { redirect_to admin_boards_url }
      format.json { head :no_content }
    end
  end
end
