class CommentsController < ApplicationController
  # no allow_unauthenticated_access here, so you must be signed in to reply
  before_action :set_item

  def create
    @comment = @item.comments.new(comment_params.merge(user: Current.user))

    if @comment.save
      redirect_to item_path(@item, anchor: "comment_#{@comment.id}"), notice: "Reply posted."
    else
      redirect_to item_path(@item, anchor: "replies"), alert: "Your reply can't be empty."
    end
  end

  def destroy
    comment = @item.comments.find(params[:id])

    if comment.user == Current.user || @item.user == Current.user
      comment.destroy
      redirect_to item_path(@item, anchor: "replies"), notice: "Reply deleted.", status: :see_other
    else
      redirect_to @item, alert: "You can only delete your own replies.", status: :see_other
    end
  end

  private
    def set_item
      @item = Item.find(params[:item_id])
    end

    def comment_params
      params.expect(comment: [ :body ])
    end
end
