class ItemsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :require_owner, only: %i[ edit update destroy ]

  # GET /items
  def index
    @counts = { lost: Item.where(status: "lost", resolved: false).count,
                found: Item.where(status: "found", resolved: false).count,
                returned: Item.where(resolved: true).count }

    @items = Item.newest_first.includes(:user, :comments).with_attached_photo
    @items = case params[:status]
    when *Item::STATUSES then @items.where(status: params[:status], resolved: false)
    when "returned"      then @items.where(resolved: true)
    when "mine"          then authenticated? ? @items.where(user: Current.user) : @items.none
    else @items
    end
    @items = @items.where("title ILIKE :q OR location ILIKE :q OR description ILIKE :q", q: "%#{Item.sanitize_sql_like(params[:q])}%") if params[:q].present?
  end

  # GET /items/1
  def show
    @comments = @item.comments.includes(:user).order(:created_at)
    @comment = Comment.new
  end

  # GET /items/new
  def new
    @item = Item.new(status: params[:status].presence_in(Item::STATUSES) || "lost", happened_on: Date.current)
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = Current.user.items.new(item_params)

    if @item.save
      redirect_to @item, notice: "Your item is posted. Fingers crossed! 🤞"
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      @item.photo.purge_later if params.dig(:item, :remove_photo) == "1" && params.dig(:item, :photo).blank?
      notice = case @item.saved_change_to_resolved
      when [ false, true ] then "Marked as returned. Nice work! 🎉"
      when [ true, false ] then "Item reopened."
      else "Item updated."
      end
      redirect_to @item, notice: notice, status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
    redirect_to items_path, notice: "Item deleted.", status: :see_other
  end

  private
    def set_item
      @item = Item.find(params.expect(:id))
    end

    def require_owner
      unless @item.user == Current.user
        redirect_to @item, alert: "You can only change your own items."
      end
    end

    def item_params
      params.expect(item: [ :title, :description, :status, :location, :happened_on, :resolved, :photo ])
    end
end
