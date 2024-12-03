class PublicationsController < ApplicationController

  def index
    @publications = Publication.all
    @publication = Publication.new
    @comments = Comment.all
    @comment = Comment.new

  end

  def create
    # @comment = Comment.new
    # @comments = Comment.all
    @publication = Publication.new(publication_params)
    @publication.user = current_user
    # @publication.comments = @comments
    @publication.save
    # @publication.save
    # redirect_to publications_path
    # if @publication.save
    #   respond_to do |format|
    #     format.turbo_stream do
    #       render turbo_stream: turbo_stream.prepend(:publications, partial: "publications/publication",
    #         target: "publications",
    #         locals: { publication: @publication })
    #     end
    #     format.html { redirect_to publications_path }
    #   end
    # else
    #   render "publications/index", status: :unprocessable_entity
    # end
  end

  private

  def publication_params
    params.require(:publication).permit(
      :title,
      :content,
      :sport,
      :photo, as: :file
    )
  end
end
